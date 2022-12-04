import 'package:cliente_entradas/constants.dart';
import 'package:cliente_entradas/services/auth_service.dart';
import 'package:cliente_entradas/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'detalle_entrada_page.dart';

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
      backgroundColor: Color(kColorFondo),
      appBar: AppBar(
        backgroundColor: Color(kColorPrimario),
        leading: Icon(MdiIcons.faceMan, color: Color(kColorFondo)),
        title: Text(
          "Hola! " + FirebaseAuth.instance.currentUser!.displayName!,
          style: TextStyle(color: Color(kColorFondo)),
        ),
        actions: [
          PopupMenuButton(
            color: Color(kColorFondo),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 10,
                value: 'logout',
                child: Text('Cerrar Sesión'),
              ),
            ],
            onSelected: (opcionSeleccionada) {
              if (opcionSeleccionada == 'logout') {
                AuthService().signOutGoogle();
              }
            },
          ),
        ],
      ),
      body: index == 0
          ? listarNoticias()
          : index == 1
              ? listarEventos()
              : listarEntradas(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        fixedColor: Color(kColorPrimario),
        unselectedItemColor: Color(kColorFondo),
        onTap: (value) => setState(() {
          index = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.newspaper),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.billboard),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.ticket),
            label: 'Entradas',
          )
        ],
      ),
    );
  }

  ListView listarEntradas() {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        listTileEntrada(1, 'Concierto Shakira', 'Espacio riesco'),
        listTileEntrada(3, 'Concierto Daddy Yankee', 'Hola')
      ],
    );
  }

  ListTile listTileEntrada(numero, titulo, direccion) {
    return ListTile(
      title: Text(titulo, style: TextStyle(color: Color(kColorPrimario))),
      subtitle:
          Text(direccion, style: TextStyle(color: Color(kColorSecundario))),
      leading: Icon(MdiIcons.ticketConfirmation, color: Color(kColorPrimario)),
      trailing: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(kColorSecundario)),
            foregroundColor: MaterialStatePropertyAll(Color(kColorFondo))),
        onPressed: () {
          // Ver detalle de una entrada
          MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => DetalleEntradaPage(numero));
          Navigator.push(context, route);
        },
        child: Icon(MdiIcons.contain),
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
                leading: Icon(
                  Icons.newspaper,
                  color: Color(kColorPrimario),
                ),
                title: Text(
                  noticias['titulo'],
                  style: TextStyle(color: Color(kColorPrimario)),
                ),
                subtitle: Text(
                  noticias['cuerpo'],
                  style: TextStyle(color: Color(kColorSecundario)),
                ),
              ),
            );
          },
        );
      },
    );
  }

  ListView listarEventos() {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        listTileEvento(
            'Concierto Daddy Yankee', 'Movistar arena', '18 de octubre'),
        listTileEvento(
            'Concierto Shakira', 'Espacio riesco', '30 de diciembre'),
        listTileEvento('Concierto Michi', 'Mi casa', '3 de diciembre'),
      ],
    );
  }

  Slidable listTileEvento(titulo, direccion, fecha) {
    return Slidable(
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Color(kColorTernario),
            onPressed: (context) {},
            icon: MdiIcons.delete,
            label: 'Borrar',
          ),
          SlidableAction(
            backgroundColor: Color(kColorSecundario),
            onPressed: (context) {},
            icon: Icons.add,
            label: 'Editar',
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          MdiIcons.ticket,
          color: Color(kColorPrimario),
        ),
        title: Text(
          titulo,
          style: TextStyle(color: Color(kColorPrimario)),
        ),
        subtitle: Text(
          '${direccion} - ${fecha}',
          style: TextStyle(color: Color(kColorSecundario)),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color(kColorSecundario)),
              foregroundColor: MaterialStatePropertyAll(Color(kColorFondo))),
          onPressed: () {
            // Comprar una entrada al evento
          },
          child: Icon(MdiIcons.cart),
        ),
      ),
    );
  }
}
