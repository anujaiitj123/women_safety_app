
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/widgets/custom_appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 1;

  getRandomQuote(){
    Random random=Random();

    setState(() {
      qIndex=random.nextInt(2);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0), 
          child: Column(
            children: [
              CustomAppBar(getRandomQuote,qIndex), 
            ],
          ),
        ),
      ),
    );
  }
}
