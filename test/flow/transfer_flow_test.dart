import 'package:curso_alura_2/components/contact_item.dart';
import 'package:curso_alura_2/components/transaction_auth_dialog.dart';
import 'package:curso_alura_2/models/contact.dart';
import 'package:curso_alura_2/main.dart';
import 'package:curso_alura_2/models/transaction.dart';
import 'package:curso_alura_2/screens/contacts_list.dart';
import 'package:curso_alura_2/screens/dashboard.dart';
import 'package:curso_alura_2/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../matchers/matcher.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should Tranfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(MaterialApp(
        home: MyApp(
            contactDao: mockContactDao,
            transactionWebClient: mockTransactionWebClient)));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    when(mockContactDao.findAll()).thenAnswer((_) async => [
          Contact(name: 'Natan', accountNumber: 123)
        ]); // quando chamar o findAll ele retorna um array vazio para nao dar erro

    await clickOnTheTransferFeatureItem(tester); // detectar o clique

    await tester.pumpAndSettle(); // Serve para atualizar a tela

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll())
        .called(1); // verificar se o findAll foi chamado 1 vez

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Natan' &&
            widget.contact.accountNumber == '123';
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Natan');
    expect(contactName, findsOneWidget);

    final accountNumber = find.text('123');
    expect(accountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Value');
    });
    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword = find.byKey(transactionAuhtDialogTextFieldKeyPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save()).thenAnswer((_) async => Transaction(
          id: '1',
          value: 200,
          contact: Contact(
              name: 'Natan', accountNumber: 123,),
        ));

    await tester.tap(confirmButton);
  });
}
