import 'dart:async';

import 'package:counterapp_flavors/app_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  return MyApp(appConfig);
}

class MyApp extends StatelessWidget {
  final AppConfig appConfig;
  const MyApp(this.appConfig);

  Widget _flavorBanner(Widget child) {
    return Banner(
      child: child,
      location: BannerLocation.topEnd,
      message: appConfig.flavor,
      color: appConfig.flavor == 'dev'
          ? Colors.red.withOpacity(0.6)
          : Colors.green.withOpacity(0.6),
      textStyle: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 14.0, letterSpacing: 1.0),
      textDirection: TextDirection.ltr,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: appConfig.flavor == 'dev' ? Colors.yellow : Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _flavorBanner(
        MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
    return materialApp;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  DatabaseReference _counterRef;
  StreamSubscription<Event> _counterSubscription;

  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times.\n'
              'This includes all devices, ever.',
            ),
            Text(
              _error == null ? '$_counter' : 'Error: \n${_error.message}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _increment() async {
    // Increment counter in transaction.
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _counterSubscription.cancel();
  }
}
