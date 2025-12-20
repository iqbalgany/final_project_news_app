import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
import 'package:final_project_news_app/consts/colors.dart';
import 'package:final_project_news_app/consts/routes.dart';
import 'package:final_project_news_app/data/locat_storage/auth_service.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(getIt<AuthService>()),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Login Berhasil'),
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(31, 97, 31, 0),
                child: Column(
                  children: [
                    /// Login here text
                    Center(
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: blueColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 26),

                    /// Welcome back text
                    Center(
                      child: Text(
                        'Welcome back you’ve\nbeen missed!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 74),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          inputField(
                            hint: 'Email',
                            controller: _emailController,
                            suffixIcon: null,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              if (!value.contains('@')) {
                                return 'Format email salah (harus mengandung @)';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Masukkan email yang valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 29),
                          inputField(
                            hint: 'Password',
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            suffixIcon: obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onIconTap: () {
                              obscure = !obscure;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 53),

                    ///
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blueColor,
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),

                    /// Password input
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.signup),
                      child: Text(
                        'Create an account',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget inputField({
    String? hint,
    IconData? suffixIcon,
    TextEditingController? controller,
    Function()? onIconTap,
    String? Function(String?)? validation,
  }) {
    return TextFormField(
      controller: controller,
      validator: validation,
      cursorColor: blueColor,
      obscureText: hint == 'Password' ? obscure : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF1F4FF),
        hint: Text(hint!, style: TextStyle(color: Colors.grey)),
        focusColor: blueColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blueColor),
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onIconTap, icon: Icon(suffixIcon))
            : null,
        suffixIconColor: blueColor,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
