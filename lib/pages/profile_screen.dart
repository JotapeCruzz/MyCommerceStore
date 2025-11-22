import 'package:ecommerce_my_store/pages/editpayment_screen.dart';
import 'package:ecommerce_my_store/pages/support_screen.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/pages/editadress_screen.dart';
import 'package:ecommerce_my_store/pages/policyprivace_screen.dart';
import 'package:ecommerce_my_store/pages/editprofile_screen.dart';
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';

class PerfilPage extends StatefulWidget {
  final User user;
  const PerfilPage({super.key, required this.user});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, Routes.home);
          }, 
          icon: Icon(Icons.arrow_back_rounded)),
        title: const Text('Meu Perfil'), 
        centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- CABEÇALHO ---
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.displayName ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(widget.user.email!),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => EditarPerfilPage()),
                            );
                          },
                          child: const Text('Editar Perfil'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- ENDEREÇOS ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Meus Endereços'),
                subtitle: const Text('Gerencie seus endereços de entrega'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditarEnderecoPage()),
                  );
                },
              ),
            ),

            // --- PAGAMENTOS (ATUALIZADO) ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Pagamentos'),
                subtitle: const Text('Cartões, Pix e outras formas de pagamento'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                // ⭐ AQUI ESTÁ A CORREÇÃO ⭐
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditarPagamentoPage()),
                  );

                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(result.toString())),
                    );
                  }
                },
              ),
            ),

            // --- CENTRAL DE AJUDA ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Central de Ajuda'),
                subtitle: const Text('Dúvidas frequentes e suporte'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SupportScreen()),
                  );
                },
              ),
            ),

            // --- PRIVACIDADE ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Política de Privacidade'),
                subtitle: const Text('Saiba como protegemos seus dados'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // --- BOTÃO SAIR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  AuthService().userLogout();
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair da Conta'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, Routes.home);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, Routes.favorites);
              break;
            case 2:
              break;
          }
        },
      ),
    );
  }
}

