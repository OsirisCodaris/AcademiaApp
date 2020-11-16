import 'package:academia26102020/Issets/SplashScreen.dart';
import 'package:academia26102020/LocalRequest/localDatabase.dart';
import 'package:academia26102020/all_classe_subject.dart';
import 'package:academia26102020/all_subject.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academia',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff5F8463),
        accentColor: Colors.green,
        textTheme: TextTheme(
          subtitle1:
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          subtitle2:
              TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          headline1: TextStyle(fontSize: 21, color: Color(0xff5F8463)),
          headline2: TextStyle(
              color: Colors.green, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(elevation: 9, centerTitle: true),
        buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff5F8463), textTheme: ButtonTextTheme.primary),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black87,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
        cursorColor: Colors.green,
        indicatorColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userExist = false;
  bool isLoading = true;
  bool userProf = true;
  List<Map<String, dynamic>> queryRows;

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  onLoad() async {
    //On va tester si il y'a un user dans la bdd local
    queryRows = await DatabaseHelper.instance.user();
    if (queryRows.length > 0) {
      //print(queryRows);
      userExist = true;
      if (queryRows[0]["role"] == "STUDENT") {
        userProf = false;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isLoading
              ? new LoadingBouncingGrid.square()
              : userExist
                  ? userProf
                      ? AllClasseSubject()
                      : AllSubject()
                  : IntroScreen()),
    );
  }
}
