// ignore_for_file: prefer_const_constructor
import 'package:curso_alura_2/components/contact_item.dart';
import 'package:curso_alura_2/components/response_dialog.dart';
import 'package:curso_alura_2/components/transaction_auth_dialog.dart';
import 'package:curso_alura_2/models/contact.dart';
import 'package:curso_alura_2/main.dart';
import 'package:curso_alura_2/models/transaction.dart';
import 'package:curso_alura_2/screens/contact_form.dart';
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
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(MyApp(
      transactionWebClient: mockTransactionWebClient,
      contactDao: mockContactDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final alex = Contact(accountNumber: 200, name: 'Alex');
    when(mockContactDao.findAll()).thenAnswer((invocation) async => [alex]);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Alex' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final contactName = find.text('Alex');
    expect(contactName, findsOneWidget);
    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);
    
    final textFieldValue = find.byWidgetPredicate((widget){
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

    when(mockTransactionWebClient.save(Transaction(, '1000', value: 200))
    .thenAnswer((_)  => Transaction(value: 1000));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}

