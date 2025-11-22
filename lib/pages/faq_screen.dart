import 'package:flutter/material.dart'; // importa o pacote principal do Flutter

// Essa é a tela de perguntas frequentes (FAQ)
class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key}); // construtor da tela (usa "const" pra otimizar desempenho)

  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura base da tela (tem appbar, body, etc)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas Frequentes'), // título que aparece no topo da tela
      ),

      // O corpo da tela é uma lista rolável de perguntas e respostas
      body: ListView(
        padding: const EdgeInsets.all(16), // espaçamento nas bordas da tela
        children: const [
          // Cada QuestionItem é um "card" com uma pergunta e resposta
          QuestionItem(
            question: 'Como faço para criar uma conta?',
            answer:
                'Para criar uma conta, clique no botão de registro na tela inicial e preencha o formulário com suas informações.',
          ),
          QuestionItem(
            question: 'Esqueci minha senha. O que devo fazer?',
            answer:
                'Clique em "Esqueci minha senha" na tela de login e siga as instruções para redefinir sua senha.',
          ),
          QuestionItem(
            question: 'Como posso entrar em contato com o suporte?',
            answer:
                'Você pode entrar em contato com o suporte através do e-mail suporte@mystore.com ou pela tela de Suporte no app.',
          ),
          QuestionItem(
            question: 'Como acessar o chat?',
            answer:
                'Você pode entrar em contato com o suporte através do botão "chat" dentro da central de ajuda.',
          ),
          QuestionItem(
            question: 'Qual o prazo de entrega dos produtos?',
            answer:
                'O prazo de entrega varia conforme a localização e o método de envio escolhido. Geralmente, leva entre 3 a 7 dias úteis.',
          ),
          QuestionItem(
            question: 'Como posso rastrear meu pedido?',
            answer:
                'Após o envio, você receberá um código de rastreamento por e-mail que poderá ser usado para acompanhar o status do seu pedido.',
          ),
          QuestionItem(
            question: 'Quanto custa o frete?',
            answer:
                'O custo do frete depende do peso do produto e da localização de entrega. O valor será calculado no momento do checkout.',
          ),
          QuestionItem(
            question: 'Como funciona a política de devolução?',
            answer:
                'Você pode devolver produtos em até 30 dias após o recebimento, desde que estejam em condições originais. Entre em contato com o suporte para iniciar o processo de devolução.',
          ),
          QuestionItem(
            question: 'Quais formas de pagamento são aceitas?',
            answer:
                'Aceitamos cartões de crédito, débito, boleto bancário e pagamentos via PayPal.',
          ),
          QuestionItem(
            question: 'Posso alterar meu pedido após finalizá-lo?',
            answer:
                'Após a finalização do pedido, não é possível fazer alterações. No entanto, você pode cancelar o pedido e fazer um novo, se necessário.',
          ),
          QuestionItem(
            question: 'Qual a garantia dos produtos?',
            answer:
                'Todos os nossos produtos possuem garantia mínima de 90 dias contra defeitos de fabricação.',
          ),
          QuestionItem(
            question: 'Quem são vocês?',
            answer:
                'Somos uma empresa dedicada a oferecer os melhores produtos e serviços aos nossos clientes, com foco em qualidade e satisfação.',
          ),
          QuestionItem(
            question: 'Vocês tem loja física?',
            answer:
                'Atualmente, operamos exclusivamente online para oferecer preços mais competitivos e uma maior variedade de produtos.',
          ),
          QuestionItem(
            question: 'Vocês entregam internacionalmente?',
            answer:
                'No momento, nossas entregas são realizadas apenas dentro do território nacional.',
          ),
        ],
      ),
    );
  }
}

// Essa classe cria o componente que mostra cada pergunta e resposta separadamente
class QuestionItem extends StatelessWidget {
  // variáveis que vão guardar a pergunta e a resposta
  final String question;
  final String answer;

  // construtor da classe que obriga a passar "question" e "answer"
  const QuestionItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    // Card deixa o fundo com uma "caixinha" com bordas suaves
    return Card(
      margin: const EdgeInsets.only(bottom: 12), // espaço entre um card e outro
      child: ExpansionTile(
        // ExpansionTile é um widget que expande e recolhe conteúdo (perguntas e respostas)
        title: Text(
          question, // mostra o texto da pergunta
          style: const TextStyle(fontWeight: FontWeight.w600), // deixa o texto em negrito
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16), // espaçamento interno do conteúdo
        children: [
          Text(answer), // mostra a resposta quando o usuário toca pra expandir
        ],
      ),
    );
  }
}
