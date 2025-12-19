import 'package:d_input/d_input.dart';
import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
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
            print('🟣 LOGIN PAGE - State changed: ${state.runtimeType}');

            if (state is AuthSuccess) {
              print('🟣 LOGIN PAGE - AuthSuccess, navigasi ke main');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Login Berhasil'),
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
            } else if (state is AuthError) {
              print('🟣 LOGIN PAGE - AuthError: ${state.message}');
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

            return Padding(
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
                        color: Color(0xff1F41BB),
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

                  /// Email input
                  inputField('Email', null, _emailController),
                  SizedBox(height: 29),

                  /// Password input
                  inputField(
                    'Password',
                    IconSpec(
                      onTap: () {
                        obscure = !obscure;
                        setState(() {});
                      },
                      icon: obscure ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xff1F41BB),
                    ),
                    _passwordController,
                  ),
                  SizedBox(height: 53),

                  ///
                  GestureDetector(
                    onTap: () {
                      print('🟡 LOGIN PAGE - Tombol ditekan');
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        print('🟡 LOGIN PAGE - Validasi berhasil');
                        print('   Email: ${_emailController.text}');
                        print('   Password: ${_passwordController.text}');

                        context.read<AuthCubit>().login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      } else {
                        print('🔴 LOGIN PAGE - Validasi gagal');
                      }
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
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                    child: Text(
                      'Create an account',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget inputField(
    String hint,
    IconSpec? suffixIcon,
    TextEditingController controller,
  ) {
    return DInput(
      boxSpec: BoxSpec(
        border: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
        focusedBorder: BorderSide(color: Color(0xff1F41BB)),
      ),
      inputSpec: InputSpec(
        hint: hint,
        controller: controller,
        backgroundColor: Color(0xffF1F4FF),
        borderRadius: BorderRadius.circular(10),
        cursorColor: Color(0xff1F41BB),
        keyboardType: TextInputType.emailAddress,
        obscure: hint == 'Password' ? obscure : false,
      ),
      suffixIcon:
          suffixIcon ?? IconSpec(icon: Icons.email, color: Colors.transparent),
    );
  }
}
