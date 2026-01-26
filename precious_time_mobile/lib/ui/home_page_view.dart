import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/shared/summary_box_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
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
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 249, 250, 251)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hola, María 👋', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30)),
                Text('Aquí está tu resumen de hoy', style: GoogleFonts.poppins(),)
              ],
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Resumen de hoy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SummaryBoxWidget(icon: Icons.timer_outlined, iconColor: Color.fromARGB(255, 43, 127, 255), label: 'Pendientes', totalTasks: 5, totalProjects: 2),
                    SummaryBoxWidget(icon: Icons.error_outline, iconColor: Color.fromARGB(255, 255, 105, 0), label: 'En progreso', totalTasks: 5, totalProjects: 2)
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SummaryBoxWidget(icon: Icons.check_circle_outline, iconColor: Color.fromARGB(255, 0, 201, 80), label: 'Completados', totalTasks: 5, totalProjects: 2),
                    SummaryBoxWidget(icon: Icons.moving, iconColor: Color.fromARGB(255, 173, 70, 255), label: 'Total hoy', totalTasks: 5, totalProjects: 2)
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resumen de hoy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text('Ver todos', style: GoogleFonts.poppins(color: Color.fromARGB(255, 21, 93, 255), fontSize: 12),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}