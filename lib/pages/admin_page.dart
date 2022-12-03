import 'package:cliente_entradas/auth_service.dart';
import 'package:cliente_entradas/pages/publicar_noticia_page.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.add_moderator),
          title: Text('Administrador'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => PublicarNoticiaPage(),
                  );
                  Navigator.push(context, route);
                },
                child: Text('Publicar noticia'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: Text(
                  'Todo sobre eventos irá en burguer\nTrabajando para usted :)'),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AuthService().signOut(),
          child: Text("log out"),
        ));
  }
}
