import 'package:flutter/material.dart';

class EditarEnderecoPage extends StatelessWidget {
  const EditarEnderecoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ruaController = TextEditingController();
    final numeroController = TextEditingController();
    final cidadeController = TextEditingController();
    final cepController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Endereço')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ruaController,
              decoration: const InputDecoration(labelText: 'Rua'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numeroController,
              decoration: const InputDecoration(labelText: 'Número'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Endereço salvo com sucesso!')),
                );
              },
              child: const Text('Salvar Endereço'),
            ),
          ],
        ),
      ),
    );
  }
}
