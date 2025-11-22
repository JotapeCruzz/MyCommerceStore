import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// MUDANÇAS NOME DE USUARIO,NOME E SOBRENOME, DATA DE NASCIMENTO,CPF,TELEFONE,GENERO.

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool _loading = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    final data = doc.data();

    _nomeController.text = data?["nome"] ?? "";
    _telefoneController.text = data?["telefone"] ?? "";
    _emailController.text = user!.email ?? "";

    setState(() {});
  }

  Future<void> _salvar() async {
    setState(() => _loading = true);

    try {
      // Atualiza nome + telefone no Firestore
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
        "nome": _nomeController.text.trim(),
        "telefone": _telefoneController.text.trim(),
      });

      final novoEmail = _emailController.text.trim();

      // Atualiza email SOMENTE se mudou
      if (novoEmail != user!.email) {
        try {
          //await user!.updateEmail(novoEmail);// ERRO AQUI!!!

          // salva email também no Firestore
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .update({"email": novoEmail});
        } on FirebaseAuthException catch (e) {
          if (e.code == 'requires-recent-login') {
            final ok = await _reauthenticateWithPasswordDialog();

            if (ok) {
              //await user!.updateEmail(novoEmail); ERRO AQUI!!!

              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .update({"email": novoEmail});
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text("Não foi possível atualizar o email. Reautenticação necessária.")),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Erro ao atualizar o email: ${e.message}")),
            );
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Informações atualizadas!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  /// Diálogo para pedir a senha ao usuário e tentar reautenticar
  Future<bool> _reauthenticateWithPasswordDialog() async {
    final passwordController = TextEditingController();
    bool sucesso = false;

    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Reautenticação necessária"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Para alterar o email, digite sua senha atual:"),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );

    if (confirm != true) return false;

    try {
      final cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: passwordController.text.trim(),
      );

      final result = await user!.reauthenticateWithCredential(cred);

      if (result.user != null) sucesso = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Senha incorreta.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${e.message}")),
        );
      }
    }

    return sucesso;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: Colors.blue,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dados da Conta",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _campoML("Nome de usuário", _nomeController),
                  const SizedBox(height: 15),

                  _campoML("Telefone", _telefoneController,
                      teclado: TextInputType.phone),
                  const SizedBox(height: 15),

                  _campoML("Email", _emailController,
                      teclado: TextInputType.emailAddress),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _salvar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _campoML(String label, TextEditingController controller,
      {TextInputType teclado = TextInputType.text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}









