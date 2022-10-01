import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PremiumPage extends StatefulWidget {
  List<String> list = [
    " مستخدم VIP يمكنه ان يري من قام بالاعجاب به ",
    " مستخدم VIP يمكنه ان يخفي بعد البيانات الخاصة به  ",
    "يمكنه بدء المحادثة فورا مع الطرف الاخر بدون ارسال طلب"
  ];

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
              color: Colors.deepOrange[50],
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: Duration(milliseconds: 2000),
                  autoPlay: true,
                ),
                items: [
                  " يمكنه ان يري من قام بالاعجاب به ",
                  "  يمكنه ان يخفي بعد البيانات الخاصة به ",
                  "يمكنه بدء المحادثة فورا مع الطرف الاخر "
                ]
                    .map((item) => Container(
                          color: Colors.deepOrange[50],
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 90.0),
                                child: Text(
                                  "VIP ميزات المستخدم ال .",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(item.toString()),
                              )),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'VIPيرجى زيارة موقع وصال للتحويل ل ',
              style: TextStyle(
              color: Color.fromRGBO(255, 98, 101, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
