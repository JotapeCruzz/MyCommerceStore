import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'listadress_screen.dart';

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
        isError: false,
      );
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
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, Routes.home);
          }, 
          icon: Icon(Icons.arrow_back_rounded)),
        backgroundColor: Palette.appBarColor,
        title: Text('Editar Endereço'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dados do Endereço",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              _campoML("Rua", ruaController),
              const SizedBox(height: 15),

              _campoML("Número", numeroController,
                  teclado: TextInputType.number, inputFormatters: [maskNumero]),
              const SizedBox(height: 15),

              _campoML("Cidade", cidadeController),
              const SizedBox(height: 15),

              _campoML("CEP", cepController,
                  teclado: TextInputType.number, inputFormatters: [maskCep]),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvarEndereco,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    widget.enderecoId == null
                        ? "Salvar Endereço"
                        : "Atualizar Endereço",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.listAdress);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text(
                    "Meus Endereços",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



