import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPreciousTime extends StatefulWidget {
  const AppBarPreciousTime({super.key});

  @override
  State<AppBarPreciousTime> createState() => _AppBarPreciousTimeState();
}

class _AppBarPreciousTimeState extends State<AppBarPreciousTime> {
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/images/PreciousTimeLogo.svg', width: 35, height: 35,),
                SizedBox(width: 6,),
                Text('Precious Time', style: GoogleFonts.poppins(fontWeight: FontWeight.bold),)
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined, size: 37.5,))
          ],
        );
  }
}