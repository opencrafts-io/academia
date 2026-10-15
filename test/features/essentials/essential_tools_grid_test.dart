import 'package:academia/features/essentials/widgets/essential_tools_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the spacer after an odd number of tools', (
    tester,
  ) async {
    final tools = List.generate(5, (index) => 'Tool $index');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EssentialToolsGrid(
            itemCount: 5,
            itemBuilder: (context, index, borderRadius) => Text(tools[index]),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Tool 4'), findsOneWidget);
  });
}
