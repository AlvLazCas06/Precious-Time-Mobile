import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:precious_time_mobile/core/models/edit_preference_dto.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/preference_service.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';
import 'package:precious_time_mobile/features/settings/bloc/preference_bloc/preference_bloc.dart';
import 'package:precious_time_mobile/features/settings/bloc/user_bloc/user_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.preference});

  final PreferenceResponse? preference;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _formDarkMode = false;
  bool _formNotificationsActive = false;
  String _formType = 'IN_APP';
  int _preferenceId = 1;
  bool _prefInitialized = false;

  late UserBloc userBloc;
  late PreferenceBloc preferenceBloc;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.preference?.theme == 'dark';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              userBloc = UserBloc(UserService())..add(UserFetchEvent()),
        ),
        BlocProvider(
          create: (context) =>
              preferenceBloc = PreferenceBloc(PreferenceService())
                ..add(PreferenceFetchEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: widget.preference?.theme == 'dark'
                    ? const Color(0xFF1E2939)
                    : const Color.fromARGB(255, 249, 250, 251),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perfil de usuario',
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : null,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder(
                    bloc: BlocProvider.of<UserBloc>(context),
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(width: 20),
                                  CircularProgressIndicator(),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: Color.fromARGB(255, 106, 114, 130),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontSize: 14,
                                        ),
                                      ),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: Color.fromARGB(255, 106, 114, 130),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontSize: 14,
                                        ),
                                      ),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is UserSuccess) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    child: Text(
                                      '${state.user?.name.substring(0, 1)}',
                                      style: GoogleFonts.poppins(
                                        color: isDark ? Colors.white : null,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: GoogleFonts.poppins(color: isDark ? Colors.white : null),
                                      ),
                                      Text(
                                        '${state.user?.username}',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: Color.fromARGB(255, 106, 114, 130),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${state.user?.name}',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: Color.fromARGB(255, 106, 114, 130),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.white : null,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          '${state.user?.email}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: isDark ? Colors.white : null,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is UserError) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(child: Text(state.message, style: GoogleFonts.poppins(color: isDark ? Colors.white : null))),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  child: CircularProgressIndicator(),
                                ),
                                SizedBox(width: 20),
                                CircularProgressIndicator(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color.fromARGB(255, 106, 114, 130),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nombre',
                                      style: GoogleFonts.poppins(color: isDark ? Colors.white : null, fontSize: 14),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: Color.fromARGB(255, 106, 114, 130),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: GoogleFonts.poppins(color: isDark ? Colors.white : null, fontSize: 14),
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Configuración de la aplicación',
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : null,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocConsumer<PreferenceBloc, PreferenceState>(
                    bloc: BlocProvider.of<PreferenceBloc>(context),
                    listener: (context, state) {
                      if (!_prefInitialized &&
                          (state is PreferenceSuccess ||
                              state is PreferenceEditSuccess)) {
                        final pref = state is PreferenceSuccess
                            ? state.preferenceResponse
                            : (state as PreferenceEditSuccess).preferenceResponse;
                        setState(() {
                          _prefInitialized = true;
                          _preferenceId = pref.id ?? 1;
                          _formDarkMode = pref.theme.toLowerCase() == 'dark';
                          _formNotificationsActive = pref.notificationsActive;
                          final rawType = pref.type.toUpperCase();
                          _formType = rawType == 'EMAIL' ? 'EMAIL' : 'IN_APP';
                        });
                      }
                      if (state is PreferenceEditSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preferencias guardadas exitosamente'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      if (state is PreferenceError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PreferenceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF364153)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  _formDarkMode
                                      ? Icons.dark_mode_outlined
                                      : Icons.wb_sunny_outlined,
                                  color: Color.fromARGB(255, 255, 105, 0),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tema de la aplicación',
                                      style: GoogleFonts.poppins(
                                        color: isDark ? Colors.white : null,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      _formDarkMode ? 'Modo oscuro' : 'Modo claro',
                                      style: GoogleFonts.poppins(
                                        color: isDark ? Colors.white : null,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                FlutterSwitch(
                                  value: _formDarkMode,
                                  width: 60,
                                  activeColor: Color.fromARGB(255, 21, 93, 252),
                                  inactiveColor:
                                      Color.fromARGB(255, 209, 213, 220),
                                  onToggle: (val) {
                                    setState(() {
                                      _formDarkMode = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF364153)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notifications_outlined,
                                      color: Color.fromARGB(255, 173, 70, 255),
                                      size: 28,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Canal de notificaciones',
                                      style: GoogleFonts.poppins(
                                        color: isDark ? Colors.white : null,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                DropdownButtonFormField<String>(
                                  value: _formType,
                                  decoration: InputDecoration(
                                    labelText: 'Selecciona una opción',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: <String>['IN_APP', 'EMAIL']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                      .toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _formType = newValue;
                                      });
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor selecciona una opción';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Notificaciones activas',
                                      style: GoogleFonts.poppins(
                                        color: isDark ? Colors.white : null,
                                        fontSize: 16,
                                      ),
                                    ),
                                    FlutterSwitch(
                                      value: _formNotificationsActive,
                                      width: 60,
                                      activeColor:
                                          Color.fromARGB(255, 21, 93, 252),
                                      inactiveColor:
                                          Color.fromARGB(255, 209, 213, 220),
                                      onToggle: (val) {
                                        setState(() {
                                          _formNotificationsActive = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is PreferenceLoading
                                  ? null
                                  : () {
                                      BlocProvider.of<PreferenceBloc>(context)
                                          .add(
                                        PreferenceEditEvent(
                                          id: _preferenceId,
                                          dto: EditPreferenceDto(
                                            theme: _formDarkMode
                                                ? 'DARK'
                                                : 'LIGHT',
                                            type: _formType,
                                            notificationsActive:
                                                _formNotificationsActive,
                                          ),
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 21, 93, 252),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Guardar preferencias',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Color.fromARGB(255, 251, 44, 54),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                            size: 26,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Cerrar sesión',
                            style: GoogleFonts.poppins(
                              color: widget.preference?.theme == 'dark' ? const Color(0xFF364153) : Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
