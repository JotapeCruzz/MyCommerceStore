import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 
import 'firebase_options.dart';

// Providers
import 'package:ecommerce_my_store/providers/cart_provider.dart';
import 'package:ecommerce_my_store/providers/favorites_provider.dart';  

// Services
import 'package:ecommerce_my_store/services/favorites_service.dart';  

// App principal
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        
      
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(FavoritesService()),
        ),

        // se tiver outros providers, coloque aqui
      ],
      child: MainApp(),
    ),
  );
}



