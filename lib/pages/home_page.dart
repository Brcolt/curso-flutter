import 'package:estudo/controllers/theme_controller.dart';
import 'package:estudo/models/time.dart';
import 'package:estudo/pages/time_page.dart';
import 'package:estudo/repositories/times_repository.dart';
import 'package:estudo/widget/brasao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brasileirão'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: ListTile(
                leading: Obx(() => controller.isDark.value
                    ? const Icon(Icons.brightness_7)
                    : const Icon(Icons.brightness_2)
                ),
                    title: Obx(() => controller.isDark.value ? const Text('Light') : const Text('Dark')),
                    onTap: () => controller.changeTheme(),
              ))
            ],

          )
        ],
      ),
      body: Consumer<TimesRepository>(
        builder: (context, repositorio, child) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int time) {
                final List<Time> tabela = repositorio.times;
                return ListTile(
                  leading: Brasao(
                    image: tabela[time].brasao.toString(),
                    width: 40,
                  ),
                  title: Text(tabela[time].nome),
                  subtitle: Text('Titulos: ${tabela[time].titulos?.length}'),
                  trailing: Text(tabela[time].pontos.toString()),
                  onTap: () {
                    Get.to(() => TimePage(
                        key: Key(tabela[time].nome), time: tabela[time]));
                  },
                );
              },
              separatorBuilder: (_, __) => Divider(),
              padding: EdgeInsets.all(16),
              itemCount: repositorio.times.length);
        },
      ),
    );
  }
}
