// Importa o pacote principal do Flutter, que contém os widgets e
// ferramentas necessárias para criar interfaces gráficas.
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Importa o arquivo 'app.dart', onde provavelmente está definida
// a classe MainApp, que representa o aplicativo principal.
import 'app.dart';

// Função principal do aplicativo Flutter.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Executa o aplicativo chamando o widget principal (MainApp).
  runApp(const MainApp());
}
