import 'package:flutter/material.dart';
import 'titulo.dart';

class Time {
  final int? id;
  final String nome;
  final String brasao;
  final int pontos;
  final Color? cor;
  final int? idAPI;
  List<Titulo> titulos = <Titulo>[];

  Time({
    this.id,
    required this.brasao,
    required this.nome,
    required this.pontos,
    required this.cor,
    this.idAPI,
    required this.titulos,
  });
}