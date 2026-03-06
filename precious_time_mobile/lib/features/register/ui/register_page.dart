import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:precious_time_mobile/core/models/create_user_dto.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';
import 'package:precious_time_mobile/features/register/bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureVerifyPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    final username = _usernameController.text.trim();
    final name = _nameController.text.trim();
    final lastname = _lastnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final verifyPassword = _verifyPasswordController.text.trim();

    if (username.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        verifyPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    if (password != verifyPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    context.read<RegisterBloc>().add(
      RegisterCreateEvent(
        dto: CreateUserDto(
          username: username,
          name: name,
          lastname: lastname,
          email: email,
          password: password,
          verifyPassword: verifyPassword,
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF374151),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
            suffixIcon: onToggleObscure != null
                ? IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF9CA3AF),
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2B7CFF), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(UserService()),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFE8EDF5),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/PreciousTimeLogo.svg',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Precious Time',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Crea tu cuenta',
                      style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            label: 'Usuario',
                            controller: _usernameController,
                            hint: 'mariaaa',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: 'Nombre',
                            controller: _nameController,
                            hint: 'María',
                            icon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: 'Apellido',
                            controller: _lastnameController,
                            hint: 'García',
                            icon: Icons.badge_outlined,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: 'Correo electrónico',
                            controller: _emailController,
                            hint: 'maria@email.com',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: 'Contraseña',
                            controller: _passwordController,
                            hint: '••••••••',
                            icon: Icons.lock_outline,
                            obscure: _obscurePassword,
                            onToggleObscure: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: 'Confirmar contraseña',
                            controller: _verifyPasswordController,
                            hint: '••••••••',
                            icon: Icons.lock_outline,
                            obscure: _obscureVerifyPassword,
                            onToggleObscure: () {
                              setState(() => _obscureVerifyPassword = !_obscureVerifyPassword);
                            },
                          ),
                          const SizedBox(height: 28),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              final isLoading = state is RegisterLoading;
                              return SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _onRegisterPressed(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2B7CFF),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Registrarse',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Inicia sesión',
                            style: TextStyle(
                              color: Color(0xFF2B7CFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
