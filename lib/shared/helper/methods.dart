import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mangers/colors.dart';
import 'mangers/constants.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void navigateToWithAnimation(context, widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          }));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(' firebaseMessagingBackground  ${message.data['uid']}');
}
void genrateToken(String uid) {
  FirebaseMessaging.instance.getToken().then((token) {
    FirebaseFirestore.instance.collection(ConstantsManger.USERS).doc(uid).update({
      'token': token,
    });
  });
}

void showSnackBar(BuildContext context, String errorMsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(errorMsg),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 5),
  ));
}

void showCustomProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorsManger.primaryColor),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

String formatDate({required DateTime dateTime}){
  return DateFormat.yMMMd().format(dateTime);
}
