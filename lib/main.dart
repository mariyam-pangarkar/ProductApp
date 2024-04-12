import 'package:flutter/material.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/login.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

bool isloggedin = false;
var initialroute = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future islogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('token') != null) {
        setState(() {
          isloggedin = true;
        });
      } else {
        setState(() {
          isloggedin = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      islogin();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (mounted) {
      islogin();
    }
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // TRY THIS: Try running your application with "flutter run". You'll see
    //     // the application has a purple toolbar. Then, without quitting the app,
    //     // try changing the seedColor in the colorScheme below to Colors.green
    //     // and then invoke "hot reload" (save your changes or press the "hot
    //     // reload" button in a Flutter-supported IDE, or press "r" if you used
    //     // the command line to start the app).
    //     //
    //     // Notice that the counter didn't reset back to zero; the application
    //     // state is not lost during the reload. To reset the state, use hot
    //     // restart instead.
    //     //
    //     // This works for code too, not just values: Most code changes can be
    //     // tested with just a hot reload.
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const Signin(),
    // );
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider(),
            builder: (context, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: !isloggedin ? Signin() : HomeScreen(),
                title: 'Product App',
              );
            },
          ),
        ],
      );
    });
  }
}
