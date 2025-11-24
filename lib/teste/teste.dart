
// // Importa o pacote base do Flutter (widgets) e o Material Design.
// import 'package:flutter/material.dart';

// // Importa shared_preferences para persistência local simples (chave-valor).
// import 'package:shared_preferences/shared_preferences.dart';

// // Importa o pacote http para fazer requisições HTTP (GET, POST).
// import 'package:http/http.dart' as http;

// // Importa utilitários de JSON para serializar/deserializar dados (Map/List).
// import 'dart:convert';


// // ============================
// // PONTO DE ENTRADA DO APLICATIVO
// // ============================

// void main() {
//   // runApp inicializa o framework Flutter e injeta o widget raiz na árvore.
//   runApp(const MyApp());
// }


// // ============================
// // EXEMPLO DE GERENCIADOR DE ESTADO: ChangeNotifier
// // ============================

// /// `CounterNotifier` é um gerenciador simples com `ChangeNotifier`.
// /// Embora não seja usado diretamente neste exemplo final, demonstra
// /// uma opção de estado compartilhado (além de ValueNotifier).
// class CounterNotifier extends ChangeNotifier {
//   // Valor privado do contador; por convenção, prefixado com `_`.
//   int _count = 0;

//   // Getter público para ler o valor atual.
//   int get count => _count;

//   // Método que incrementa o contador e avisa os ouvintes.
//   void increment() {
//     _count++;
//     notifyListeners(); // Dispara reconstruções nos widgets que escutam.
//   }
// }


// // ============================
// // VALUE NOTIFIER GLOBAL (ESTADO COMPARTILHADO SIMPLES)
// // ============================

// /// `globalCounter` é um estado compartilhado usando `ValueNotifier<int>`.
// /// - Armazena um inteiro (contador).
// /// - Widgets podem reagir às mudanças com `ValueListenableBuilder`
// ///   ou `ListenableBuilder`.
// final ValueNotifier<int> globalCounter = ValueNotifier<int>(0);


// // ============================
// // WIDGET RAIZ DO APP: MyApp
// // ============================

// /// `MyApp` é `StatefulWidget` para gerenciar o tema (claro/escuro)
// /// dinamicamente usando `setState` e persistência com `shared_preferences`.
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   // Cria o estado associado a este widget.
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// /// Classe de estado de `MyApp`.
// class _MyAppState extends State<MyApp> {
//   // Booleano que representa se o tema atual é escuro (`true`) ou claro (`false`).
//   bool _isDarkMode = false;

//   // Chamado uma vez quando o widget é inserido na árvore.
//   @override
//   void initState() {
//     super.initState();
//     _loadTheme(); // Carrega a preferência de tema salva localmente.
//   }

//   /// Carrega a preferência 'isDarkMode' do armazenamento local (async).
//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance(); // Obtém instância.
//     setState(() {
//       // Lê o valor salvo; se não existir, usa `false` (tema claro).
//       _isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     });
//   }

//   /// Alterna o tema e persiste o valor em `shared_preferences`.
//   void _toggleTheme(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isDarkMode', value); // Salva o booleano.
//     setState(() {
//       _isDarkMode = value; // Atualiza o estado para refletir na UI.
//     });
//   }

//   // Constrói o widget raiz `MaterialApp` com rotas nomeadas.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',                     // Título do app.
//       theme: _isDarkMode ? ThemeData.dark()      // Aplica tema escuro
//                         : ThemeData.light(),     // ou claro, conforme estado.
//       initialRoute: '/',                         // Rota inicial (Home).
//       routes: {
//         // Mapa de rotas nomeadas: centraliza as “strings” de rotas.
//         '/': (context) => HomeScreen(onThemeChanged: _toggleTheme),
//         '/form': (context) => const FormScreen(),
//         '/api': (context) => const ApiScreen(),
//         '/settings': (context) => SettingsScreen(onThemeChanged: _toggleTheme),
//         '/gestures': (context) => const GestureScreen(),

//         // NOVAS ROTAS:
//         '/post': (context) => const PostScreen(),      // Tela de POST HTTP.
//         '/counter': (context) => const CounterScreen() // Tela do contador global.
//       },
//     );
//   }
// }


// // ============================
// /*           HOME SCREEN
//    - Scaffold com AppBar, Drawer, BottomNavigationBar
//    - Exibe o contador global com ValueListenableBuilder
//    - Navega para telas via rotas nomeadas
// */
// // ============================

// class HomeScreen extends StatelessWidget {
//   // Callback para alterar o tema (vem de MyApp).
//   final Function(bool) onThemeChanged;

//   const HomeScreen({required this.onThemeChanged, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')), // Barra superior.

//       // Drawer: menu lateral com itens de navegação.
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(child: Text('Menu')), // Cabeçalho.

//             // Itens do menu que navegam para outras telas.
//             ListTile(
//               title: const Text('Formulário'),
//               onTap: () => Navigator.pushNamed(context, '/form'),
//             ),
//             ListTile(
//               title: const Text('API (GET)'),
//               onTap: () => Navigator.pushNamed(context, '/api'),
//             ),
//             ListTile(
//               title: const Text('Configurações (Tema)'),
//               onTap: () => Navigator.pushNamed(context, '/settings'),
//             ),
//             ListTile(
//               title: const Text('Gestos e Animação'),
//               onTap: () => Navigator.pushNamed(context, '/gestures'),
//             ),
//             // NOVO: tela de POST
//             ListTile(
//               title: const Text('POST (HTTP)'),
//               onTap: () => Navigator.pushNamed(context, '/post'),
//             ),
//             // NOVO: tela do contador global
//             ListTile(
//               title: const Text('Contador Global'),
//               onTap: () => Navigator.pushNamed(context, '/counter'),
//             ),
//           ],
//         ),
//       ),

//       // Corpo principal da Home.
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente.
//           children: [
//             const Text('Bem-vindo!'),

//             // Botão para navegar para o formulário enviando um parâmetro.
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/form',
//                   arguments: 'Olá da Home!', // Parâmetro que será lido na FormScreen.
//                 );
//               },
//               child: const Text('Ir para Formulário com parâmetro'),
//             ),

//             const SizedBox(height: 20), // Espaço visual.

//             // Exibe o valor do contador global e atualiza automaticamente
//             // sempre que `globalCounter.value` mudar (rebuild reativo).
//             ValueListenableBuilder<int>(
//               valueListenable: globalCounter,  // Notificador que será escutado.
//               builder: (context, value, child) {
//                 // `value` é o inteiro atual do contador.
//                 return Text(
//                   'Contador Global: $value',
//                   style: const TextStyle(fontSize: 18),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       // BottomNavigationBar com dois itens (Home e Config).
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
//         ],
//         onTap: (index) {
//           if (index == 1) Navigator.pushNamed(context, '/settings');
//         },
//       ),
//     );
//   }
// }


// // ============================
// // FORM SCREEN (entradas + setState)
// // ============================

// class FormScreen extends StatefulWidget {
//   const FormScreen({super.key});
//   @override
//   State<FormScreen> createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   // Estados locais dos widgets de formulário:
//   String? radioValue = 'Opção 1';         // Valor selecionado do grupo de rádios.
//   double sliderValue = 50;                 // Valor atual do Slider.
//   bool switchValue = false;                // Valor do Switch.
//   bool checkboxValue = false;              // Valor do Checkbox.
//   final textController = TextEditingController(); // Controller do TextField.

//   @override
//   Widget build(BuildContext context) {
//     // Recupera parâmetro enviado pela Home (se houver).
//     final String? param = ModalRoute.of(context)?.settings.arguments as String?;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Formulário')),

//       // ListView para permitir rolagem do conteúdo.
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           if (param != null) Text('Parâmetro recebido: $param'),

//           // Campo de texto com label.
//           TextField(
//             controller: textController,
//             decoration: const InputDecoration(labelText: 'Digite algo'),
//           ),

//           // Slider reativo (0 a 100).
//           Slider(
//             value: sliderValue,
//             min: 0,
//             max: 100,
//             onChanged: (val) => setState(() => sliderValue = val),
//           ),

//           // RadioListTile — item 1.
//           RadioListTile(
//             title: const Text('Opção 1'),
//             value: 'Opção 1',
//             groupValue: radioValue,
//             onChanged: (val) => setState(() => radioValue = val),
//           ),

//           // RadioListTile — item 2.
//           RadioListTile(
//             title: const Text('Opção 2'),
//             value: 'Opção 2',
//             groupValue: radioValue,
//             onChanged: (val) => setState(() => radioValue = val),
//           ),

//           // SwitchListTile.
//           SwitchListTile(
//             title: const Text('Ativar algo'),
//             value: switchValue,
//             onChanged: (val) => setState(() => switchValue = val),
//           ),

//           // CheckboxListTile.
//           CheckboxListTile(
//             title: const Text('Aceitar termos'),
//             value: checkboxValue,
//             onChanged: (val) => setState(() => checkboxValue = val ?? false),
//           ),

//           // Botão que mostra um SnackBar como feedback de envio.
//           ElevatedButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Formulário enviado!')),
//               );
//             },
//             child: const Text('Enviar'),
//           ),

//           const SizedBox(height: 12),

//           // Exibe valores atuais (reativos via setState).
//           Text(
//             'Valores: "${textController.text}", '
//             'Slider: ${sliderValue.toStringAsFixed(0)}, '
//             'Radio: $radioValue',
//           ),
//         ],
//       ),
//     );
//   }
// }


// // ============================
// // API SCREEN (GET + FutureBuilder)
// // ============================

// class ApiScreen extends StatelessWidget {
//   const ApiScreen({super.key});

//   /// Faz GET na API jsonplaceholder e retorna uma lista de nomes.
//   Future<List<String>> fetchData() async {
//     final response = await http.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/users'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List<dynamic>;
//       // Extrai o campo 'name' de cada item (Map) e retorna List<String>.
//       return data.map((e) => e['name'] as String).toList();
//     } else {
//       // Em caso de erro, lança exception que será tratada no FutureBuilder.
//       throw Exception('Erro ao carregar dados (status: ${response.statusCode})');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('API (GET)')),
//       body: FutureBuilder<List<String>>(
//         future: fetchData(), // Dispara a Future (requisição GET).
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Enquanto carrega, mostra indicador de progresso.
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Em caso de erro, exibe texto com a mensagem.
//             return Center(child: Text('Erro: ${snapshot.error}'));
//           } else {
//             // Sucesso: constrói a lista com os nomes.
//             final items = snapshot.data!;
//             return ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) => ListTile(
//                 leading: const Icon(Icons.person),
//                 title: Text(items[index]),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }


// // ============================
// // SETTINGS SCREEN (Tema com shared_preferences)
// // ============================

// class SettingsScreen extends StatelessWidget {
//   // Callback para alterar o tema (true = escuro, false = claro).
//   final Function(bool) onThemeChanged;

//   const SettingsScreen({required this.onThemeChanged, super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Deriva do Theme atual se está em modo escuro.
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Configurações')),
//       body: Center(
//         child: SwitchListTile(
//           title: const Text('Modo escuro'),
//           value: isDark,              // Estado atual do switch.
//           onChanged: onThemeChanged,  // Persiste e aplica via callback.
//         ),
//       ),
//     );
//   }
// }


// // ============================
// // GESTURE + ANIMAÇÕES SCREEN
// // ============================

// class GestureScreen extends StatefulWidget {
//   const GestureScreen({super.key});
//   @override
//   State<GestureScreen> createState() => _GestureScreenState();
// }

// // Mixin fornece `vsync` para o AnimationController.
// class _GestureScreenState extends State<GestureScreen>
//     with SingleTickerProviderStateMixin {
//   // Estados locais controlados via setState.
//   bool _isRed = true;   // Alterna cor em onTap.
//   double _size = 120;   // Alterna tamanho em onDoubleTap.
//   double _opacity = 1;  // Alterna opacidade em onLongPress.

//   // Animação explícita: controller + tween de escala (pulse).
//   late final AnimationController _controller;
//   late final Animation<double> _scale;

//   @override
//   void initState() {
//     super.initState();
//     // Cria o controller com duração curta para feedback rápido.
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 180),
//       reverseDuration: const Duration(milliseconds: 180),
//     );

//     // Define a animação de escala (1.0 → 1.08) com easing.
//     _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
