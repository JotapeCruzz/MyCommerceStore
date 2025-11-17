import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey, // 🔹 Chave do formulário
            child: Column(
              children: [
                // ---------------- Nome -----------------
                LoginField(
                  labelText: "Nome",
                  controller: nomeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu nome";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // ---------------- Email -----------------
                LoginField(
                  labelText: "E-mail",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu e-mail";
                    }
                    if (!value.contains("@")) {
                      return "E-mail inválido";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                // ---------------- Telefone -----------------
                LoginField(
                  labelText: "Telefone",
                  controller: telefoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu telefone";
                    }
                    if (value.length < 9) {
                      return "Telefone inválido";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // -------------- Botão Salvar --------------
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 🔥 Só executa se todos os campos forem válidos
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Perfil atualizado com sucesso!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Salvar Alterações'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

