import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_task/api_constant.dart';
import 'package:product_task/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  List<Productgenerate> getpostdata = [];
  ProductProvider() {}
  Future register(String url, Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var formData = <String, String>{};

    body.forEach((key, value) {
      formData[key] = value.toString();
    });

    // formData['user_token'] = prefs.getString('token') ?? '';

    final response = await http.post(
      Uri.parse(url),
      body: formData,
    );
    print('body ${response.body}');
    try {
      if (response.statusCode == 200) {
        try {
          var tokendata = response.body;
          Map<String, dynamic> responseMap = jsonDecode(tokendata);
          String userToken = responseMap['data']['user_token'];

          print(userToken);
          prefs.setString('token', userToken);
          return response.statusCode;
        } catch (e) {
          return response.body;
        }
      } else {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future login(String url, Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var formData = <String, String>{};

    body.forEach((key, value) {
      formData[key] = value.toString();
    });

    // formData['token'] = prefs.getString('token') ?? '';

    final response = await http.post(
      Uri.parse(url),
      body: formData,
    );
    print('body ${response.body}');
    try {
      if (response.statusCode == 200) {
        try {
          var tokendata = response.body;
          Map<String, dynamic> responseMap = jsonDecode(tokendata);
          String userToken = responseMap['data']['user_token'];

          print(userToken);
          prefs.setString('token', userToken);

          return response.statusCode;
        } catch (e) {
          print(e);
          return response.body;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getallproducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var formData = <String, String>{};
    formData['user_login_token'] = prefs.getString('token').toString();
    print('data ${formData}');

    final response = await http.post(
      Uri.parse(ApiUrl.getposts),
      body: formData,
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      getpostdata = [];
      for (int i = 0; i < jsonData.length; i++) {
        getpostdata.add(Productgenerate.fromJson(jsonData[i]));
      }
      notifyListeners();

      print('Products: $getpostdata');
    } else {
      print('Error: ${response.reasonPhrase}');
    }

    print('hvbhv${response.body}');
  }

  Future addproducts(String url, Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = <String, String>{};
      // formData['user_login_token'] = prefs.getString('token').toString();
      print('data ${formData}');
      body.forEach((key, value) {
        formData[key] = value.toString();
      });

      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print('Error: ${response.reasonPhrase}');
      }

      print('hvbhv${response.body}');
    } catch (e) {
      print(e);
    }
  }

  Future updateproduct(String url, Map<String, dynamic> body) async {
    print(body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = <String, String>{};

      print('data ${formData}');
      body.forEach((key, value) {
        formData[key] = value.toString();
      });

      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print('Error: ${response.reasonPhrase}');
      }
      print('hvbhv${response.body}');
    } catch (e) {
      print(e);
    }
  }

  Future deleteProduct(String url, Map<String, dynamic> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var formData = <String, String>{};

      body.forEach((key, value) {
        formData[key] = value.toString();
      });

      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print('Error: ${response.reasonPhrase}');
      }

      print('hvbhv${response.body}');
    } catch (e) {
      print(e);
    }
  }
}
