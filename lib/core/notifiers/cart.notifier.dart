import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '/core/api/cart.api.dart';
import '/core/models/cart.model.dart';
import '/core/utils/snackbar.util.dart';

class CartNotifier with ChangeNotifier {
  final CartAPI _cartAPI = CartAPI();

  Future checkCartData(
      {required BuildContext context, required String useremail}) async {
    try {
      var products =
          await _cartAPI.checkCartData(useremail: useremail, context: context);
      var response = CartData.fromJson(jsonDecode(products));

      final _productBody = response.data;
      final _productFilled = response.filled;
      final _productReceived = response.received;

      notifyListeners();
      if (_productReceived && _productFilled) {
        return _productBody;
      } else if (!_productFilled || !_productReceived) {
        return null;
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  Future addToCart({
    required String useremail,
    required String productPrice,
    required String productName,
    required String productCategory,
    required String productImage,
    required BuildContext context,
    required String productSize,
  }) async {
    try {
      var products = await _cartAPI.addToCart(
          useremail: useremail,
          productPrice: productPrice,
          productName: productName,
          productCategory: productCategory,
          productImage: productImage,
          context: context,
          productSize: productSize);
      var response = AddToCartModel.fromJson(
        jsonDecode(products),
      );

      final _productAdded = response.added;
      return _productAdded;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context,
        ),
      );
    }
  }

  void refresh() {
    notifyListeners();
  }

  Future deleteFromCart(
      {required BuildContext context, required dynamic productId}) async {
    try {
      var products =
          await _cartAPI.deleteFromCart(productId: productId, context: context);
      var response = CartDelete.fromJson(jsonDecode(products));

      final _productDeleted = response.deleted;

      return _productDeleted;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context,
        ),
      );
    }
  }
}
