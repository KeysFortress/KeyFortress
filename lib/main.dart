import 'package:domain/models/core_router.dart';
import 'package:domain/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:presentation/router/router.dart';
import 'package:stacked/stacked.dart';

import 'package:shared/locator.dart' as locator;
import 'main_viewmodel.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void requestPermissions() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

void getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("Device Token: $token");
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("New Device Token: $newToken");
    // Save or send the new token to your server
  });

  requestPermissions();
  getToken();

  locator.registerDependency();
  LocalJsonLocalization.delegate.directories = ['KF_Localization'];
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final appRouter = ApplicationRouter.router;
  final configured = false;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final internalRouter = CoreRouter(router: appRouter);

    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => MaterialApp.router(
        supportedLocales: [
          Locale('en', 'US'), // English
          Locale('de', 'DE'), // German
        ],
        locale: Locale("en_DE"),
        localizationsDelegates: [
          LocalJsonLocalization.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }

          if (locale?.languageCode == 'pt') {
            return Locale('en', 'DE');
          }

          return Locale('en', 'DE');
        },
        debugShowCheckedModeBanner: false,
        routerConfig: internalRouter.router,
        builder: (context, child) => Material(
          color: ThemeStyles.theme.background300,
          child: Column(
            children: [
              if (child != null) Expanded(child: child),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (model) => model.initialized(
        internalRouter,
        context,
      ),
    );
  }
}
