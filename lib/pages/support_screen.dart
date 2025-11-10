import 'package:flutter/material.dart';

// controlador bem simples pra guardar os dados do form
class SupportController extends ChangeNotifier {
  String name = '';
  String email = '';
  String message = '';
  bool attachLogs = false;   // se o usuário quer anexar logs
  double satisfaction = 3;   // de 1 a 5

  // libera o botão "Enviar" só quando tudo tiver preenchido
  bool get canSend =>
      name.isNotEmpty && email.isNotEmpty && message.isNotEmpty;

  // simula o envio (tipo chamando uma API)
  Future<void> send() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

// tela de suporte simples (com form + chat button + checkbox + slider)
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>(); // uso isso pra validar o form
  final _controller = SupportController();  // guardo os dados aqui

  // controladores dos campos de texto
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    // limpando tudo quando a tela fechar
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold é a base da tela (appBar, body, etc.)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suporte'),
        backgroundColor: Colors.blue,
      ),

      // botão flutuante: chat ainda em desenvolvimento
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.support_agent),
        label: const Text('Chat'),
        onPressed: () {
          // só aviso por enquanto
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Chat ainda em desenvolvimento 😉')),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // preciso disso pra rodar os validators
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Envie sua solicitação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // campo: nome
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) {
                  _controller.name = v; // atualizo no controlador
                  setState(() {});       // atualiza a tela (habilitar botão)
                },
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Digite seu nome' : null,
              ),
              const SizedBox(height: 10),

              // campo: e-mail
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) {
                  _controller.email = v;
                  setState(() {});
                },
                validator: (v) =>
                    (v == null || !v.contains('@')) ? 'E-mail inválido' : null,
              ),
              const SizedBox(height: 10),

              // campo: mensagem
              TextFormField(
                controller: _msgCtrl,
                decoration: const InputDecoration(
                  labelText: 'Mensagem',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (v) {
                  _controller.message = v;
                  setState(() {});
                },
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Digite uma mensagem' : null,
              ),
              const SizedBox(height: 16),

              // checkbox: anexar logs
              CheckboxListTile(
                value: _controller.attachLogs,
                onChanged: (v) {
                  _controller.attachLogs = v ?? false;
                  setState(() {}); // só pra refletir na UI
                },
                title: const Text('Anexar logs de erro'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 8),

              // slider: satisfação (1 a 5)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Satisfação'),
                subtitle: Slider(
                  value: _controller.satisfaction,
                  min: 1,
                  max: 5,
                  divisions: 4, // 1,2,3,4,5
                  label: _controller.satisfaction.toStringAsFixed(0),
                  onChanged: (v) {
                    _controller.satisfaction = v;
                    setState(() {});
                  },
                ),
                trailing: Text(_controller.satisfaction.toStringAsFixed(0)),
              ),
              const SizedBox(height: 16),

              // botão enviar (só habilita quando o form tá 100%)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_controller.canSend
                      ? null
                      : () async {
                          // se os campos estiverem válidos, eu envio
                          if (_formKey.currentState!.validate()) {
                            // feedback: avisando que estou "enviando"
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enviando...'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            await _controller.send();

                            // feedback de sucesso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enviado com sucesso!'),
                              ),
                            );

                            // depois que enviou, posso voltar pra tela anterior
                            Navigator.pop(context);
                          }
                        },
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
