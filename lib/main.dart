import 'package:chatify/Theme_data/Themes.dart';
import 'package:chatify/pages/Login_Pag.dart.dart';
import 'package:chatify/pages/home_page.dart';
import 'package:chatify/pages/register_page.dart';
import 'package:chatify/pages/splash_page.dart';
import 'package:chatify/services/cloud_services.dart';
import 'package:chatify/services/database_service.dart';
import 'package:chatify/services/media_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './services/navigation_services.dart';
import './providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'providers/chats_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _registerServices();
  runApp(const Main());
}

void _registerServices() {
  GetIt.instance.registerSingleton<NavigationServices>(
    NavigationServices(),
  );
  GetIt.instance.registerSingleton<MediaService>(
    MediaService(),
  );
  GetIt.instance.registerSingleton<CloudStorageServices>(
    CloudStorageServices(),
  );
  GetIt.instance.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext context) {
            return AuthenticationProvider();
          },
        ),
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (BuildContext context) {
            return ChatsPageProvider(Provider.of<AuthenticationProvider>(context));
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: "Chitify",
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        navigatorKey: NavigationServices.navigatorKey,
        home: const SplashPage(),
        routes: {
          '/login': (BuildContext context) => const LoginPagDart(),
          '/home': (BuildContext context) => const HomePage(),
          '/register': (BuildContext context) => const RegisterPage()
        },
      ),
    );
  }
}
