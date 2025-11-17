import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';

class EditarEnderecoPage extends StatefulWidget {
  const EditarEnderecoPage({super.key});

  @override
  State<EditarEnderecoPage> createState() => _EditarEnderecoPageState();
}

class _EditarEnderecoPageState extends State<EditarEnderecoPage> {
  final _formKey = GlobalKey<FormState>();

  final cepController = MaskedTextController(mask: '00000-000'); // MÁSCARA AQUI
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Endereço")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ------------------ CEP ------------------
                LoginField(
                  labelText: "CEP",
                  controller: cepController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Remove máscara antes de validar
                    final clean = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? "";

                    if (clean.length != 8) {
                      return "Informe um CEP válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ------------------ Rua ------------------
                LoginField(
                  labelText: "Rua",
                  controller: ruaController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Digite o nome da rua";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ------------------ Número ------------------
                LoginField(
                  labelText: "Número",
                  controller: numeroController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Informe o número";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ------------------ Bairro ------------------
                LoginField(
                  labelText: "Bairro",
                  controller: bairroController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Digite o bairro";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ------------------ Cidade ------------------
                LoginField(
                  labelText: "Cidade",
                  controller: cidadeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Digite a cidade";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ------------------ Estado ------------------
                LoginField(
                  labelText: "Estado (UF)",
                  controller: estadoController,
                  validator: (value) {
                    if (value == null || value.trim().length != 2) {
                      return "Informe a UF (Ex: SP)";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ------------------ Botão Salvar ------------------
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Endereço atualizado com sucesso!"),
                        ),
                      );
                    }
                  },
                  child: const Text("Salvar Endereço"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

