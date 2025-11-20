import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'editadress_screen.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class ListaEnderecosPage extends StatelessWidget {
  const ListaEnderecosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Endereços"),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("enderecos")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text("Nenhum endereço cadastrado."),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final id = docs[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text("${data["rua"]}, ${data["numero"]}"),
                  subtitle: Text("${data["cidade"]} • CEP: ${data["cep"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDITAR
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditarEnderecoPage(
                                enderecoData: data,
                                enderecoId: id,
                              ),
                            ),
                          );
                        },
                      ),

                      // EXCLUIR
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .collection("enderecos")
                              .doc(id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
