import 'dart:convert';
import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import '/app/constants/app.keys.dart';
import '/app/routes/app.routes.dart';
import '/core/api/user.api.dart';
import '/core/models/update.user.model.dart';
import '/core/models/user.model.dart';
import '/core/models/userDetails.model.dart';
import '/core/utils/snackbar.util.dart';

class UserNotifier with ChangeNotifier {
  final UserAPI _userAPI = UserAPI();

  String? userEmail = 'Not Available';
  String? get getUserEmail => userEmail;

  String? userName;
  String? get getUserName => userName;

  String userAddress = 'Not Available';
  String get getuserAddress => userAddress;

  String userPhoneNumber = 'Not Available';
  String get getuserPhoneNumber => userPhoneNumber;

  Future getUserData({
    required String token,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.getUserData(token: token);
      var response = UserModel.fromJson(jsonDecode(userData));

      final _data = response.data;
      final _received = response.received;

      if (!_received) {
        notifyListeners();
        Navigator.of(context)
            .pushReplacementNamed(AppRouter.loginRoute)
            .whenComplete(
              () => DeleteCache.deleteKey(AppKeys.userData).whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackUtil.stylishSnackBar(
                        text: 'Oops Session Timeout', context: context),
                  );
                }),
            );
      } else {
        userEmail = _data.email;
        userName = _data.username;
        notifyListeners();
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future getUserDetails({
    required String userEmail,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.getUserDetails(userEmail: userEmail);
      var response = UserDetails.fromJson(jsonDecode(userData));
      final _data = response.data;
      final _filled = response.filled;
      final _received = response.received;

      if (_received && _filled) {
        userAddress = _data.userAddress;
        userPhoneNumber = _data.userPhoneNo;
        userEmail = _data.user.useremail;
        userName = _data.user.username;
        notifyListeners();
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future updateUserDetails({
    required String userEmail,
    required String userAddress,
    required String userPhoneNo,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.updateUserDetails(
          userEmail: userEmail,
          userAddress: userAddress,
          userPhoneNo: userPhoneNo);
      var response = UpdateUser.fromJson(jsonDecode(userData));
      final _updated = response.updated;
      notifyListeners();

      return _updated;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future changePassword({
    required String userEmail,
    required String oluserpassword,
    required String newuserpassword,
    required BuildContext context,
  }) async {
    try {
      var userData = await _userAPI.changePassword(
          userEmail: userEmail,
          oluserpassword: oluserpassword,
          newuserpassword: newuserpassword);

      var response = ChangeUserPassword.fromJson(jsonDecode(userData));
      final _updated = response.updated;

      notifyListeners();

      return _updated;
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }
}
