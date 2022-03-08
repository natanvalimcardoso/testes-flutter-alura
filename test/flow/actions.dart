import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matcher.dart';

Future<void> clickOnTheTransferFeatureItem(WidgetTester tester) async {
  final tranferFeatureItem = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(tranferFeatureItem, findsOneWidget);
  return tester.tap(tranferFeatureItem);
}
