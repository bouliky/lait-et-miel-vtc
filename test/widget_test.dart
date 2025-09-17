import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeScreen affiche le titre et le message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    final titleFinder = find.text('Lait et Miel');
    final messageFinder = find.text(
      'Bienvenue sur Lait et Miel : VTC & Location de voiture',
    );

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lait et Miel')),
      body: Center(
        child: Text('Bienvenue sur Lait et Miel : VTC & Location de voiture'),
      ),
    );
  }
}
