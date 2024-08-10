import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyACykgbbTjeMqVJBrHqLgwvDYi87NNleLM",
            authDomain: "greener-plus-qgk1o0.firebaseapp.com",
            projectId: "greener-plus-qgk1o0",
            storageBucket: "greener-plus-qgk1o0.appspot.com",
            messagingSenderId: "521627117676",
            appId: "1:521627117676:web:17ba9f42702e9c36981049"));
  } else {
    await Firebase.initializeApp();
  }
}
