import 'package:cliente_entradas/auth_service.dart';
import 'package:cliente_entradas/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text("Hola! " + FirebaseAuth.instance.currentUser!.displayName!)),
      body: index == 0 ? listarNoticias() : listarEntradas(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AuthService().signOut(),
        child: Text("Salir"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Entradas',
          )
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> listarNoticias() {
    return StreamBuilder(
      stream: FirestoreService().noticias(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var noticias = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListTile(
                leading: Icon(Icons.newspaper),
                title: Text(noticias['titulo']),
                subtitle: Text(noticias['cuerpo']),
              ),
            );
          },
        );
      },
    );
  }

  Center listarEntradas() {
    return Center(
      child: Text('Entradas está en trabajo'),
    );
  }
}
