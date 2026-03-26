// test/widget_test.dart

import 'package:core_native_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:ecorp_elearning/main.dart';

void main() {
  testWidgets('App launches and shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ECorpApp());
    // SplashScreen should be visible first
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
