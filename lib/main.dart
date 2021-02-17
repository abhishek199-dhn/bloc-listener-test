import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user/bloc.dart';
import 'bloc/user/user_bloc.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/splash": (context) => SplashPage(),
  "/home": (context) => MyHomePage(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // global user bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc()
            ..add(
              GetLoggedInUserEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        home: SplashPage(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
        // this bloc listener gets called when the event is fired from the home page
        // even when this route is not in the route stack.

        print("UserBlocListener");
        if (state is UserLoaded) {
          if (state.isUserLoaded == true) {
            // removing all the prev routes
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/home",
              (Route<dynamic> route) => false,
            );
          }
        }
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // need to fire this event again in case when user comes from this flow (to get the user in home):
    // splash -> user not found -> login -> home
    BlocProvider.of<UserBloc>(context).add(GetLoggedInUserEvent());
    super.initState();
  }

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
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
