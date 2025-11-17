import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce Perfil',
      home: PerfilPage(),
    );
  }
}

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
                          onPressed: () {},
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EnderecosPage(),
                    ),
                  );
                },
              ),
            ),

            // --- SEÇÃO PAGAMENTOS ---
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Pagamentos'),
                subtitle: const Text('Cartões, Pix e outras formas de pagamento'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PagamentosPage(),
                    ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AjudaPage(),
                    ),
                  );
                },
              ),
            ),

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
                      builder: (_) => const PoliticaPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

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

// ===============================
// TELAS SECUNDÁRIAS
// ===============================
class EnderecosPage extends StatelessWidget {
  const EnderecosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Endereços')),
      body: const Center(
        child: Text(
          'Aqui você pode adicionar e gerenciar seus endereços de entrega.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PagamentosPage extends StatelessWidget {
  const PagamentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagamentos')),
      body: const Center(
        child: Text(
          'Gerencie seus cartões, Pix e outras formas de pagamento.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class AjudaPage extends StatelessWidget {
  const AjudaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Central de Ajuda')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Bem-vindo à Central de Ajuda!\n\n'
          'Aqui você encontrará respostas para dúvidas frequentes '
          'e poderá entrar em contato com nosso suporte.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PoliticaPage extends StatelessWidget {
  const PoliticaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Política de Privacidade')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Sua privacidade é importante para nós.\n\n'
          'Aqui explicamos como coletamos, usamos e protegemos seus dados pessoais.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
