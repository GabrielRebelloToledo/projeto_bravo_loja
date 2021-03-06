import 'package:bravo/provider/gerencia.dart';
import 'package:bravo/provider/pessoas.dart';
import 'package:bravo/provider/user_register_provider.dart';
import 'package:bravo/views/cadastro.dart';
import 'package:bravo/views/form_gerencia.dart';
import 'package:bravo/views/gerencia_page.dart';
import 'package:bravo/views/home.dart';
import 'package:bravo/views/splash_screen.dart';
import 'package:bravo/views/termos.dart';
import 'package:bravo/views/user_registration.dart';
import 'package:bravo/views/users_not_register_page.dart';
import 'package:bravo/views/users_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        //Logica para autenticação mudança de ChangeNotifierProvider para ChangeNotifierProxyProvider
        //Colocando em estrutura gravitacional
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (context) => ProductList(),
          //Logica para autenticação
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, UserRegisterProvider>(
          create: (context) => UserRegisterProvider(),
          //Logica para autenticação
          update: (ctx, auth, previous) {
            return UserRegisterProvider(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, GerenciaList>(
          create: (context) => GerenciaList(),
          //Logica para autenticação
          update: (ctx, auth, previous) {
            return GerenciaList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
      ],
      child: MaterialApp(
          title: 'Bravo Entregas',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            Routes.home: (ctx) => Home(),
            Routes.splashScreen: (ctx) => SplashScreen(),
            Routes.cadastro: (ctx) => UserRegistration(),
            Routes.cadastroP: (ctx) => ProductFormPage(),
            Routes.formGerencia: (ctx) => FormGerencia(),
            Routes.usuarios: (ctx) => UsersViews(),
            Routes.termos: (ctx) => Termos(),
            Routes.paginaCadastro: (ctx) => UsersNotRegister(),
            Routes.gerenciaList: (ctx) => PageGerencia(),
          }),
    );
  }
}
