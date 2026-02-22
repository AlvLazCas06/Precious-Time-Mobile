import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/features/create_task/ui/category_card.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedPriority = 'Media';
  String? _selectedCategory;
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _categories = [
    {'emoji': '🎨', 'label': 'Diseño', 'color': Colors.purple},
    {'emoji': '💻', 'label': 'Desarrollo', 'color': Colors.blue},
    {'emoji': '📝', 'label': 'Documentación', 'color': Colors.green},
    {'emoji': '👥', 'label': 'Reuniones', 'color': Colors.orange},
    {'emoji': '🔍', 'label': 'Code Review', 'color': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Tarea',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                  initialValue: _selectedPriority,
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() => _selectedPriority = 'Alta');
                                  state.didChange('Alta');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedPriority == 'Alta'
                                      ? Colors.red
                                      : Colors.white,
                                  foregroundColor: _selectedPriority == 'Alta'
                                      ? Colors.white
                                      : Colors.black87,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                                  setState(() => _selectedPriority = 'Media');
                                  state.didChange('Media');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedPriority == 'Media'
                                      ? Colors.deepOrange
                                      : Colors.white,
                                  foregroundColor: _selectedPriority == 'Media'
                                      ? Colors.white
                                      : Colors.black87,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                                  setState(() => _selectedPriority = 'Baja');
                                  state.didChange('Baja');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedPriority == 'Baja'
                                      ? Colors.blue
                                      : Colors.white,
                                  foregroundColor: _selectedPriority == 'Baja'
                                      ? Colors.white
                                      : Colors.black87,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
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
                        FormField<String>(
                          initialValue: _selectedCategory,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor selecciona una categoría';
                            }
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.5,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: _categories.length,
                                  itemBuilder: (context, index) {
                                    final category = _categories[index];
                                    return CategoryCard(
                                      color: category['color'],
                                      emoji: category['emoji'],
                                      label: category['label'],
                                      isSelected:
                                          _selectedCategory ==
                                          category['label'],
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = category['label'];
                                        });
                                        state.didChange(category['label']);
                                      },
                                    );
                                  },
                                ),
                                if (state.hasError)
                                  Padding(
                                    padding: EdgeInsets.only(top: 8, left: 12),
                                    child: Text(
                                      state.errorText!,
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
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 209, 213, 220),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icon(Icons.calendar_today, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Color.fromARGB(255, 21, 93, 252),
                    child: Text(
                      'Crear Tarea',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
