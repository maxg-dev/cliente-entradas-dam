import 'package:cliente_entradas/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarEventoPage extends StatefulWidget {
  const AgregarEventoPage({super.key});

  @override
  State<AgregarEventoPage> createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  DateTime fechaSeleccionada = DateTime.now();
  var fFecha = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kColorFondo),
      appBar: AppBar(
        backgroundColor: Color(kColorPrimario),
        title:
            Text('Agregar evento', style: TextStyle(color: Color(kColorFondo))),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            TextFormField(
              controller: nombreController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Nombre del evento',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            Divider(color: Color(kColorFondo)),
            TextFormField(
              controller: direccionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Dirección del evento',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            Divider(color: Color(kColorFondo)),
            TextFormField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Precio entrada',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            Divider(color: Color(kColorFondo)),
            Row(
              children: [
                Text(
                  'Fecha del evento: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  fFecha.format(fechaSeleccionada),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(MdiIcons.calendar),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      locale: Locale('es', 'ES'),
                    ).then((fecha) {
                      setState(() {
                        fechaSeleccionada = fecha ?? fechaSeleccionada;
                      });
                    });
                  },
                ),
              ],
            ),
            Divider(color: Color(kColorFondo)),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(Color(kColorFondo)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(kColorBoton))),
                onPressed: () {},
                child: Text('Agregar'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
