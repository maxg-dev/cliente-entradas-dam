import 'package:cliente_entradas/constants.dart';
import 'package:cliente_entradas/pages/customer_tabs/vista_entradas.dart';
import 'package:cliente_entradas/pages/customer_tabs/vista_eventos.dart';
import 'package:cliente_entradas/pages/customer_tabs/vista_noticias.dart';
import 'package:cliente_entradas/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int index = 0;
  final List<dynamic> paginas = [
    VistaNoticias(),
    VistaEventos(),
    VistaEntradas(),
  ];
  var fnumber =
      NumberFormat.currency(locale: 'es-CL', decimalDigits: 0, symbol: '');
  var fFecha = DateFormat('dd-MM-yyyy');
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
      body: paginas[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        fixedColor: Color(kColorPrimario),
        unselectedItemColor: Color(kColorFondo),
        onTap: (value) => setState(() {
          index = value; // hacer lista para control de tabs
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
}
