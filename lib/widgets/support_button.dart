import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

// esse botão pode ser usado em qualquer tela
class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.support_agent),
      label: const Text('Suporte'),
      onPressed: () {
        Navigator.pushNamed(context, Routes.support);
      },
    );
  }
}
