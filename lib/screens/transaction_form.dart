import 'dart:async';

import 'package:curso_alura_2/components/response_dialog.dart';
import 'package:curso_alura_2/components/transaction_auth_dialog.dart';
import 'package:curso_alura_2/http/webclients/TransactionWebClient.dart';
import 'package:flutter/material.dart';
import '../dependecies/app_dependencies.dart';
import '../models/contact.dart';
import '../models/transaction.dart';
import 'transactions_list.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value: value!, contact: widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(dependencies!.transactionWebClient,
                                    transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

   _save(
    TransactionWebClient webClient,
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
      Transaction transaction = await _save(
      webClient,
      transactionCreated,
      password,
      context,
    )
        .catchError(
      (e) {
        _showFailureMessage(context, message: 'Timeout submitting transaction');
      },
      test: (e) =>
          e is TimeoutException, // serve para testar se o erro ?? de timeout
    ).catchError(
      (e) {
        _showFailureMessage(context, message: e.message);
      },
      test: (e) => e
          is Exception, // serve para testar se o erro ?? uma exce????o  e n??o um erro de conex??o
    );

    Navigator.of(context).pop(transaction);
    _sucessDialog(context);
  }

//* M??todos criados falhas
  void _showFailureMessage(BuildContext context, {required String message}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

//* M??todos criados sucesso
  void _sucessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog('successful transaction');
        });
  }
}
