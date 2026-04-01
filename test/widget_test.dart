import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:save_food/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SaveFoodApp());
    expect(find.text('Save Food'), findsOneWidget);
  });
}
