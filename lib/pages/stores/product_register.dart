import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

import '../../data/http/http_client.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import 'product_store.dart';

// controlador de dados do produto
class ProductRegisterController extends ChangeNotifier {
  String name = '';
  String description = '';
  String category = 'Roupas';
  String imageUrl = '';
  double price = 0;
  int stock = 0;
  bool featured = false;

  bool get canSave => name.isNotEmpty && price > 0;
}

// tela de cadastro de produto
class ProductRegisterScreen extends StatefulWidget {
  const ProductRegisterScreen({super.key});

  @override
  State<ProductRegisterScreen> createState() => _ProductRegisterScreenState();
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  final ProductStore store = ProductStore(
    repository: ProductRepository(client: HttpClient()),
  );

  final _formKey = GlobalKey<FormState>();
  final _ctrl = ProductRegisterController();

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();

  final _categories = const ['Roupas', 'Calçados', 'Acessórios', 'Eletrônicos'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _imageCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
        backgroundColor: Palette.appBarColor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dados do produto',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // nome
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) {
                  _ctrl.name = v;
                  setState(() {});
                },
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 10),

              // preço
              TextFormField(
                controller: _priceCtrl,
                decoration: const InputDecoration(
                  labelText: 'Preço (ex: 99.90)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (v) {
                  _ctrl.price = double.tryParse(v.replaceAll(',', '.')) ?? 0;
                  setState(() {});
                },
                validator: (v) {
                  final p = double.tryParse((v ?? '').replaceAll(',', '.'));
                  if (p == null || p <= 0) return 'Preço inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // categoria
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _ctrl.category,
                    isExpanded: true,
                    items: _categories
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _ctrl.category = v);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // descrição
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (v) => _ctrl.description = v,
              ),
              const SizedBox(height: 10),

              // imagem
              TextFormField(
                controller: _imageCtrl,
                decoration: const InputDecoration(
                  labelText: 'URL da imagem (opcional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _ctrl.imageUrl = v,
              ),
              const SizedBox(height: 10),

              // estoque
              TextFormField(
                controller: _stockCtrl,
                decoration: const InputDecoration(
                  labelText: 'Quantidade em estoque',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  _ctrl.stock = int.tryParse(v) ?? 0;
                  setState(() {});
                },
                validator: (v) {
                  final s = int.tryParse(v ?? '');
                  if (s == null || s < 0) return 'Quantidade inválida';
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // destaque
              CheckboxListTile(
                value: _ctrl.featured,
                onChanged: (v) {
                  _ctrl.featured = v ?? false;
                  setState(() {});
                },
                title: const Text('Marcar como destaque'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),

              // botão salvar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                  onPressed: !_ctrl.canSave
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enviando produto...'),
                              duration: Duration(seconds: 1),
                            ),
                          );

                          final produto = ProdutoModel(
                            id: 0,
                            title: _ctrl.name,
                            price: _ctrl.price,
                            description: _ctrl.description,
                            category: _ctrl.category,
                            img: _ctrl.imageUrl,
                          );

                          await store.createProduct(produto);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Produto salvo com sucesso!'),
                            ),
                          );

                          Navigator.pop(context);
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
