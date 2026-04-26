import 'package:flutter_test/flutter_test.dart';
import 'package:commit_to_learn/main.dart';

void main() {
  testWidgets('Home screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CommitToLearnApp()); // ✅ fixed class name
    expect(find.text('Welcome,'), findsOneWidget);
  });
}