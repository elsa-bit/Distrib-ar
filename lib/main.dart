import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distribar/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:distribar/analytics_provider.dart';
import 'package:distribar/firebase_analytics_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalyticsProvider(
      handlers: [
        FirebaseAnalyticsHandler(),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _crash() async {
    try {
      throw Exception('Coucou, ce crash est géré');
    } catch (error, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  void _testFirestore() async {
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('bar_content');

    try {
      final DocumentReference documentReference = await collectionReference.add({'id': 2, 'name': 'Rhum'});

      //final ref = await collectionReference.get();
      //debugPrint('Collection data: ${ref.docs}');

      debugPrint('Document added with id: ${documentReference.id}');
    } catch (error) {
      debugPrint('Error writting in firestore: $error');
    }
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _crash,
            tooltip: 'Crash',
            child: const Icon(Icons.car_crash),
          ),
          FloatingActionButton(
            onPressed: _testFirestore,
            child: const Icon(Icons.cloud),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
