import 'dart:async';
import 'package:flutter/services.dart';

class TerraAppleHealth {
  static const MethodChannel _channel = MethodChannel('terra_apple_health');

  final String devId;
  final String apiKey;
  final bool autoFetch;

  TerraAppleHealth(this.devId, this.apiKey, {this.autoFetch = true});

  Future<Map> auth({bool? referenceId}) async {
    final result = await _channel.invokeMethod(
        'auth', {'devId': devId, 'apiKey': apiKey, 'referenceId': referenceId});
    return result;
  }

  Future<Map> initTerra({required String userId}) async {
    return await _channel.invokeMethod('initTerra', {
      'devId': devId,
      'apiKey': apiKey,
      "userId": userId,
      "autoFetch": autoFetch
    });
  }

  getDaily(DateTime startDate, DateTime endDate) async {
    await _channel.invokeMethod('getDaily', {
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String()
    });
  }

  getSleep(DateTime startDate, DateTime endDate) async {
    await _channel.invokeMethod('getSleep', {
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String()
    });
  }

  getActivity(DateTime startDate, DateTime endDate) async {
    await _channel.invokeMethod('getActivity', {
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String()
    });
  }

  getBody(DateTime startDate, DateTime endDate) async {
    await _channel.invokeMethod('getBody', {
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String()
    });
  }

  getAthlete() async {
    await _channel.invokeMethod('getBody');
  }

  deauth() async {
    await _channel.invokeMethod('deauth');
  }
}
