import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/edit_task_dto.dart';
import 'package:precious_time_mobile/core/service/category_service.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';
import 'package:precious_time_mobile/features/create_task/bloc/category_bloc/category_list_bloc.dart';
import 'package:precious_time_mobile/features/create_task/ui/category_card.dart';
import 'package:precious_time_mobile/features/edit_task/bloc/edit_task_bloc/task_edit_bloc.dart';
import 'package:precious_time_mobile/features/edit_task/bloc/task_bloc/task_bloc.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.id});
  final String id;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  String _selectedPriority = 'Media';
  int? _selectedCategory;
  DateTime? _selectedDate;
  final _titleForm = TextEditingController();
  final _descriptionForm = TextEditingController();
  late CategoryListBloc categoryListBloc;
  late TaskEditBloc taskEditBloc;
  late TaskBloc taskBloc;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    categoryListBloc = CategoryListBloc(CategoryService())
      ..add(CategoryListFetchAllEvent());
    taskEditBloc = TaskEditBloc(TaskService());
    taskBloc = TaskBloc(TaskService())
      ..add(TaskFetchEvent(id: int.parse(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Tarea',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        bloc: taskBloc,
        listener: (context, state) {
          if (state is TaskSuccess && !_initialized) {
            _initialized = true;
            setState(() {
              _selectedCategory = state.taskResponse.category.id;
              _titleForm.text = state.taskResponse.title;
              _descriptionForm.text = state.taskResponse.description;
              _selectedPriority =
                  state.taskResponse.priority.substring(0, 1).toUpperCase() +
                  state.taskResponse.priority.substring(1).toLowerCase();
              if (state.taskResponse.completedAt != null) {
                _selectedDate = DateTime.tryParse(state.taskResponse.completedAt!);
              }
            });
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 250, 251),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Título ',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '*',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 25),
                      Text(
                        'Descripción',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(Icons.flag_outlined),
                          Text(
                            'Prioridad',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Center(child: CircularProgressIndicator()),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 16),
                          Text(
                            'Fecha de vencimiento',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 30),
                      BlocConsumer<TaskEditBloc, TaskEditState>(
                        bloc: taskEditBloc,
                        listener: (context, state) {
                          if (state is TaskEditSuccess) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tarea creada exitosamente'),
                              ),
                            );
                          }
                          if (state is TaskEditError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Color.fromARGB(255, 21, 93, 252),
                              child: state is TaskEditLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Editar Tarea',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is TaskSuccess) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 250, 251),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Título ',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '*',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _titleForm,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 213, 220),
                            ),
                          ),
                          hintText: 'Ej: Revisar propuesta de diseño',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Color.fromARGB(255, 153, 161, 175),
                          ),
                        ),
                        style: GoogleFonts.poppins(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Descripción',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionForm,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 213, 220),
                            ),
                          ),
                          hintText: 'Describe los detalles de la tarea...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Color.fromARGB(255, 153, 161, 175),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          alignLabelWithHint: true,
                        ),
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(Icons.flag_outlined),
                          Text(
                            'Prioridad',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      FormField<String>(
                        initialValue:
                            state.taskResponse.priority.substring(0, 1) +
                            state.taskResponse.priority
                                .substring(1)
                                .toLowerCase(),
                        builder: (FormFieldState<String> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () => _selectedPriority = 'Alta',
                                        );
                                        state.didChange('Alta');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _selectedPriority == 'Alta'
                                            ? Colors.red
                                            : Colors.white,
                                        foregroundColor:
                                            _selectedPriority == 'Alta'
                                            ? Colors.white
                                            : Colors.black87,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Alta',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () => _selectedPriority = 'Media',
                                        );
                                        state.didChange('Media');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _selectedPriority == 'Media'
                                            ? Colors.deepOrange
                                            : Colors.white,
                                        foregroundColor:
                                            _selectedPriority == 'Media'
                                            ? Colors.white
                                            : Colors.black87,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Media',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(
                                          () => _selectedPriority = 'Baja',
                                        );
                                        state.didChange('Baja');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _selectedPriority == 'Baja'
                                            ? Colors.blue
                                            : Colors.white,
                                        foregroundColor:
                                            _selectedPriority == 'Baja'
                                            ? Colors.white
                                            : Colors.black87,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Baja',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(Icons.folder_copy_outlined),
                                  Text(
                                    ' Categoría',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              FormField<int>(
                                initialValue: _selectedCategory,
                                validator: (value) {
                                  if (value == null || value < 0) {
                                    return 'Por favor selecciona una categoría';
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<int> categoryFieldState) {
                                  return BlocBuilder(
                                    bloc: categoryListBloc,
                                    builder: (context, categoryState) {
                                      if (categoryState
                                          is CategoryListLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (categoryState
                                          is CategoryListSuccess) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 2.5,
                                                    crossAxisSpacing: 12,
                                                    mainAxisSpacing: 12,
                                                  ),
                                              itemCount: categoryState
                                                  .categories
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final category = categoryState
                                                    .categories[index];
                                                return CategoryCard(
                                                  color: hexToColor(
                                                    category.color,
                                                  ),
                                                  emoji: category.emoji,
                                                  label: category.name,
                                                  isSelected:
                                                      _selectedCategory ==
                                                      category.id,
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedCategory =
                                                          category.id;
                                                    });
                                                    categoryFieldState
                                                        .didChange(category.id);
                                                  },
                                                );
                                              },
                                            ),
                                            if (categoryFieldState.hasError)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  left: 12,
                                                ),
                                                child: Text(
                                                  categoryFieldState.errorText!,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 16),
                          Text(
                            'Fecha de vencimiento',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      FormField<DateTime>(
                        initialValue: state.taskResponse.completedAt != null
                            ? DateTime.tryParse(state.taskResponse.completedAt!)
                            : null,
                        validator: (value) {
                          if (_selectedDate == null) {
                            return 'Por favor selecciona una fecha';
                          }
                          return null;
                        },
                        builder: (FormFieldState<DateTime> dateState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  );
                                  if (date != null) {
                                    setState(() => _selectedDate = date);
                                    dateState.didChange(date);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: dateState.hasError
                                          ? Colors.red
                                          : Color.fromARGB(255, 209, 213, 220),
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedDate == null
                                            ? 'Selecciona una fecha'
                                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: _selectedDate == null
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (dateState.hasError)
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 12),
                                  child: Text(
                                    dateState.errorText!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      BlocConsumer<TaskEditBloc, TaskEditState>(
                        bloc: taskEditBloc,
                        listener: (context, editState) {
                          if (editState is TaskEditSuccess) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tarea editada exitosamente'),
                              ),
                            );
                          }
                          if (editState is TaskEditError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(editState.message)),
                            );
                          }
                        },
                        builder: (context, editState) {
                          // ✅ renombrado a editState
                          return SizedBox(
                            width: double.infinity,
                            child: FloatingActionButton(
                              onPressed:
                                  editState
                                      is TaskEditLoading // ✅ ahora sí es TaskEditBloc
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        taskEditBloc.add(
                                          TaskEditFetchEvent(
                                            id: int.parse(widget.id),
                                            editTaskDto: EditTaskDto(
                                              categoryId: _selectedCategory!,
                                              title: _titleForm.text,
                                              description:
                                                  _descriptionForm.text,
                                              priority: _selectedPriority,
                                              completedAt: _selectedDate!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                              backgroundColor: Color.fromARGB(255, 21, 93, 252),
                              child:
                                  editState
                                      is TaskEditLoading // ✅
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Editar Tarea',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
          // return SingleChildScrollView(
          //   child: Form(
          //     key: _formKey,
          //     child: Container(
          //       padding: EdgeInsets.all(24),
          //       decoration: BoxDecoration(
          //         color: Color.fromARGB(255, 249, 250, 251),
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             children: [
          //               Text(
          //                 'Título ',
          //                 style: GoogleFonts.poppins(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Text(
          //                 '*',
          //                 style: GoogleFonts.poppins(
          //                   color: Colors.red,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 10),
          //           TextFormField(
          //             controller: _titleForm,
          //             autofocus: true,
          //             decoration: InputDecoration(
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(16),
          //                 borderSide: BorderSide(
          //                   color: Color.fromARGB(255, 209, 213, 220),
          //                 ),
          //               ),
          //               hintText: 'Ej: Revisar propuesta de diseño',
          //               hintStyle: GoogleFonts.poppins(
          //                 fontSize: 18,
          //                 color: Color.fromARGB(255, 153, 161, 175),
          //               ),
          //             ),
          //             style: GoogleFonts.poppins(fontSize: 18),
          //             validator: (value) {
          //               if (value == null || value.isEmpty) {
          //                 return "El campo no puede estar vacío";
          //               }
          //               return null;
          //             },
          //           ),
          //           SizedBox(height: 25),
          //           Text(
          //             'Descripción',
          //             style: GoogleFonts.poppins(
          //               fontSize: 16,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //           SizedBox(height: 10),
          //           TextFormField(
          //             controller: _descriptionForm,
          //             maxLines: 5,
          //             decoration: InputDecoration(
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(16),
          //                 borderSide: BorderSide(
          //                   color: Color.fromARGB(255, 209, 213, 220),
          //                 ),
          //               ),
          //               hintText: 'Describe los detalles de la tarea...',
          //               hintStyle: GoogleFonts.poppins(
          //                 fontSize: 18,
          //                 color: Color.fromARGB(255, 153, 161, 175),
          //               ),
          //               contentPadding: EdgeInsets.symmetric(
          //                 horizontal: 16,
          //                 vertical: 16,
          //               ),
          //               alignLabelWithHint: true,
          //             ),
          //             style: GoogleFonts.poppins(fontSize: 18),
          //           ),
          //           SizedBox(height: 30),
          //           Row(
          //             children: [
          //               Icon(Icons.flag_outlined),
          //               Text(
          //                 'Prioridad',
          //                 style: GoogleFonts.poppins(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           FormField<String>(
          //             initialValue: _selectedPriority,
          //             builder: (FormFieldState<String> state) {
          //               return Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Expanded(
          //                         child: ElevatedButton(
          //                           onPressed: () {
          //                             setState(
          //                               () => _selectedPriority = 'Alta',
          //                             );
          //                             state.didChange('Alta');
          //                           },
          //                           style: ElevatedButton.styleFrom(
          //                             backgroundColor:
          //                                 _selectedPriority == 'Alta'
          //                                 ? Colors.red
          //                                 : Colors.white,
          //                             foregroundColor:
          //                                 _selectedPriority == 'Alta'
          //                                 ? Colors.white
          //                                 : Colors.black87,
          //                             padding: EdgeInsets.symmetric(
          //                               vertical: 12,
          //                             ),
          //                             shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(12),
          //                             ),
          //                           ),
          //                           child: Text(
          //                             'Alta',
          //                             style: GoogleFonts.poppins(
          //                               fontWeight: FontWeight.w500,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(width: 12),
          //                       Expanded(
          //                         child: ElevatedButton(
          //                           onPressed: () {
          //                             setState(
          //                               () => _selectedPriority = 'Media',
          //                             );
          //                             state.didChange('Media');
          //                           },
          //                           style: ElevatedButton.styleFrom(
          //                             backgroundColor:
          //                                 _selectedPriority == 'Media'
          //                                 ? Colors.deepOrange
          //                                 : Colors.white,
          //                             foregroundColor:
          //                                 _selectedPriority == 'Media'
          //                                 ? Colors.white
          //                                 : Colors.black87,
          //                             padding: EdgeInsets.symmetric(
          //                               vertical: 12,
          //                             ),
          //                             shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(12),
          //                             ),
          //                           ),
          //                           child: Text(
          //                             'Media',
          //                             style: GoogleFonts.poppins(
          //                               fontWeight: FontWeight.w500,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(width: 12),
          //                       Expanded(
          //                         child: ElevatedButton(
          //                           onPressed: () {
          //                             setState(
          //                               () => _selectedPriority = 'Baja',
          //                             );
          //                             state.didChange('Baja');
          //                           },
          //                           style: ElevatedButton.styleFrom(
          //                             backgroundColor:
          //                                 _selectedPriority == 'Baja'
          //                                 ? Colors.blue
          //                                 : Colors.white,
          //                             foregroundColor:
          //                                 _selectedPriority == 'Baja'
          //                                 ? Colors.white
          //                                 : Colors.black87,
          //                             padding: EdgeInsets.symmetric(
          //                               vertical: 12,
          //                             ),
          //                             shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(12),
          //                             ),
          //                           ),
          //                           child: Text(
          //                             'Baja',
          //                             style: GoogleFonts.poppins(
          //                               fontWeight: FontWeight.w500,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(height: 20),
          //                   Row(
          //                     children: [
          //                       Icon(Icons.folder_copy_outlined),
          //                       Text(
          //                         ' Categoría',
          //                         style: GoogleFonts.poppins(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   FormField<int>(
          //                     initialValue: _selectedCategory,
          //                     validator: (value) {
          //                       if (value == null || value < 0) {
          //                         return 'Por favor selecciona una categoría';
          //                       }
          //                       return null;
          //                     },
          //                     builder: (FormFieldState<int> categoryFieldState) {
          //                       return BlocBuilder(
          //                         bloc: categoryListBloc,
          //                         builder: (context, categoryState) {
          //                           if (categoryState is CategoryListLoading) {
          //                             return Center(
          //                               child: CircularProgressIndicator(),
          //                             );
          //                           }
          //                           if (categoryState is CategoryListSuccess) {
          //                             return Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 GridView.builder(
          //                                   shrinkWrap: true,
          //                                   physics:
          //                                       NeverScrollableScrollPhysics(),
          //                                   gridDelegate:
          //                                       SliverGridDelegateWithFixedCrossAxisCount(
          //                                         crossAxisCount: 2,
          //                                         childAspectRatio: 2.5,
          //                                         crossAxisSpacing: 12,
          //                                         mainAxisSpacing: 12,
          //                                       ),
          //                                   itemCount:
          //                                       categoryState.categories.length,
          //                                   itemBuilder: (context, index) {
          //                                     final category = categoryState
          //                                         .categories[index];
          //                                     return CategoryCard(
          //                                       color: hexToColor(
          //                                         category.color,
          //                                       ),
          //                                       emoji: category.emoji,
          //                                       label: category.name,
          //                                       isSelected:
          //                                           _selectedCategory ==
          //                                           category.id,
          //                                       onTap: () {
          //                                         setState(() {
          //                                           _selectedCategory =
          //                                               category.id;
          //                                         });
          //                                         categoryFieldState.didChange(
          //                                           category.id,
          //                                         );
          //                                       },
          //                                     );
          //                                   },
          //                                 ),
          //                                 if (categoryFieldState.hasError)
          //                                   Padding(
          //                                     padding: EdgeInsets.only(
          //                                       top: 8,
          //                                       left: 12,
          //                                     ),
          //                                     child: Text(
          //                                       categoryFieldState.errorText!,
          //                                       style: TextStyle(
          //                                         color: Colors.red,
          //                                         fontSize: 12,
          //                                       ),
          //                                     ),
          //                                   ),
          //                               ],
          //                             );
          //                           }
          //                           return Center(
          //                             child: CircularProgressIndicator(),
          //                           );
          //                         },
          //                       );
          //                     },
          //                   ),
          //                 ],
          //               );
          //             },
          //           ),
          //           Row(
          //             children: [
          //               Icon(Icons.calendar_today_outlined, size: 16),
          //               Text(
          //                 'Fecha de vencimiento',
          //                 style: GoogleFonts.poppins(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 10),
          //           FormField<DateTime>(
          //             validator: (value) {
          //               if (_selectedDate == null) {
          //                 return 'Por favor selecciona una fecha';
          //               }
          //               return null;
          //             },
          //             builder: (FormFieldState<DateTime> dateState) {
          //               return Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   InkWell(
          //                     onTap: () async {
          //                       final date = await showDatePicker(
          //                         context: context,
          //                         initialDate: DateTime.now(),
          //                         firstDate: DateTime.now(),
          //                         lastDate: DateTime(2030),
          //                       );
          //                       if (date != null) {
          //                         setState(() => _selectedDate = date);
          //                         dateState.didChange(date);
          //                       }
          //                     },
          //                     child: Container(
          //                       padding: EdgeInsets.all(16),
          //                       decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         border: Border.all(
          //                           color: dateState.hasError
          //                               ? Colors.red
          //                               : Color.fromARGB(255, 209, 213, 220),
          //                         ),
          //                         borderRadius: BorderRadius.circular(12),
          //                       ),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Text(
          //                             _selectedDate == null
          //                                 ? 'Selecciona una fecha'
          //                                 : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          //                             style: GoogleFonts.poppins(
          //                               fontSize: 16,
          //                               color: _selectedDate == null
          //                                   ? Colors.grey
          //                                   : Colors.black87,
          //                             ),
          //                           ),
          //                           Icon(
          //                             Icons.calendar_today,
          //                             color: Colors.grey,
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   if (dateState.hasError)
          //                     Padding(
          //                       padding: EdgeInsets.only(top: 8, left: 12),
          //                       child: Text(
          //                         dateState.errorText!,
          //                         style: TextStyle(
          //                           color: Colors.red,
          //                           fontSize: 12,
          //                         ),
          //                       ),
          //                     ),
          //                 ],
          //               );
          //             },
          //           ),
          //           SizedBox(height: 30),
          //           BlocConsumer<TaskEditBloc, TaskEditState>(
          //             bloc: taskEditBloc,
          //             listener: (context, state) {
          //               if (state is TaskEditSuccess) {
          //                 Navigator.pop(context);
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text('Tarea creada exitosamente'),
          //                   ),
          //                 );
          //               }
          //               if (state is TaskEditError) {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(content: Text(state.message)),
          //                 );
          //               }
          //             },
          //             builder: (context, state) {
          //               return SizedBox(
          //                 width: double.infinity,
          //                 child: FloatingActionButton(
          //                   onPressed: state is TaskEditLoading
          //                       ? null
          //                       : () {
          //                           if (_formKey.currentState!.validate()) {
          //                             taskEditBloc.add(
          //                               TaskEditFetchEvent(
          //                                 editTaskDto: EditTaskDto(
          //                                   categoryId: _selectedCategory!,
          //                                   title: _titleForm.text,
          //                                   description: _descriptionForm.text,
          //                                   priority: _selectedPriority,
          //                                   completedAt: _selectedDate!,
          //                                 ),
          //                               ),
          //                             );
          //                           }
          //                         },
          //                   backgroundColor: Color.fromARGB(255, 21, 93, 252),
          //                   child: state is TaskEditLoading
          //                       ? CircularProgressIndicator(color: Colors.white)
          //                       : Text(
          //                           'Editar Tarea',
          //                           style: GoogleFonts.poppins(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w500,
          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
