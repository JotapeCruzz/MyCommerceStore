import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'listadress_screen.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EditarEnderecoPage extends StatefulWidget {
  final Map<String, dynamic>? enderecoData;
  final String? enderecoId;

  const EditarEnderecoPage({
    super.key,
    this.enderecoData,
    this.enderecoId,
  });

  @override
  State<EditarEnderecoPage> createState() => _EditarEnderecoPageState();
}

class _EditarEnderecoPageState extends State<EditarEnderecoPage> {
  final formKey = GlobalKey<FormState>();

  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final cidadeController = TextEditingController();
  final cepController = TextEditingController();

  // Máscaras
  final maskNumero = MaskTextInputFormatter(
    mask: '#####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final maskCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    if (widget.enderecoData != null) {
      ruaController.text = widget.enderecoData!["rua"] ?? "";
      numeroController.text = widget.enderecoData!["numero"] ?? "";
      cidadeController.text = widget.enderecoData!["cidade"] ?? "";
      cepController.text = widget.enderecoData!["cep"] ?? "";

      // Atualiza as máscaras caso já tenha valor
      maskNumero.formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: numeroController.text));
      maskCep.formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: cepController.text));
    }
  }

  Future<void> _salvarEndereco() async {
    if (!formKey.currentState!.validate()) return;

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final data = {
      "rua": ruaController.text.trim(),
      "numero": numeroController.text.trim(),
      "cidade": cidadeController.text.trim(),
      "cep": cepController.text.trim(),
      
    };

    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("enderecos");

    if (widget.enderecoId == null) {
      ref.add(data);
    showSnack(
      context: context,
      message: "Endereço salvo com sucesso!",
      isError: false,);
      Navigator.pushReplacementNamed(context, Routes.listAdress);
    } else {
       ref.doc(widget.enderecoId).update(data);
      showSnack(
        context: context,
        message: "Endereço atualizado com sucesso!",
        isError: false,);
      Navigator.pushReplacementNamed(context, Routes.listAdress);
    }
  }

  Widget _campoML(
    String label,
    TextEditingController controller, {
    TextInputType teclado = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
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
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        validator: (v) => v == null || v.isEmpty ? "Campo obrigatório" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final ruaController = TextEditingController();
    final numeroController = TextEditingController();
    final cidadeController = TextEditingController();

    // Máscara para CEP
    final cepController = MaskedTextController(mask: '00000-000');

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              // RUA
              TextFormField(
                controller: ruaController,
                decoration: const InputDecoration(labelText: 'Rua'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite a rua' : null,
              ),
              const SizedBox(height: 10),

              // NÚMERO
              TextFormField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Digite apenas números';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // CIDADE
              TextFormField(
                controller: cidadeController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite a cidade' : null,
              ),
              const SizedBox(height: 10),

              // CEP COM MÁSCARA
              TextFormField(
                controller: cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o CEP';
                  }
                  if (value.length != 9) {
                    return 'CEP deve ter 8 números (XXXXX-XXX)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // BOTÃO SALVAR
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Endereço salvo com sucesso!'),
                      ),
                    );
                  }
                },
                child: const Text('Salvar Endereço'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

