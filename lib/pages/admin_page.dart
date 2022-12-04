import 'package:cliente_entradas/constants.dart';
import 'package:cliente_entradas/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/firestore_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool status = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController tituloController = TextEditingController();
  TextEditingController cuerpoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(kColorFondo),
          appBar: AppBar(
            backgroundColor: Color(kColorPrimario),
            leading: Icon(
              Icons.add_moderator,
              color: Color(kColorFondo),
            ),
            title: Text(
              'Administrador',
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
                    AuthService().signOut();
                  }
                },
              ),
            ],
            bottom: TabBar(tabs: [
              Tab(icon: Icon(MdiIcons.billboard), text: 'Eventos'),
              Tab(icon: Icon(MdiIcons.publish), text: 'Publicar noticia'),
            ]),
          ),
          body: TabBarView(
            children: [
              vistaListaEventos(),
              vistaPublicarNoticia(),
            ],
          )),
    );
  }

  Padding vistaPublicarNoticia() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            Divider(),
            TextFormField(
              maxLines: 5,
              controller: cuerpoController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Cuerpo',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(Color(kColorFondo)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(kColorBoton))),
                onPressed: () {
                  FirestoreService().agregar(
                    tituloController.text.trim(),
                    cuerpoController.text.trim(),
                  );
                  setState(() {
                    tituloController.text = '';
                    cuerpoController.text = '';
                  });
                },
                child: Text('Publicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column vistaListaEventos() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              listTileEvento('Concierto Daddy Yankee', 'Movistar arena',
                  '18 de octubre', 130),
              listTileEvento(
                  'Concierto Shakira', 'Espacio riesco', '30 de diciembre', 25),
              listTileEvento('Concierto Michi', 'Mi casa', '3 de diciembre', 1),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          alignment: AlignmentDirectional.bottomEnd,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color(kColorBoton))),
              onPressed: (() {}),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.add),
                  Text(' Agregar nuevo evento'),
                ],
              )),
        )
      ],
    );
  }

  Slidable listTileEvento(titulo, direccion, fecha, vendidas) {
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${direccion} - ${fecha}',
              style: TextStyle(color: Color(kColorSecundario)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 1, top: 5),
              child: Text(
                'Entradas vendidas: ${vendidas}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        trailing: Switch(
          activeColor: Color(kColorPrimario),
          inactiveThumbColor: Color(kColorFondo),
          value: status,
          onChanged: (value) {
            setState(() => status = value);
          },
        ),
      ),
    );
  }
}
