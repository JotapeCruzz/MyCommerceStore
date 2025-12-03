import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';


class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _usuarioController = TextEditingController();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nascimentoController = TextEditingController();
  final _cpfController = TextEditingController();

  // Variáveis
  String? _generoSelecionado;
  bool _loading = false;

  final user = FirebaseAuth.instance.currentUser;

  // Máscaras
  final maskTelefone = MaskTextInputFormatter(mask: '(##) #####-####');
  final maskCPF = MaskTextInputFormatter(mask: '###.###.###-##');
  final maskNascimento = MaskTextInputFormatter(mask: '##/##/####');

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  // ================= CARREGAR DADOS DO FIREBASE =================
  Future<void> _carregarDados() async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    final data = doc.data();

    if (data != null) {
      _usuarioController.text = data["usuario"] ?? "";
      _nomeController.text = data["nome"] ?? "";
      _sobrenomeController.text = data["sobrenome"] ?? "";
      _telefoneController.text = data["telefone"] ?? "";
      _cpfController.text = data["cpf"] ?? "";
      _nascimentoController.text = data["dataNascimento"] ?? "";
      _generoSelecionado = data["genero"];
    }

    setState(() {});
  }

  // ================= SALVAR FIREBASE =================
  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
        "usuario": _usuarioController.text.trim(),
        "nome": _nomeController.text.trim(),
        "sobrenome": _sobrenomeController.text.trim(),
        "telefone": _telefoneController.text.trim(),
        "cpf": _cpfController.text.trim(),
        "dataNascimento": _nascimentoController.text.trim(),
        "genero": _generoSelecionado,
      });
        showSnack(
        context: context,
        message: "Perfil atualizado com sucesso!",
        isError: false,
      );
      Navigator.pushReplacementNamed(context, Routes.perfilPage);

     
    } catch (e) {
        showSnack(
        context: context,
        message: "Erro ao atualizar perfil: $e",
        isError: true,
      );
      Navigator.pushReplacementNamed(context, Routes.perfilPage);
    } finally {
      setState(() => _loading = false);
    }
  }

  // =================== TELA ===================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.popAndPushNamed(context, Routes.perfilPage);
            }, 
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),),
          backgroundColor: Palette.appBarColor,
          title: Text('Editar Perfil', style: TextStyle(color: Palette.whiteColor, fontWeight: FontWeight.bold, fontSize: 24,),),
          centerTitle: true,
        ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dados Pessoais",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),

                    // Usuário
                    _campoML(
                      label: "Nome de usuário",
                      controller: _usuarioController,
                      validator: (v) =>
                          v!.isEmpty ? "Digite um nome de usuário" : null,
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: _campoML(
                            label: "Nome",
                            controller: _nomeController,
                            validator: (v) =>
                                v!.isEmpty ? "Digite seu nome" : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _campoML(
                            label: "Sobrenome",
                            controller: _sobrenomeController,
                            validator: (v) =>
                                v!.isEmpty ? "Digite seu sobrenome" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    _campoML(
                      label: "Data de nascimento",
                      controller: _nascimentoController,
                      inputFormatters: [maskNascimento],
                      teclado: TextInputType.number,
                      validator: (v) =>
                          v!.length < 10 ? "Data inválida" : null,
                    ),
                    const SizedBox(height: 15),

                    _campoML(
                      label: "CPF",
                      controller: _cpfController,
                      inputFormatters: [maskCPF],
                      teclado: TextInputType.number,
                      validator: (v) =>
                          v!.length < 14 ? "CPF inválido" : null,
                    ),
                    const SizedBox(height: 15),

                    _campoML(
                      label: "Telefone",
                      controller: _telefoneController,
                      inputFormatters: [maskTelefone],
                      teclado: TextInputType.phone,
                      validator: (v) =>
                          v!.length < 15 ? "Telefone inválido" : null,
                    ),
                    const SizedBox(height: 15),

                    // Dropdown Gênero
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: DropdownButtonFormField<String>(
                        initialValue: _generoSelecionado,
                        decoration: const InputDecoration(
                          labelText: "Gênero",
                          border: InputBorder.none,
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: "Masculino", child: Text("Masculino")),
                          DropdownMenuItem(
                              value: "Feminino", child: Text("Feminino")),
                          DropdownMenuItem(value: "Outro", child: Text("Outro")),
                        ],
                        onChanged: (v) => setState(() => _generoSelecionado = v),
                        validator: (v) =>
                            v == null ? "Selecione um gênero" : null,
                      ),
                    ),

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
            ),
    );
  }

  // ================= CAMPO PADRÃO ML =================
  Widget _campoML({
    required String label,
    required TextEditingController controller,
    TextInputType teclado = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: teclado,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}









