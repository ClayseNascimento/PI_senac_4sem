import 'package:flutter/material.dart';

class TodoColors {
  static const azul = TodoColor(0xFF0D6BB3);
  static const azulClaro = Color(0xFF7BC0F5);
  static const transparent = TodoColor(0x00000000);
  static const branco = TodoColor(0xFFFFFFFF);
  static const cinza = TodoColor(0xFF0AAAAAA);
  static const verde = TodoColor(0xFF06CC48);
  static const vermelho = TodoColor(0xFFFF322B);
  static const preto = TodoColor(0xFF000000);
}

class TodoColor extends Color {
  const TodoColor(int value) : super(value);
}
