import 'package:estudo/pages/edit_titulo_page.dart';
import 'package:estudo/repositories/times_repository.dart';
import 'package:flutter/material.dart';
import '../models/time.dart';
import '../pages/add_titulo_page.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../widget/brasao.dart';

class TimePage extends StatefulWidget {
  Time time;

  TimePage({required Key key, required this.time}) : super(key: key);

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  addTituloPage() {
    Get.to(() => AddTituloPage(time: widget.time));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: widget.time.cor,
            title: Text(widget.time.nome),
            actions: [
              IconButton(
                  onPressed: () => addTituloPage(), icon: const Icon(Icons.add))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.stacked_line_chart),
                  text: 'Estatísticas',
                ),
                Tab(
                  icon: Icon(Icons.emoji_events),
                  text: 'Titulos',
                ),
              ],
              indicatorColor: Colors.purpleAccent,
            ),
          ),
          body: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Brasao(
                      image: widget.time.brasao.toString(),
                      width: 250,
                    ),
                ),
                Text(
                  'Pontos: ${widget.time.pontos}',
                  style: const TextStyle(fontSize: 22),
                )
              ],
            ),
            titulos(),
          ]),
        ));
  }

  Widget titulos() {
    final time = Provider
        .of<TimesRepository>(context)
        .times
        .firstWhere((t) => t.nome == widget.time.nome);
    final quantidade = time.titulos.length;


    return quantidade == 0
        ? Container(
      child: const Center(
        child: Text('Nenhum Titulo Ainda!'),
      ),
    )
        : ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: const Icon(Icons.emoji_events),
            title: Text(time.titulos[index].campeonato),
            trailing: Text(time.titulos[index].ano),
            onTap: () {
              Get.to(
                      () => EditTituloPage(titulo: time.titulos[index]),
                  fullscreenDialog: true
              );
            },
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: (quantidade));
  }

}
