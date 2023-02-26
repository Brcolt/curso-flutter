import 'package:estudo/models/time.dart';
import 'package:get/get.dart';
import '../repositories/times_repository.dart';

class HomeController extends GetxController {

  static TimesRepository timesRepository = TimesRepository();

  HomeController() {
    timesRepository = TimesRepository();
  }

  List<Time> get tabela => timesRepository.times;


}

