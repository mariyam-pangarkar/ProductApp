import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_task/api_constant.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:product_task/reusetext.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _mobileTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 5, 5, 5),
                  Color.fromARGB(255, 203, 201, 195),
                ]),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20.0, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField(
                      'Enter Name', Icons.abc, true, _nameTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Email', Icons.verified_user, true,
                      _emailTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Mobile', Icons.mobile_friendly, true,
                      _mobileTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Password', Icons.lock, false,
                      _passwordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  signInbutton(context, false, () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .register(ApiUrl.register, {
                      'name': _nameTextController.text,
                      'email': _emailTextController.text,
                      'mobile': _mobileTextController.text,
                      'password': _passwordTextController.text,
                    }).then((value) {
                      // print('vaye ${value['message']}');

                      if (value == 200) {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => HomeScreen(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Something went wrong',
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.BOTTOM);
                      }
                    });
                    // Navigator.push<void>(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => HomeScreen(),
                    //   ),
                    // );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
