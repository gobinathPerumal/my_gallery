import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_gallery/screens/homeScreen.dart';
import 'package:my_gallery/utils/PermissionUtil.dart';
import 'package:my_gallery/values/colors.dart';
import 'package:my_gallery/values/keys.dart';
import 'package:my_gallery/values/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Gallery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext bcontext;
  String userName = "", isLogin = "", passWord = "";

  @override
  Widget build(BuildContext context) {
    bcontext = context;
    return Scaffold(
      backgroundColor: UIColor.colorPrimary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Splashscren_withlogo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _startSplash() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  void initState() {
    checkStoragePermission();
  }

  checkStoragePermission() async {
    var permissionValue = await PermissionUtil().getStoragePermission();
    if (permissionValue == Keys.permission_granted)
      _startSplash();
    else if (permissionValue == Keys.permission_denied)
      checkStoragePermission();
    else {
      Fluttertoast.showToast(
        msg: UIStrings.txt_storage_permission_request,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
