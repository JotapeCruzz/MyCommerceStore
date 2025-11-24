// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class FavoritosPage extends StatefulWidget {
//   const FavoritosPage({super.key});


//   State<FavoritosPage> createState() => _FavoritosPageState();
// }

// class _FavoritosPageState extends State<FavoritosPage> {
//   List<Map<String, dynamic>> favoritos = [];

//   @override
//   Future<void> carregarFavoritos() async {
//     final snapshot = await FirebaseFirestore.instance.collection('favoritos').get();
//     setState(() {
//       favoritos = snapshot.docs.map((d) => d.data()).toList();
//     });
//   }

//   Future<void> adicionarFavorito(Map<String, dynamic> item) async {
//     await FirebaseFirestore.instance.collection('favoritos').add(item);
//     carregarFavoritos();
//   }

//   Future<List<dynamic>> buscarFakeStore() async {
//     final res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
//     return jsonDecode(res.body);
//   }

//   @override
//   void initState() {
//     super.initState();
//     carregarFavoritos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favoritos'),
//       ),
//       body: favoritos.isEmpty
//           ? const Center(
//               child: Text(
//                 'Nenhum item favoritado ainda',
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               itemCount: favoritos.length,
//               itemBuilder: (context, index) {
//                 final item = favoritos[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ListTile(
//                     title: Text(item['title']?.toString() ?? 'Sem título'),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         setState(() {
//                           favoritos.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

