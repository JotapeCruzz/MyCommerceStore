import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFF574D4F),
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  // Botão para voltar à tela anterior.
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  const SizedBox(width: 8),

                  // Título centralizado.
                  const Expanded(
                    child: Text(
                      'Pagamento',
                      style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  // Logo exibida no canto direito.
                  Image.asset(
                    'assets/images/e_logo.png',
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
        ),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // QR Code gerado a partir do link de pagamento.
              QrImageView(
                data: linkPagamento,
                size: 200,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
              ),

              const SizedBox(height: 30),

              // Botão para copiar o código PIX.
              Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D9),
                  borderRadius: BorderRadius.circular(6),
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
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.copy, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Exibe o tempo restante em destaque.
              Text(
                formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF574D4F),
                ),
              ),

              const SizedBox(height: 8),

              // Texto abaixo do timer.
              const Text(
                'Tempo restante para pagamento',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF574D4F),
                ),
              ),

              const SizedBox(height: 40),

              // Botão para cancelar o pagamento.
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC9C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Cancelar Pagamento',
                    style: TextStyle(
                      color: Colors.black,
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
