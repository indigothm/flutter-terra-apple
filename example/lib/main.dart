import 'package:flutter/material.dart';
import 'package:terra_apple_health/terra_apple_health.dart';
import 'package:terra_apple_health_example/secrets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.medical_services),
            onPressed: () async {
              final terra = TerraAppleHealth(
                // TODO: Note pass your own API keys and Dev ID
                terraTestDevID,
                terraTestingAPIKey,
              );
              final authResult = await terra.auth();
              if (authResult['terra_id'] != null) {
                terra.initTerra(userId: authResult['terra_id']);
              }
            }),
        appBar: AppBar(
          title: const Text('Terra Plugin Demo'),
        ),
        body: const Center(
          child: Text('Click the button to connect'),
        ),
      ),
    );
  }
}
