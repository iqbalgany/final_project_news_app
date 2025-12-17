import 'package:d_input/d_input.dart';
import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            SizedBox(height: 74),

            /// Email input
            inputField('Email', null, emailController),
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
              passwordController,
            ),
            SizedBox(height: 53),

            /// Password input
            GestureDetector(
              onTap: () async {
                await context.read<AuthCubit>().login(
                  emailController.text,
                  passwordController.text,
                );

                if (context.read<AuthCubit>().state.isAuthenticated) {
                  Navigator.restorablePushNamed(context, AppRoutes.mainMenu);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login gagal, periksa email/password'),
                    ),
                  );
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
