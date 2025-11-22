import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/cart_provider.dart'; // Correct import for CartProvider

class PagamentoScreen extends StatefulWidget {
  const PagamentoScreen({Key? key}) : super(key: key);

  @override
  State<PagamentoScreen> createState() => _PagamentoScreenState();
}

class _PagamentoScreenState extends State<PagamentoScreen> {
  static const int initialSeconds = 300;
  late int remainingSeconds;
  Timer? timer;

  final String linkPagamento = 'https://pagamento.pix/meupedido123';

  @override
  void initState() {
    super.initState();
    remainingSeconds = initialSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds <= 1) {
        t.cancel();
        setState(() => remainingSeconds = 0);
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final total = cart.total;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color(0xFF574D4F), // Matching the app's color scheme
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    const Text('Total', 
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              QrImageView(
                data: linkPagamento,
                size: 200,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: InkWell(
                  onTap: () {
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
                        )
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.copy, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF574D4F),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tempo restante para pagamento',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF574D4F),
                ),
              ),

              const SizedBox(height: 40),

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
