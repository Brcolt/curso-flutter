import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/time.dart';
import '../models/titulo.dart';
import '../database/db.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];

  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  void addTitulo({required Time time, required Titulo titulo}) async {
    var db = await DB.get();
    int id = await db.insert('titulos', {
      'campeonato': titulo.campeonato,
      'ano': titulo.ano,
      'time_id': time.id
    });
    titulo.id = id;
    time.titulos.add(titulo);
    notifyListeners();
  }

  void editTitulo(
      {required Titulo titulo,
      required String ano,
      required String campeonato}) async {
    var db = await DB.get();
    await db.update(
        'titulos',
        {
          'campeonato': campeonato,
          'ano': ano,
        },
        where: 'id = ?',
        whereArgs: [titulo.id]);
    titulo.campeonato = campeonato;
    titulo.ano = ano;
    notifyListeners();
  }

  TimesRepository() {
    initRepository();
  }

  initRepository() async {
    var db = await DB.get();
    List times = await db.query('times');

    for (var t in times) {
      _times.add(Time(
        id: t['id'],
        nome: t['nome'],
        brasao: t['brasao'],
        pontos: t['pontos'],
        cor: Color(int.parse(t['cor'])),
        titulos: await getTitulos(t['id']),
      ));
    }
    notifyListeners();
  }

  getTitulos(timeId) async {
    var db = await DB.get();
    var results =
        await db.query('titulos', where: 'time_id = ?', whereArgs: [timeId]);
    List<Titulo> titulos = [];
    for (var titulo in results) {
      titulos.add(Titulo(
          id: titulo['id'],
          campeonato: titulo['campeonato'],
          ano: titulo['ano']));
    }
    return titulos;
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Flamengo',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/flamengo/logo-flamengo-256.png',
        cor: Colors.red[900],
        idAPI: 18,
        titulos: [],
      ),
      Time(
        nome: 'Internacional',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/internacional/logo-internacional-256.png',
        cor: Colors.red[900],
        idAPI: 44,
        titulos: [],
      ),
      Time(
        nome: 'Atlético-MG',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
        cor: Colors.grey[800],
        idAPI: 30,
        titulos: [],
      ),
      Time(
        nome: 'São Paulo',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/sao-paulo/logo-sao-paulo-256.png',
        cor: Colors.red[900],
        idAPI: 57,
        titulos: [],
      ),
      Time(
        nome: 'Fluminense',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/fluminense/logo-fluminense-256.png',
        cor: Colors.teal[800],
        idAPI: 26,
        titulos: [],
      ),
      Time(
        nome: 'Grêmio',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/gremio/logo-gremio-256.png',
        cor: Colors.blue[900],
        idAPI: 45,
        titulos: [],
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/palmeiras/logo-palmeiras-256.png',
        cor: Colors.green[800],
        idAPI: 56,
        titulos: [],
      ),
      Time(
        nome: 'Santos',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/santos/logo-santos-256.png',
        cor: Colors.grey[800],
        idAPI: 63,
        titulos: [],
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-paranaense/logo-atletico-paranaense-256.png',
        cor: Colors.red[900],
        idAPI: 185,
        titulos: [],
      ),
      Time(
        nome: 'Corinthians',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/corinthians/logo-corinthians-256.png',
        cor: Colors.grey[800],
        idAPI: 65,
        titulos: [],
      ),
      Time(
        nome: 'Bragantino',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/red-bull-bragantino/logo-red-bull-bragantino-256.png',
        cor: Colors.grey[800],
        idAPI: 64,
        titulos: [],
      ),
      Time(
        nome: 'Ceará',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/ceara/logo-ceara-256.png',
        cor: Colors.grey[800],
        idAPI: 105,
        titulos: [],
      ),
      Time(
        nome: 'Atlético-GO',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-goianiense/logo-atletico-goianiense-256.png',
        cor: Colors.red[900],
        idAPI: 98,
        titulos: [],
      ),
      Time(
        nome: 'Sport',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/sport-recife/logo-sport-recife-256.png',
        cor: Colors.red[900],
        idAPI: 79,
        titulos: [],
      ),
      Time(
        nome: 'Bahia',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/bahia/logo-bahia-256.png',
        cor: Colors.blue[900],
        idAPI: 68,
        titulos: [],
      ),
      Time(
        nome: 'Fortaleza',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/fortaleza/logo-fortaleza-256.png',
        cor: Colors.red[900],
        idAPI: 131,
        titulos: [],
      ),
      Time(
        nome: 'Vasco',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/vasco-da-gama/logo-vasco-da-gama-256.png',
        cor: Colors.grey[800],
        idAPI: 23,
        titulos: [],
      ),
      Time(
        nome: 'Coritiba',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/coritiba/logo-coritiba-5.png',
        cor: Colors.green[900],
        idAPI: 84,
        titulos: [],
      ),
      Time(
        nome: 'Botafogo',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/botafogo/logo-botafogo-256.png',
        cor: Colors.grey[800],
        idAPI: 22,
        titulos: [],
      ),
    ];
  }
}
