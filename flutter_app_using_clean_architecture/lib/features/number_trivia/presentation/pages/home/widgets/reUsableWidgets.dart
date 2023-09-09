import 'package:flutter/material.dart';

Widget MessageDisplayWidget({
  required String message,
  required double fontSize,
  required Color textColor,
}) {
  return Center(
    child: SingleChildScrollView(
      child: Text(
        message,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget LoadingWidget() {
  return Center(
      child: CircularProgressIndicator(
    color: Colors.blue,
    strokeWidth: 4,
  ));
}

Widget DisplayLoadedWidget({
  required int number,
  required String text,
}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 10),
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )
    ],
  );
}


