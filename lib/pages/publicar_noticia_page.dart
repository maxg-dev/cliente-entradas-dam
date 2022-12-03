import 'package:flutter/material.dart';

class PublicarNoticiaPage extends StatefulWidget {
  const PublicarNoticiaPage({super.key});

  @override
  State<PublicarNoticiaPage> createState() => _PublicarNoticiaPageState();
}

class _PublicarNoticiaPageState extends State<PublicarNoticiaPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tituloController = TextEditingController();
  TextEditingController cuerpoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar noticia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            Divider(),
            TextFormField(
              controller: cuerpoController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Cuerpo',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
