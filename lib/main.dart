import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini/features/genai_setting/bloc/genai_bloc.dart';
import 'package:gemini/features/genai_setting/ui/genai_setting_screen.dart';
import 'package:gemini/features/login/ui/login_screen.dart';
import 'package:gemini/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp (
    options: DefaultFirebaseOptions.currentPlatform
  );

  await dotenv.load();
  runApp(BlocProvider<GenaiBloc> (
    create: (context) => GenaiBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Localizations Sample App',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}
