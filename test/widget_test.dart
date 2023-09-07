// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:schoolms/main.dart';
import 'package:schoolms/pages/widgets/online_slider.dart';
import 'package:schoolms/pages/widgets/schoolms_bottom_navigation_bar.dart';

void main() {
  group("test the home page widget", () {
    testWidgets('test to see if GoogleMap is visible',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const SchoolMsApp());

      // find the GooglMap widget
      final googleMapFinder = find.byType(GoogleMap);
      // expect the GooglMap widget to be visible
      expect(googleMapFinder, findsOneWidget);
      
    });

    testWidgets("test to see if the slider visible", (widgetTester) async {
      await widgetTester.pumpWidget(const SchoolMsApp());

      // find the online slider
      final sliderFinder = find.byType(OnlineSlider);

      // expect the online slider to be visible
      expect(sliderFinder, findsOneWidget);

      var textFinder = find.text("Slide to go online");
      expect(textFinder, findsOneWidget);

      // find the drag button
      final dragButtonFinder = find.byKey(const Key("dragIcon"));
      expect(dragButtonFinder, findsOneWidget);

      // drag the slider
      await widgetTester.drag(
        dragButtonFinder,
        const Offset(3000, 0),
        warnIfMissed: true,
      );

      await widgetTester.pumpAndSettle();

      textFinder = find.text(
          "Slide to go online"); // expect the text to change "Slide to go offline"
      expect(textFinder, findsOneWidget);
    });

    testWidgets("test the bottom navigation bar", (widgetTester) async {
      await widgetTester.pumpWidget(const SchoolMsApp());

      // find the bottom navigation bar
      final bottomNavBarFinder = find.byType(SchoolMsBottomNavigationBar);
      expect(bottomNavBarFinder, findsOneWidget);

      // find the home icon
      final homeIconFinder = find.byIcon(Icons.home);
      expect(homeIconFinder, findsOneWidget);

      // finds the notifications icon
      final notificationsIconFinder = find.byIcon(Icons.notifications);
      expect(notificationsIconFinder, findsOneWidget);

      // finds the history icon
      final historyIconFinder = find.byIcon(Icons.history);
      expect(historyIconFinder, findsOneWidget);

      // finds the person icon
      final personIconFinder = find.byIcon(Icons.person);
      expect(personIconFinder, findsOneWidget);


      await widgetTester.tap(notificationsIconFinder);

      await widgetTester.pumpAndSettle();

      final textFinder = find.text("Notifications");
      expect(textFinder, findsNothing);

      // final onChanged = widgetTester.widget<SchoolMsBottomNavigationBar>(bottomNavBarFinder).onChanged;
      // onChanged(1);
      // expect(onChanged(1), expectAsync1((p0) => 1));
    });
  });
}
