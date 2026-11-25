import 'package:flutter_test/flutter_test.dart';
import 'package:pbp_flutter/main.dart';
import 'package:pbp_flutter/services/api_client.dart';

void main() {
  testWidgets('balls title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.text('MyPortfolio'), findsOneWidget);
  });
}
