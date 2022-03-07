// ignore_for_file: prefer_const_constructors

import 'package:curso_alura_2/database/dao/contact_dao.dart';
import 'package:curso_alura_2/models/contact.dart';
import 'package:curso_alura_2/myapp.dart';
import 'package:curso_alura_2/screens/contact_form.dart';
import 'package:curso_alura_2/screens/contacts_list.dart';
import 'package:curso_alura_2/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'matcher.dart';
import 'mocks.dart';

void main(){
  testWidgets('Deve salvar um contato', (tester) async{
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(MaterialApp(home: MyApp(contactDao: mockContactDao,)));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final tranferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(tranferFeatureItem, findsOneWidget);
    await tester.tap(tranferFeatureItem);// detectar o clique
    
    await tester.pumpAndSettle(); // Serve para atualizar a tela


    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1); // Verifica se o método findAll foi chamado

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);

    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);


//----------------------------------------------CRIAR FORMULARIO------------------------------------------------------------//


    //* Teste de validação do formulário
    final nameTextField = find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Natan');

    //* Teste de validação do formulário ACCOUNT NUMBER
    final accountTextField = find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Account number'));
    expect(accountTextField, findsOneWidget);
    await tester.enterText(accountTextField, '1000');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(name: 'natan', accountNumber: 123,))).called(1);

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll()).called(2);
  });
}

bool textFieldMatcher(Widget widget, String labelText) {
  if(widget is TextField){
    return widget.decoration!.labelText == labelText;
  }
  return false;
}

// void main() {
//   group('When Dashboard is opened', () {
//     testWidgets('Should display the main image', (WidgetTester tester) async {
//       //test code
//     testWidgets('Should display the transfer feature', (tester) async {
//       //test code
//     testWidgets('Should display the transaction feed feature', (tester) async {
//       //test code
//     });
//   });
// }

