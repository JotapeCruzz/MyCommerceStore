import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String? policyText;
  final VoidCallback? onAccepted;

  const PrivacyPolicyScreen({
    super.key,
    this.policyText,
    this.onAccepted,
  });

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _agreed = false;

  String get _policyText => widget.policyText ?? _defaultPolicyText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Política de Privacidade',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              
              // CAIXA COM O TEXTO DA POLÍTICA
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: SelectableText(
                          _policyText,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // CHECKBOX
              CheckboxListTile(
                value: _agreed,
                activeColor: Colors.blue,
                title: const Text(
                  'Li e concordo com as Políticas de Privacidade',
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    _agreed = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 12),

              // BOTÃO PRINCIPAL
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _agreed
                      ? () {
                          widget.onAccepted?.call();
                          Navigator.pop(context, true);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Confirmar e Continuar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // PEQUENA MENSAGEM INFORMATIVA
              Row(
                children: const [
                  Icon(Icons.info_outline, size: 18, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Role o texto completo antes de confirmar.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}

// TEXTO PADRÃO
const String _defaultPolicyText = '''
Política de Privacidade 

Última atualização: 1 de Janeiro de 2025

1. Introdução
Bem-vindo ao nosso aplicativo de e-commerce. Esta Política de Privacidade descreve como coletamos, usamos, divulgamos e protegemos as suas informações quando você usa nosso app.

2. Informações que coletamos
Coletamos informações que você fornece diretamente (nome, e-mail, endereço), informações de pagamento quando você realiza compras, e dados de uso (por exemplo, itens visualizados, pesquisas e comportamento dentro do app).

3. Como usamos as informações
Usamos suas informações para processar pedidos, comunicar atualizações sobre a conta e entregas, personalizar recomendações, melhorar nossos serviços e cumprir obrigações legais.

4. Compartilhamento de dados
Podemos compartilhar dados com provedores de serviço (por exemplo, processadores de pagamento e empresas de entrega).

5. Segurança
Adotamos medidas para proteger seus dados, porém nenhum método digital é 100% seguro.

6. Seus direitos
Você pode solicitar acesso, correção ou exclusão de dados pelo suporte do app.

7. Retenção de dados
Guardamos seus dados somente pelo tempo necessário para as finalidades descritas.

8. Alterações
Podemos atualizar esta política e notificá-lo pelo app.

9. Contato
Dúvidas: suporte@seudominio.com
''';
