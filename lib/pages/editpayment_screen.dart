import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';

class EditarPagamentoPage extends StatefulWidget {
  const EditarPagamentoPage({super.key});

  @override
  State<EditarPagamentoPage> createState() => _EditarPagamentoPageState();
}

class _EditarPagamentoPageState extends State<EditarPagamentoPage> {
  final _formKey = GlobalKey<FormState>();

  final numeroCartaoController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final nomeCartaoController = TextEditingController();
  final validadeController = MaskedTextController(mask: '00/00');
  final cvvController = MaskedTextController(mask: '000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Pagamento')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey, // 🔥 agora temos validação
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---------------- Número do cartão ----------------
                LoginField(
                  labelText: "Número do Cartão",
                  controller: numeroCartaoController,
                  validator: (value) {
                    if (value == null || value.trim().length < 19) {
                      return "Informe um cartão válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ---------------- Nome ----------------
                LoginField(
                  labelText: "Nome no Cartão",
                  controller: nomeCartaoController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Digite o nome do cartão";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ---------------- Validade ----------------
                LoginField(
                  labelText: "Validade (MM/AA)",
                  controller: validadeController,
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return "Informe uma validade válida";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // ---------------- CVV ----------------
                LoginField(
                  labelText: "CVV",
                  controller: cvvController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return "CVV inválido";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ---------------- Botão ----------------
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Método de pagamento salvo com sucesso!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Salvar Dados'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


