import 'package:cliente_entradas/constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetalleEntradaPage extends StatelessWidget {
  final int numeroEntrada;
  const DetalleEntradaPage(this.numeroEntrada, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kColorFondo),
      appBar: AppBar(
          title: Text(
            'Detalle entrada',
            style: TextStyle(color: Color(kColorFondo)),
          ),
          backgroundColor: Color(kColorPrimario)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Informacion evento: ... '),
            Text('Nombre cliente: ...'),
            Text('Numero de entrada: ${this.numeroEntrada}'),
            QrImage(
              eyeStyle: QrEyeStyle(
                  color: Color(kColorPrimario), eyeShape: QrEyeShape.square),
              backgroundColor: Color(kColorFondo),
              dataModuleStyle: QrDataModuleStyle(color: Color(kColorPrimario)),
              data: 'http://www.usmentradas.cl/${this.numeroEntrada}',
              version: QrVersions.auto,
              size: 200,
            ),
            Text('Codigo qr :)')
          ],
        ),
      ),
    );
  }
}
