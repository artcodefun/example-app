import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/components/AuthNavigationWidget.dart';
import 'package:test_app/helpers/AppModule.dart';
import 'package:test_app/helpers/NavigationInfo.dart';
import 'generated/l10n.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector injector = await AppModule().initialise(Injector());
  runApp(Provider.value(value: injector, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) =>
          AuthCubit(authDataLoader: Provider.of<Injector>(context).get()),
      child: AuthNavigationWidget(
        navKey: _navKey,
        child: MaterialApp(
          navigatorKey: _navKey,
          title: "Test App",
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          routes: NavigationInfo.makeRoutes(),
          initialRoute: NavigationInfo.loading,
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      alignment: Alignment.centerLeft)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))))),
        ),
      ),
    );
  }
}
