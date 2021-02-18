import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user/bloc.dart';
import 'bloc/user/user_bloc.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/splash": (context) => SplashPage(),
  "/home": (context) => MyHomePage(),
};

void main() {
  runApp(BlocProvider(
    create: (BuildContext context) => UserBloc()..add(GetLoggedInUserEvent()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      builder: (context, widget) {
        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _navigator.pushAndRemoveUntil(MyHomePage.route(), (route) => false);
            } else if (state is UserLoggedOut) {
              _navigator.pushAndRemoveUntil(AuthScreen.route(), (route) => false);
            }
          },
          child: widget,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => MyHomePage());
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Testing App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => AuthScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Page')),
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return CircularProgressIndicator();
            }

            return RaisedButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(GetLoggedInUserEvent());
              },
              child: Text('Login'),
            );
          },
        ),
      ),
    );
  }
}
