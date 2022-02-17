import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golab/ui/home/home_student.dart';
import 'package:golab/ui/home/home_researcher.dart';
import 'package:golab/view_model/view_model_auth.dart';
import 'package:golab/view_model/view_model_lab.dart';
import 'package:golab/view_model/view_model_lablist.dart';
import 'package:golab/view_model/view_model_researcher.dart';
import 'package:golab/view_model/view_model_student.dart';
import 'launcher.dart';

final studentProvider = StateNotifierProvider((ref) => StudentViewModel());
final researcherProvider = StateNotifierProvider((ref) => ResearcherViewModel());
final labProvider = StateNotifierProvider((ref) => LabViewModel());
final labListProvider = StateNotifierProvider((ref) => LabListViewModel());
final authControllerProvider =
StateNotifierProvider<AuthViewModel, User?>((ref) => AuthViewModel(initialUser: FirebaseAuth.instance.currentUser));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'goLab',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white)
      ),
      routes: {
        '/': (context) => const Launcher(),
        '/student': (context) => const StudentHome(),
        '/researcher': (context) => const ResearcherHome(),
      },
      initialRoute: '/',
    );
  }
}