import 'package:flutter/material.dart';
import 'package:product_task/api_constant.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:product_task/reusetext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProduct extends StatefulWidget {
  final data;
  const EditProduct({super.key, this.data});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _priceTextController = TextEditingController();
  TextEditingController _discountTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      _nameTextController.text = widget.data.name;
      _priceTextController.text = widget.data.price;
      _discountTextController.text = widget.data.discountedPrice;
      _descriptionTextController.text = widget.data.moq;
    }

    // setState(() {});
  }

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
                    'Edit Product',
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
                  addProduct(context, false, () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    Provider.of<ProductProvider>(context, listen: false)
                        .updateproduct(ApiUrl.editproduct, {
                      'user_login_token': prefs.getString('token').toString(),
                      'name': _nameTextController.text,
                      'moq': _descriptionTextController.text,
                      'price': _priceTextController.text,
                      'id': widget.data.id,
                      'discounted_price': _discountTextController.text,
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
