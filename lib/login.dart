import 'package:flutter/material.dart';
import 'package:product_task/api_constant.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:product_task/register.dart';
import 'package:product_task/reusetext.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Email', Icons.verified_user, true,
                      _emailTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Password', Icons.lock, false,
                      _passwordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  signInbutton(context, true, () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .login(ApiUrl.login, {
                      'email': _emailTextController.text,
                      'password': _passwordTextController.text,
                    }).then((value) {
                      print(value);
                      if (value == 200) {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => HomeScreen(),
                          ),
                        );
                      }
                    });
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('dont have an account ?'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Signup(),
                          ),
                        );
                      },
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
