import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'listcard_screen.dart';

class EditarPagamentoPage extends StatefulWidget {
  final Map<String, dynamic>? cardData;
  final String? cardId;

  const EditarPagamentoPage({
    super.key,
    this.cardData,
    this.cardId,
  });

  @override
  State<EditarPagamentoPage> createState() => _EditarPagamentoPageState();
}

class _EditarPagamentoPageState extends State<EditarPagamentoPage> {
  final numeroController = TextEditingController();
  final nomeController = TextEditingController();
  final validadeController = TextEditingController();

  // Máscaras
  final maskNumeroCartao = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final maskValidade = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    if (widget.cardData != null) {
      numeroController.text = widget.cardData!["numero"] ?? "";
      nomeController.text = widget.cardData!["nome"] ?? "";
      validadeController.text = widget.cardData!["validade"] ?? "";

      // Atualiza as máscaras caso já tenha valor
      maskNumeroCartao.formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: numeroController.text));
      maskValidade.formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: validadeController.text));
    }
  }

  Future<void> _salvar() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    if (numeroController.text.trim().length < 19 ||
        nomeController.text.trim().isEmpty ||
        validadeController.text.trim().length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos corretamente")),
      );
      return;
    }

    final cardData = {
      "numero": numeroController.text.trim(),
      "nome": nomeController.text.trim(),
      "validade": validadeController.text.trim(),
    };

    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cards");

    if (widget.cardId == null) {
      await ref.add(cardData);
      Navigator.pop(context);
    } else {
      await ref.doc(widget.cardId).update(cardData);
      Navigator.pop(context);
    }
  }

  Widget _campoML(
    String label,
    TextEditingController controller, {
    TextInputType teclado = TextInputType.text,
    int? max,
    List<TextInputFormatter>? inputFormatters,
  }) {
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
        maxLength: max,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(widget.cardId == null ? "Adicionar Cartão" : "Editar Cartão"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dados do Cartão",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            _campoML(
              "Número do Cartão",
              numeroController,
              teclado: TextInputType.number,
              max: 19,
              inputFormatters: [maskNumeroCartao],
            ),
            const SizedBox(height: 15),

            _campoML("Nome do Titular", nomeController),
            const SizedBox(height: 15),

            _campoML(
              "Validade (MM/AA)",
              validadeController,
              teclado: TextInputType.number,
              max: 5,
              inputFormatters: [maskValidade],
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
                child: Text(
                  widget.cardId == null ? "Salvar Cartão" : "Atualizar Cartão",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ListaCartoesPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: const Text(
                  "Meus Cartões",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















