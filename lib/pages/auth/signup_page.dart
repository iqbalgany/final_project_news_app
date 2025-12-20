import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
import 'package:final_project_news_app/consts/colors.dart';
import 'package:final_project_news_app/data/locat_storage/auth_service.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
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
                  content: Text('Registrasi berhasil'),
                ),
              );
              Navigator.pop(context);
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
                padding: const EdgeInsets.fromLTRB(31, 97, 31, 30),
                child: Column(
                  children: [
                    /// Login here text
                    Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff1F41BB),
                        ),
                      ),
                    ),
                    SizedBox(height: 26),

                    /// Welcome back text
                    Center(
                      child: Text(
                        'Join us today to get\nconnected!',
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
                          SizedBox(height: 29),
                          inputField(
                            hint: 'Phone Number',
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomor telepon tidak boleh kosong';
                              }
                              String pattern =
                                  r'^(?:\+62|62|0)8[1-9][0-9]{7,10}$';
                              RegExp regExp = RegExp(pattern);

                              if (!regExp.hasMatch(value)) {
                                return 'Masukkan Nomor Indonesia (Ex: 0812..)';
                              }
                              return null;
                            },
                            controller: _phoneNumberController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 53),

                    ///
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            phoneNumber: _phoneNumberController.text,
                          );
                        } else {}
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1F41BB),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
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
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Already have an account? Sign In',
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
