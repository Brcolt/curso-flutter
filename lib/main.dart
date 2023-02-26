import 'package:estudo/controllers/theme_controller.dart';
import 'package:estudo/pages/home_page.dart';
import 'package:estudo/repositories/times_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<ThemeController>(
      () => ThemeController()
  );

  runApp(ChangeNotifierProvider(
    create: (context) => TimesRepository(),
    child: MeuApplicativo(),
  ));
}

class MeuApplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

    return GetMaterialApp(
      title: 'Brasileirão',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
      ), darkTheme: ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.grey,
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black45,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurpleAccent[100],
        ),
      ),
    ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
