// ignore_for_file: prefer_const_constructors

import 'package:curso_alura_2/myapp.dart';
import 'package:curso_alura_2/screens/contact_form.dart';
import 'package:curso_alura_2/screens/contacts_list.dart';
import 'package:curso_alura_2/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matcher.dart';

void main(){
  testWidgets('Deve salvar um contato', (tester) async{
    await tester.pumpWidget(MaterialApp(home: MyApp()));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final tranferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(tranferFeatureItem, findsOneWidget);
    await tester.tap(tranferFeatureItem);// detectar o clique
    
    await tester.pumpAndSettle(); // Serve para atualizar a tela


    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);

    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
  });
}


