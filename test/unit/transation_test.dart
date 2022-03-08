import 'package:curso_alura_2/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Deve retornar o valor uma Transactio', (){
    final transaction = Transaction(value: 200);
    expect(transaction.value, 200);
  });
  test('Deve representar uma falha que vir um valor menor que zero', (){
    expect(() => Transaction(value: 0,id: null, contact: null, dateTime: null), throwsAssertionError);
  });
}