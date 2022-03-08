
import 'package:curso_alura_2/widget/feature_item.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.title == name && widget.icons == icon;
  }
  return false;
}

bool textFieldByLabelTextMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration?.labelText == labelText;
  }
  return false;
}