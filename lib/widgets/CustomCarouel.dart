import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/quotes.dart';

class Customcarousel extends StatelessWidget{
  const Customcarousel({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true, // while slideing it gets smaller and bigger
      ),
      items: List.generate(
      imageSliders.length, 
      (index)=>Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageSliders[index]))
          ),
          child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

              gradient:
                  LinearGradient(colors: [Colors.black,
                  Colors.transparent,
                  ])
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8,left: 8),
                child: Text(articleTitle[index],style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
                fontSize: MediaQuery.of(context).size.width*0.06,),
                ),
              )),
          ),
        ),
      ),
      ),
      ),
    );
  }
}