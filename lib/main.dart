import 'package:curso_alura_2/database/dao/contact_dao.dart';
import 'package:curso_alura_2/http/webclients/TransactionWebClient.dart';
import 'package:flutter/material.dart';
import 'dependecies/app_dependencies.dart';
import 'screens/dashboard.dart';
import 'http/webclients/TransactionWebClient.dart';

void main() {
  runApp(MyApp(
    transactionWebClient: TransactionWebClient(),
    contactDao: ContactDao(),
  ));
}

class MyApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  MyApp({
    required this.contactDao,
    required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return AppDependencies(
      transactionWebClient: transactionWebClient,
      contactDao: contactDao,
      child: MaterialApp(
        theme: theme.copyWith(
          buttonTheme: theme.buttonTheme.copyWith(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.green[900],
            secondary: Colors.green[900],
          ),
        ),
        home: Dashboard(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
