import 'package:curso_alura_2/screens/contacts_list.dart';
import 'package:curso_alura_2/screens/dashboard.dart';
import 'package:curso_alura_2/widget/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matcher.dart';

void main() {
  testWidgets('Deve mostrar na main a imagem quando o dashboard está aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(
        Image); // SERVE PARA BUSCAR O ELEMENTO NA TELA E VER SE ELE ESTÁ VISIVEL OU NÃO
    expect(mainImage, findsNWidgets(1)); // VERIFICA SE ACHOU 1 ELEMENTO
  });
  testWidgets(
    'Deve mostrar a funcionalidade de tranfer quando o dashboard está aberto',
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      (tester) async {
        final transferFeatureItem = find.byWidgetPredicate((widget) =>
            featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
        expect(transferFeatureItem, findsOneWidget);
      };
    },
  );
  testWidgets(
    'Deve mostrar a funcionalidade de transaction feed quando o dashboard está aberto*',
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      (tester) async {
        final transferFeatureItem = find.byWidgetPredicate((widget) =>
            featureItemMatcher(widget, 'Transaction Feed', Icons.description)); // Função está sendo chamada a baixo
        expect(transferFeatureItem, findsOneWidget);
      };
    },
  );
}




