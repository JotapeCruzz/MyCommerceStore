import 'package:flutter/material.dart';

class EditarPagamentoPage extends StatelessWidget {
  const EditarPagamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final numeroCartaoController = TextEditingController();
    final nomeCartaoController = TextEditingController();
    final validadeController = TextEditingController();
    final cvvController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: numeroCartaoController,
              decoration: const InputDecoration(labelText: 'Número do Cartão'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nomeCartaoController,
              decoration: const InputDecoration(labelText: 'Nome no Cartão'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: validadeController,
              decoration: const InputDecoration(labelText: 'Validade (MM/AA)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cvvController,
              decoration: const InputDecoration(labelText: 'CVV'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pagamento atualizado com sucesso!')),
                );
              },
              child: const Text('Salvar Dados'),
            ),
          ],
        ),
      ),
    );
  }
}
