import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/home/ui/task_sub_card.dart';
import 'package:precious_time_mobile/features/task_list/bloc/task_list_bloc.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.id,
    required this.label,
    required this.description,
    required this.status,
    required this.priority,
    this.date,
    required this.emoji,
    required this.category,
    required this.color,
    required this.taskListBloc
  });

  final int id;
  final String label;
  final String description;
  final String status;
  final String priority;
  final String? date;
  final String emoji;
  final String category;
  final Color color;
  final TaskListBloc taskListBloc;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              BlocConsumer<TaskListBloc, TaskListState>(
                bloc: widget.taskListBloc,
                listener: (context, state) {
                  if (state is TaskCompleteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tarea completeda exitosamente')),
                    );
                  }
                  if (state is TaskListError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: 37.5,
                    height: 37.5,
                    child: FloatingActionButton(
                      onPressed: state is TaskListLoading
                          ? null
                          : () {
                              widget.taskListBloc.add(TaskCompleteEvent(id: widget.id));
                            },
                      backgroundColor: widget.status == 'pendiente'
                          ? Color.fromARGB(255, 43, 127, 255)
                          : Color.fromARGB(255, 100, 221, 148),

                      child: Icon(
                        widget.status == 'pendiente'
                            ? Icons.circle
                            : Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 37.5,
                height: 37.5,
                child: FloatingActionButton(
                  onPressed: () {
                    String id = widget.id.toString();
                    Navigator.pushNamed(context, '/task/edit', arguments: id);
                  },
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
              SizedBox(height: 10),
              BlocConsumer<TaskListBloc, TaskListState>(
                bloc: widget.taskListBloc,
                listener: (context, state) {
                  if (state is TaskDeleteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tarea eliminada exitosamente')),
                    );
                  }
                  if (state is TaskListError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: 37.5,
                    height: 37.5,
                    child: FloatingActionButton(
                      onPressed: state is TaskListLoading
                          ? null
                          : () {
                              widget.taskListBloc.add(TaskDeleteEvent(id: widget.id));
                            },
                      backgroundColor: Colors.red,
                      child: state is TaskListLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Icon(Icons.delete, color: Colors.white, size: 20),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 275,
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                SizedBox(
                  width: 275,
                  child: Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TaskSubCard(
                      color: widget.color,
                      emoji: widget.emoji,
                      label: widget.category,
                    ),
                    SizedBox(width: 20),
                    TaskSubCard(
                      color: widget.priority.toLowerCase() == 'alta'
                          ? Colors.red
                          : widget.priority.toLowerCase() == 'media'
                          ? Colors.deepOrangeAccent
                          : Colors.blueAccent,
                      label:
                          widget.priority.substring(0, 1).toUpperCase() +
                          widget.priority.substring(1),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  width: 110,
                  decoration: BoxDecoration(
                    color: widget.status == 'pendiente'
                        ? Color.fromARGB(255, 219, 234, 254)
                        : Color.fromARGB(255, 231, 251, 239),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      widget.status.substring(0, 1).toUpperCase() + widget.status.substring(1),
                      style: GoogleFonts.poppins(
                        color: widget.status == 'pendiente'
                            ? Color.fromARGB(255, 20, 71, 230)
                            : Color.fromARGB(255, 102, 179, 134),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text(widget.date ?? ''),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
