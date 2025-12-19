import 'package:d_input/d_input.dart';
import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(getIt<AuthService>()),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            print('🟣 REGISTER PAGE - State changed: ${state.runtimeType}');

            if (state is AuthSuccess) {
              print('🟣 REGISTER PAGE - AuthSuccess, navigasi ke login');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Registrasi berhasil'),
                ),
              );
              Navigator.pop(context);
            } else if (state is AuthError) {
              print('🟣 REGISTER PAGE - AuthError: ${state.message}');
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
                    SizedBox(height: 29),

                    /// Password input
                    inputField('Phone Number', null, _phoneNumberController),
                    SizedBox(height: 53),

                    /// Password input
                    GestureDetector(
                      onTap: () {
                        print('🟡 REGISTER PAGE - Tombol ditekan');
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _phoneNumberController.text.isNotEmpty) {
                          print('🟡 REGISTER PAGE - Validasi berhasil');
                          print('   Email: ${_emailController.text}');
                          print('   Password: ${_passwordController.text}');
                          print('   Phone: ${_phoneNumberController.text}');

                          context.read<AuthCubit>().register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            phoneNumber: _phoneNumberController.text,
                          );
                        } else {
                          print('🔴 REGISTER PAGE - Validasi gagal');
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
