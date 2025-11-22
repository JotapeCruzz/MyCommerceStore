import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/pages/policyprivace_screen.dart';

/// Tela de Políticas e Privacidade para um app de e‑commerce.
/// - Mostra o texto rolável da política.
/// - Possui checkbox para confirmar leitura e concordância.
/// - Botão de confirmação fica habilitado somente após marcar o checkbox.
///
/// Uso:
/// Navigator.of(context).push(MaterialPageRoute(
///   builder: (_) => PrivacyPolicyScreen(onAccepted: () { /* ação */ }),
/// ));

class PrivacyPolicyScreen extends StatefulWidget {
  /// Texto da política. Se não informado, usa um texto padrão de exemplo.
  final String? policyText;

  /// Callback acionado quando o usuário aceitar a política.
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
        title: const Text('Políticas e Privacidade'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
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
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              CheckboxListTile(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
                title: const Text('Li e concordo com as Políticas e Privacidade'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _agreed
                          ? () {
                              // Ação padrão ao aceitar: fecha a tela e chama o callback
                              widget.onAccepted?.call();
                              Navigator.of(context).pop(true);
                            }
                          : null,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Confirmar e Continuar'),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Pequeno lembrete de acessibilidade / informação adicional
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Você pode rolar o texto para ler a política completa antes de confirmar.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Texto de exemplo em Português 
const String _defaultPolicyText = '''
Política de Privacidade 

Última atualização: 1 de Janeiro de 2025

1. Introdução
Bem‑vindo ao nosso aplicativo de e‑commerce. Esta Política de Privacidade descreve como coletamos, usamos, divulgamos e protegemos as suas informações quando você usa nosso app.

2. Informações que coletamos
Coletamos informações que você fornece diretamente (nome, e‑mail, endereço), informações de pagamento quando você realiza compras, e dados de uso (por exemplo, itens visualizados, pesquisas e comportamento dentro do app).

3. Como usamos as informações
Usamos suas informações para processar pedidos, comunicar atualizações sobre a conta e entregas, personalizar recomendações, melhorar nossos serviços e cumprir obrigações legais.

4. Compartilhamento de dados
Podemos compartilhar dados com provedores de serviço (por exemplo, processadores de pagamento, empresas de entrega) e, quando exigido por lei, com autoridades competentes.

5. Segurança
Adotamos medidas de segurança técnicas e administrativas para proteger suas informações, mas nenhum método de transmissão via internet é 100% seguro.

6. Seus direitos
Dependendo da sua jurisdição, você pode ter direitos como acessar, corrigir ou solicitar a exclusão dos seus dados. Entre em contato conosco pelo suporte do app para exercer esses direitos.

7. Retenção de dados
Reteremos seus dados pelo tempo necessário para cumprir as finalidades descritas nesta política ou conforme exigido por lei.

8. Alterações nesta política
Podemos atualizar esta Política de Privacidade. Notificaremos as alterações de forma adequada através do app.

9. Contato
Se tiver dúvidas ou solicitações sobre privacidade, entre em contato conosco pelo e‑mail suporte@seudominio.com.

---
Este texto é apenas um modelo — consulte um advogado ou responsável legal para garantir conformidade com leis aplicáveis (por exemplo, LGPD no Brasil, GDPR na UE, etc.).
''';
