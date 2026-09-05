import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/main.dart';

void main() {
  testWidgets('Demo app renders all widgets and submit updates status',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DemoApp());

    expect(find.text('Flutter Demo'), findsOneWidget);
    expect(find.text('Press the button'), findsOneWidget);
    expect(find.text('Apple'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.textContaining('Button pressed.'), findsOneWidget);
  });

  testWidgets('Profile block semantic text nodes are all present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.pump();

    expect(find.text('User Profile'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Flutter Developer'), findsOneWidget);
    expect(find.text('42 Stars'), findsOneWidget);
    expect(find.text('7 PRs'), findsOneWidget);
    expect(find.text('18 Commits'), findsOneWidget);
    expect(find.text('Activity this week'), findsOneWidget);
  });

  testWidgets('Profile block non-semantic widget types are present in render tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.pump();

    expect(find.byType(DecoratedBox), findsWidgets);
    expect(find.byType(ColoredBox), findsWidgets);
    expect(find.byType(FlutterLogo), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets('All Icon widgets in the app have no semantic label',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DemoApp());
    await tester.pump();

    final icons = tester.widgetList<Icon>(find.byType(Icon));
    for (final icon in icons) {
      expect(
        icon.semanticLabel,
        isNull,
        reason: 'Icon ${icon.icon} must have no semanticLabel',
      );
    }
  });
}
