// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:event_app/l10n/app_localizations.dart';

// void main() {
//   testWidgets('Localizations smoke test (EN/AR)', (WidgetTester tester) async {
//     Future<void> pumpForLocale(Locale locale) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(
//             locale: locale,
//             supportedLocales: const [Locale('en'), Locale('ar')],
//             localizationsDelegates: const [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             home: Builder(
//               builder: (context) {
//                 return Text(AppLocalizations.of(context)!.quickActions);
//               },
//             ),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//     }

//     await pumpForLocale(const Locale('en'));
//     expect(find.text('Quick Actions'), findsOneWidget);

//     await pumpForLocale(const Locale('ar'));
//     expect(find.text('إجراءات سريعة'), findsOneWidget);
//   });
// }
