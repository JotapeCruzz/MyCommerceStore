import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';


class newProduct extends StatelessWidget {
  const newProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'fab-product-register', //Sem conflito de heroTag
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add),
      label: const Text('Cadastrar produto (APENAS PARA VISUALIZAÇÃO!!!)'),
      onPressed: () =>
          Navigator.pushNamed(context, Routes.productRegister),
    );
  }
}
