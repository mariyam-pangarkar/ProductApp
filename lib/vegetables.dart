import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product_task/EditProduct.dart';
import 'package:product_task/addproduct.dart';
import 'package:product_task/api_constant.dart';
import 'package:product_task/homescreen.dart';
import 'package:product_task/productDesc.dart';
import 'package:product_task/providers/productprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map> showdata = [
  {
    'title': 'Boston Lettuce',
    'piece': '1.10',
    'image': 'images/img1.png',
  },
  {
    'title': 'Purple Cauliflower',
    'piece': '1.85',
    'image': 'images/img1.png',
  },
  {
    'title': 'Savouy Cabbage',
    'piece': '1.45',
    'image': 'images/img1.png',
  }
];
List<String> chipLabels = [
  'Cabbage and Lattuce 1',
  'Cucumber and tomato',
  'Onions and garlic',
  'Pappers',
  'Potatoes and ca'
];

Set<String> selectedChips = {};

class Vegetables_screen extends StatefulWidget {
  const Vegetables_screen({super.key});

  @override
  State<Vegetables_screen> createState() => _Vegetables_screenState();
}

class _Vegetables_screenState extends State<Vegetables_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    final newget = Provider.of<ProductProvider>(context, listen: false);
    newget.getallproducts();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Image.asset(
                'images/unnamed.png',
                alignment: Alignment.topRight,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 8),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const HomeScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Vegetables',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 2.0,
                    // runSpacing: 4.0,
                    children: chipLabels.map((label) {
                      Color backgroundColor = selectedChips.contains(label)
                          ? Color.fromARGB(255, 194, 162, 200)
                          : Colors.white;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedChips.contains(label)) {
                              selectedChips.remove(label);
                            } else {
                              selectedChips.add(label);
                            }
                          });
                        },
                        child: Chip(
                          label: Container(
                            child: Wrap(
                              children: [
                                selectedChips.contains(label)
                                    ? Icon(
                                        Icons.check,
                                        color: selectedChips.contains(label)
                                            ? Colors.purple
                                            : Colors.grey,
                                      )
                                    : Text(''),
                                Text(
                                  label,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: selectedChips.contains(label)
                                          ? Colors.purple
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: backgroundColor,
                          labelStyle: TextStyle(
                              color: selectedChips.contains(label)
                                  ? Colors.purple
                                  : Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                    child: Image.asset(
                                      'images/img1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          showdata[index]['title'].toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                showdata[index]['piece']
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                '/piece',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 136, 133, 133)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    color: Colors.white,
                                                  ),
                                                  child: IconButton(
                                                    color: Colors.grey,
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.green),
                                                  child: IconButton(
                                                    onPressed: () async {},
                                                    icon: Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                    itemCount: showdata.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    });
  }
}
