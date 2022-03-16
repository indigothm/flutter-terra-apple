// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:terra_apple_health/terra_apple_health.dart';

// void main() {
//   const MethodChannel channel = MethodChannel('terra_apple_health');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await TerraAppleHealth.platformVersion, '42');
//   });
// }
