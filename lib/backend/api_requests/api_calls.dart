import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class WeatherCall {
  static Future<ApiCallResponse> call({
    double? lat = 0.0,
    double? lon = 0.0,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Weather',
      apiUrl: 'https://api.openweathermap.org/data/2.5/weather',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'appid': "48cf5d236cd363ef71aadaac0bf33291",
        'lat': lat,
        'lon': lon,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static double? wind(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.wind.speed''',
      ));
  static int? humidity(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.main.humidity''',
      ));
  static double? temp(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.main.temp''',
      ));
  static int? cloud(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.clouds.all''',
      ));
}

class GeminiCall {
  static Future<ApiCallResponse> call({
    String? message = 'none',
  }) async {
    final ffApiRequestBody = '''
{
  "contents": [
    {
      "parts": [
        {
          "text": "${message}"
        }
      ]
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Gemini',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyA3sY2J8qY1LShMMeDCM1X6X3Z_uno3iRk',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.candidates[:].content.parts[:].text''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
