import 'package:d_input/d_input.dart';
import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              SizedBox(height: 29),

              /// Password input
              inputField('Phone Number', null, phoneNumberController),
              SizedBox(height: 53),

              /// Password input
              GestureDetector(
                onTap: () async {
                  await context.read<AuthCubit>().register(
                    emailController.text,
                    passwordController.text,
                    phoneNumberController.text,
                  );
                  if (mounted) {
                    Navigator.pop(context);
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
