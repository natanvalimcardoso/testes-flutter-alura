import 'package:curso_alura_2/database/dao/contact_dao.dart';
import 'package:curso_alura_2/http/webclients/TransactionWebClient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao {}

class MockTransactionWebClient extends Mock implements TransactionWebClient {}