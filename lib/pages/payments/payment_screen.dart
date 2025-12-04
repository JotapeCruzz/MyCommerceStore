import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import '../../providers/cart_provider.dart'; // Importa o provider do carrinho.

// Tela de pagamento usando StatefulWidget para manipular timer e estado.
class PagamentoScreen extends StatefulWidget {
  const PagamentoScreen({super.key});

  @override
  State<PagamentoScreen> createState() => _PagamentoScreenState();
}

// Estado da tela de pagamento.
class _PagamentoScreenState extends State<PagamentoScreen> {
  // Valor inicial do tempo do timer (300 segundos = 5 minutos).
  static const int initialSeconds = 300;

  // Variável que armazena o tempo restante.
  late int remainingSeconds;

  // Objeto Timer usado para contar o tempo.
  Timer? timer;

  // Link gerado para o pagamento via PIX.
  final String linkPagamento = 'https://pagamento.pix/meupedido123';

  @override
  void initState() {
    super.initState();
    // Define o tempo inicial.
    remainingSeconds = initialSeconds;
    // Inicia o timer.
    startTimer();
  }

  // Inicia o timer que reduz o tempo a cada segundo.
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      // Verifica se o tempo acabou.
      if (remainingSeconds <= 1) {
        t.cancel();
        setState(() => remainingSeconds = 0);
      } else {
        // Reduz o contador em 1 segundo.
        setState(() => remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    // Cancela o timer ao sair da tela.
    timer?.cancel();
    super.dispose();
  }

  // Formata o tempo restante no formato MM:SS.
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o provider do carrinho.
    final cart = context.watch<CartProvider>();

    // Calcula o total do carrinho.
    final total = cart.total;

    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar customizada.
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Pagamento',
          style: TextStyle(
            color: Palette.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Palette.appBarColor,
        centerTitle: true,
      ),

      // Corpo da tela com rolagem.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Caixa que exibe o valor total da compra.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Palette.appBarColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.appBarColor, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Palette.gradient3,
                      ),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Palette.appBarColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // QR Code gerado a partir do link de pagamento.
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: QrImageView(
                  data: linkPagamento,
                  size: 200,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Botão para copiar o código PIX.
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.appBarColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    // Exibe mensagem informando que o link foi copiado.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Link de pagamento copiado!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Copiar código PIX',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.copy, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Container com timer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Palette.appBarColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.appBarColor, width: 1.5),
                ),
                child: Column(
                  children: [
                    Text(
                      formatTime(remainingSeconds),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Palette.appBarColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tempo restante para pagamento',
                      style: TextStyle(
                        fontSize: 14,
                        color: Palette.gradient3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Botão para cancelar o pagamento.
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  child: const Text(
                    'Cancelar Pagamento',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
