import 'package:flutter/material.dart';
import 'package:product_task/api_constant.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:product_task/reusetext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _priceTextController = TextEditingController();
  TextEditingController _discountTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 5, 5),
        foregroundColor: Colors.white,
      ),
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
                    'Add Product',
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
                  reuseTextField('Enter Price', Icons.price_change, true,
                      _priceTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Discount Price', Icons.mobile_friendly,
                      true, _discountTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reuseTextField('Enter Description', Icons.lock, true,
                      _descriptionTextController),
                  SizedBox(
                    height: 30,
                  ),
                  addProduct(context, true, () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    Provider.of<ProductProvider>(context, listen: false)
                        .addproducts(ApiUrl.addpost, {
                      'name': _nameTextController.text,
                      'moq': _descriptionTextController.text,
                      'price': _priceTextController.text,
                      'discounted_price': _discountTextController.text,
                      'user_login_token': prefs.getString('token').toString(),
                    }).then((value) {
                      if (value == 200) {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => HomeScreen(),
                          ),
                        );
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
