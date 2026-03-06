import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/bloc/reminder_bloc/reminder_bloc.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({
    super.key,
    required this.id,
    required this.title,
    required this.message,
    required this.read,
    required this.reminderBloc,
  });

  final int id;
  final String title;
  final String message;
  final bool read;
  final ReminderBloc reminderBloc;

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 234, 234),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          BlocConsumer<ReminderBloc, ReminderState>(
            bloc: widget.reminderBloc,
            listener: (context, state) {
              if (state is ReminderReadSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Marcada como leida')));
              }
              if (state is ReminderError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: 37.5,
                height: 37.5,
                child: IconButton(
                  onPressed: state is ReminderLoading
                      ? null
                      : () {
                          widget.reminderBloc.add(
                            ReminderReadEvent(id: widget.id),
                          );
                        },

                  icon: Icon(
                    widget.read 
                    ? Icons.check 
                    : Icons.visibility,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(child: Text(widget.message, style: GoogleFonts.poppins())),
        ],
      ),
    );
  }
}
