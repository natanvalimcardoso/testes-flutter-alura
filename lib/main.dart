import 'package:curso_alura_2/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';
import 'myapp.dart';

void main() {
  runApp( MyApp(contactDao: ContactDao(),));
}
