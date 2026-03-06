import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';
import 'package:precious_time_mobile/features/create_project/bloc/project_create_bloc.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _endDate;
  late ProjectCreateBloc projectCreateBloc;

  @override
  void initState() {
    super.initState();
    projectCreateBloc = ProjectCreateBloc(ProjectService());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Nuevo Proyecto',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 249, 250, 251),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Nombre del proyecto ',
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  maxLength: 50,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 209, 213, 220),
                      ),
                    ),
                    hintText: 'Ej. Rediseño de la aplicación móvil',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 153, 161, 175),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del proyecto';
                    }
                    if (value.length > 255) {
                      return 'El número de carácteres es mayor al permitido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                Text(
                  'Descripción',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 209, 213, 220),
                      ),
                    ),
                    hintText:
                        'Describe los objetivos y\nalcance del proyecto...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 153, 161, 175),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    alignLabelWithHint: true,
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                  validator: (value) {
                    if (value != null && value.length > 2000) {
                      return 'Has excedido el número máximo de carácteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 16),
                    Text(
                      ' Fecha de fin',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FormField<DateTime>(
                  validator: (value) {
                    if (_endDate == null) {
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
                              setState(() => _endDate = date);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _endDate == null
                                      ? 'Selecciona una fecha'
                                      : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: _endDate == null
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                                Icon(Icons.calendar_today, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        if (dateState.hasError)
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 12),
                            child: Text(
                              dateState.errorText!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocConsumer<ProjectCreateBloc, ProjectCreateState>(
                  bloc: projectCreateBloc,
                  listener: (context, state) {
                    if (state is ProjectCreateSuccess) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tarea creada exitosamente')),
                      );
                    }
                    if (state is ProjectCreateError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton(
                        onPressed: state is ProjectCreateLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  projectCreateBloc.add(
                                    ProjectCreateFetchEvent(
                                      dto: CreateProjectDto(
                                        name: _nameController.text,
                                        description: _descriptionController.text,
                                        finishDate: _endDate!
                                      ),
                                    ),
                                  );
                                }
                              },
                        backgroundColor: Color.fromARGB(255, 21, 93, 252),
                        child: state is ProjectCreateLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Crear Proyecto',
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
      ),
    );
  }
}
