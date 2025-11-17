import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:ecommerce_my_store/pages/policyprivace_screen.dart';

// ===============================
// TELA PRINCIPAL DE PERFIL
// ===============================
class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        centerTitle: true,
        backgroundColor: Palette.appBarColor
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- CABEÇALHO COM DADOS DO USUÁRIO ---
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
                        const Text(
                          'Lucas Lima',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('lucas@email.com'),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.editProfile,
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

            // --- SEÇÃO ENDEREÇOS ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Meus Endereços'),
                subtitle: const Text('Gerencie seus endereços de entrega'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.editAdress,
                  );
                },
              ),
            ),

            // --- SEÇÃO PAGAMENTOS ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Cartões'),
                subtitle: const Text('Gerencie seus cartões.'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.editPayment,
                  );
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
                  Navigator.pushNamed(
                    context,
                    Routes.support,
                  );
                },
              ),
            ),

            // --- POLÍTICA DE PRIVACIDADE ---
            // --- POLÍTICA DE PRIVACIDADE ---
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
        MaterialPageRoute(
          builder: (_) => PrivacyPolicyScreen(
            onAccepted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Você aceitou as políticas de privacidade.')),
              );
            },
          ),
        ),
      );
    },
  ),
),


            // --- BOTÃO DE SAIR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Sair da Conta'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}




 



