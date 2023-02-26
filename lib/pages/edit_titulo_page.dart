import 'package:estudo/repositories/times_repository.dart';
import 'package:flutter/material.dart';
import '../models/titulo.dart';
import '../models/time.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class EditTituloPage extends StatefulWidget {
  final Titulo titulo;

  EditTituloPage({Key? key, required this.titulo}) : super(key: key);

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar() {
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
        titulo: widget.titulo,
        ano: _ano.text,
        campeonato: _campeonato.text);

    Get.back();

    Get.snackbar('Sucesso', 'Título alterado!',
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ${widget.titulo.campeonato}'),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(onPressed: () => editar(), icon: const Icon(Icons.check))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'Informe o ano do titulo!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Informe o campeonato!';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
