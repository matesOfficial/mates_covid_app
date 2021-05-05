//import 'dart:js';

import 'package:covid_app/models/user_model.dart';
import 'package:covid_app/providers/user_profile_provider.dart';
import 'package:covid_app/screens/confirmation.dart';
import 'package:covid_app/screens/splash_screen.dart';
import 'package:covid_app/services/auth_service.dart';
import 'package:covid_app/services/navigation_service.dart';
import 'package:covid_app/theme/style.dart';
import 'package:covid_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
  GetIt.instance.registerLazySingleton(() => NavigationService());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel>(
          create: (context) => AuthService.authStream,
          initialData: UserModel.fromFirebase(firebaseData: null),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider(),
        ),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Covid App",
          theme: ThemeUtils.defaultAppThemeData,
          home: SplashScreen(),
          // Important routes
          routes: {'/wrapper': (context) => Wrapper()},
        ),
      ),
    );
  }
}
