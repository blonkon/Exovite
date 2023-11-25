import 'package:exovite/data/Data.dart';
import 'package:exovite/screen/login.dart';
import 'package:exovite/screen/onboarding/screenone.dart';
import 'package:exovite/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('BD');

  //box.delete('firsttime');
  var val =  box.get('firsttime') ;
  box.put('firsttime', true)  ;
  print('firsttime: ${val}');
  val == null ? val = false : val = true;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Data())
      ],
      child: MyApp(firstTime: val),
    )
  );
}

class MyApp extends StatelessWidget {
  final bool firstTime ;
  const MyApp({super.key, required this.firstTime});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exovite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        scaffoldBackgroundColor:Color.fromRGBO(235, 242, 250, 1),
        textTheme: TextTheme(
          headlineLarge: TextStyle().copyWith( fontSize: 32,fontWeight: FontWeight.bold)
        ),
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(6, 102, 142, 1),
        useMaterial3: true,
      ),
      //Splash_screen(firstTime: this.firstTime,),
      home: Splash_screen(firstTime: this.firstTime,),
    );
  }
}
