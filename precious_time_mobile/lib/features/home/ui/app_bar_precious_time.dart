import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/service/reminder_service.dart';
import 'package:precious_time_mobile/features/home/bloc/reminder_bloc/reminder_bloc.dart';
import 'package:precious_time_mobile/features/home/ui/reminder_card.dart';

class AppBarPreciousTime extends StatefulWidget {
  const AppBarPreciousTime({super.key});

  @override
  State<AppBarPreciousTime> createState() => _AppBarPreciousTimeState();
}

class _AppBarPreciousTimeState extends State<AppBarPreciousTime> {
  late ReminderBloc reminderBloc;

  @override
  void initState() {
    super.initState();
    reminderBloc = ReminderBloc(ReminderService())
      ..add(ReminderFetchAllEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: reminderBloc,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/PreciousTimeLogo.svg',
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 6),
                Text(
                  'Precious Time',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Notificaciones',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder(
                            bloc: reminderBloc,
                            builder: (context, state) {
                              if (state is ReminderLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is ReminderSuccess) {
                                if (state.reminders.isEmpty) {
                                  return Text(
                                    'No hay notificaciones por ahora.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  );
                                } else {
                                  return SingleChildScrollView(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: state.reminders.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ReminderCard(
                                              id: state.reminders[index].id,
                                              title:
                                                  state.reminders[index].title,
                                              message: state
                                                  .reminders[index]
                                                  .message,
                                              read: state.reminders[index].read,
                                              reminderBloc: reminderBloc,
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              }
                              if (state is ReminderError) {
                                return Center(
                                  child: Text(
                                    'Error al cargar las notificaciones',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.notifications_outlined, size: 37.5),
            ),
          ],
        );
      },
    );
  }
}
