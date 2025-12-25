import 'package:flutter/material.dart';
import 'package:my_app/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  Function? onTap;
  int? quoteIndex;

  CustomAppBar(this.onTap, this.quoteIndex);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(), 
      child: Container(
        child: Text(
          sweetsaying[quoteIndex!], 
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
