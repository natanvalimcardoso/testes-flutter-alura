import 'package:curso_alura_2/widget/feature_item.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) { // FUNÇÃO PARA VERIFICAR SE O WIDGET É O QUE EU QUERO, PARA NÃO TER QUE REPETIR O CÓDIGO
  return widget is FeatureItem &&
          widget.title == name &&
          widget.icons == icon;
}
