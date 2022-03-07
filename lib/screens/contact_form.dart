import 'package:flutter/material.dart';

import 'package:curso_alura_2/models/contact.dart';

import '../components/text_field_components.dart';
import '../database/dao/contact_dao.dart';

class ContactForm extends StatefulWidget {
  final ContactDao contactDao;

  ContactForm({Key? key,required this.contactDao,}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState(contactDao: contactDao);
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final ContactDao contactDao;

  _ContactFormState({required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: Material(
        child: Column(
          children: [
            TextFieldComponents(
              controlador: _nameController,
              labelText: 'Full Name',
              keyboardType: TextInputType.text,
            ),
            TextFieldComponents(
              controlador: _accountNumber,
              labelText: 'Account number',
              keyboardType: TextInputType.number,
            ),
            Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber = int.parse(_accountNumber.text);

                    setState(() {
                      final newContact =
                          Contact(name: name, accountNumber: accountNumber);
                      save(newContact, context);
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }

  void save(Contact newContact, BuildContext context) async {
    await contactDao.save(newContact);
    Navigator.pop(context);
  }
}
