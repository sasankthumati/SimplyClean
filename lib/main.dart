import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simply_clean/screens/asset_screen.dart';
import 'screens/home_screen.dart';
import 'screens/request_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/feedback_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyCxLllKHvE7ejQdXVOOJbpzJ3f37UGfBq4",
  authDomain: "simplyclean-942a8.firebaseapp.com",
  projectId: "simplyclean-942a8",
  storageBucket: "simplyclean-942a8.appspot.com",
  messagingSenderId: "352703341322",
  appId: "1:352703341322:web:0662e504d6466b4749d0f3",
  measurementId: "G-K5XZ6LN49L"
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions, // Your FirebaseOptions object here
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimplyClean',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(),
        '/create-asset': (context) => CreateAssetScreen(), // Add the route for AssetForm
        '/request': (context) => RequestServiceScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
