import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

double? getLong(LatLng? lat) {
  return lat!.longitude;
}

double? getLat(LatLng? lat) {
  return lat!.latitude;
}

dynamic jsonConvert(String? response) {
  // Find the positions of the first '{' and the last '}'
  int startIndex = response!.indexOf('{');
  int endIndex = response.lastIndexOf('}');

  // Extract the JSON string
  String jsonString = response.substring(startIndex, endIndex + 1);

  // Convert to JSON
  dynamic jsonResponse = jsonDecode(jsonString);
  return jsonResponse;
}

DateTime? nextDayAdd(
  int dayNumber,
  DateTime currentDay,
) {
  return currentDay.add(Duration(days: dayNumber));
}

int? diffrenceDate(
  DateTime currentDate,
  DateTime targetDate,
) {
  Duration difference = currentDate.difference(targetDate);
  return difference.inDays;
}

String getListMessages(List<UserAndGeminiStruct> messages) {
  String finalString = '';
  for (UserAndGeminiStruct userAndGemini in messages) {
    finalString += 'User: ${userAndGemini.userChat.userText}\n';

    finalString += 'Bot: ${userAndGemini.geminiChat}\n';
  }
  return finalString;
}

bool compareDates(
  DateTime timestamp1,
  DateTime timestamp2,
) {
  return timestamp1.year == timestamp2.year &&
      timestamp1.month == timestamp2.month &&
      timestamp1.day == timestamp2.day;
}
