import 'package:flutter/material.dart';
import 'package:flutter_application_demo1/presentation/screens/homeScreen/home.screen.dart';
import 'package:provider/provider.dart';

import 'app/constants/app.theme.dart';
import 'app/providers/app.provider.dart';
import 'app/routes/app.routes.dart';
import 'core/notifiers/theme.notifier.dart';

// import 'web_url/configure_nonweb.dart'
//     if (dart.library.html) 'web_url/configure_web.dart';

void main() {
  // configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Lava());
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: const Core(),
    );
  }
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, _) {
        return MaterialApp(
          title: 'Scarvs',
          home: HomeScreen()
          // supportedLocales: AppLocalization.all,
          // theme: notifier.darkTheme ? darkTheme : lightTheme,
          // debugShowCheckedModeBanner: false,
          // onGenerateRoute: AppRouter.generateRoute,
          // initialRoute: AppRouter.splashRoute,
          
        );
      },
    );
  }
}
