import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
final List<String> imglist =[
    'https://images.pexels.com/photos/14969996/pexels-photo-14969996.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1721932/pexels-photo-1721932.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/7180857/pexels-photo-7180857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
  ];
  int currentIndex=0;
class MySlider extends StatelessWidget {
  const MySlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CarouselSlider(items: imglist.map((item)=> Center(
           child: Padding(
             padding: const EdgeInsets.fromLTRB(3,10,10,3),
             child: ClipRRect(
               borderRadius: const BorderRadius.all(Radius.circular(3)),
               
               child: Image.network(
                 item,
                 fit: BoxFit.cover,
                 width: 1000,
               ),
             ),
           ),
         )).toList(), 
         options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio:2.0,
         ),
         ),
         
      ],
    );
  }
}