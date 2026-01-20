import 'package:flutter_test/flutter_test.dart';
import 'package:tikipal/main.dart';

void main() {
  testWidgets('App launches correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const TikipalApp());
    // Verify app starts
    expect(find.text('Tikipal'), findsWidgets);
  });
}
