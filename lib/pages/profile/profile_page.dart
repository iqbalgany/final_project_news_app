import 'package:d_input/d_input.dart';
import 'package:final_project_news_app/blocs/auth/auth_cubit.dart';
import 'package:final_project_news_app/blocs/auth/auth_state.dart';
import 'package:final_project_news_app/consts/colors.dart';
import 'package:final_project_news_app/consts/routes.dart';
import 'package:final_project_news_app/helpers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().checkAuthStatus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Profile berhasil diupdate!'),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is! AuthSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Silakan login terlebih dahulu'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              );
            }

            final user = state.user;

            if (_nameController.text != user.name) {
              _nameController.text = user.name ?? '';
            }
            if (_addressController.text != user.address) {
              _addressController.text = user.address ?? '';
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AuthCubit>().fetchUser();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    SizedBox(height: 30),
                    ListTile(
                      title: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: blueColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                          'https://tse3.mm.bing.net/th/id/OIP.IvQ6zp4yhQsC3MFzlkrhTgHaHa?w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
                        ),
                      ),
                    ),
                    SizedBox(height: 40),

                    /// Fields 1: Name
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text(user.name ?? "-"),
                      ),
                    ),
                    SizedBox(height: 20),

                    /// Fields 2: Email
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.email_outlined),
                        title: Text(user.email),
                      ),
                    ),
                    SizedBox(height: 20),

                    /// Fields 3: Phone
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.phone_android_outlined),
                        title: Text(user.phoneNumber),
                      ),
                    ),
                    SizedBox(height: 20),

                    /// Fields 4: Address
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.home_outlined),
                        title: Text(user.address ?? "-"),
                      ),
                    ),
                    SizedBox(height: 20),

                    FilledButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          backgroundColor: Colors.white,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DInput(
                                boxSpec: BoxSpec(
                                  border: BorderSide(color: blueColor),
                                  borderRadius: BorderRadius.circular(10),
                                  focusedBorder: BorderSide(
                                    color: Color(0xff1F41BB),
                                  ),
                                ),
                                inputSpec: InputSpec(
                                  hint: 'Name',
                                  controller: _nameController,
                                  borderRadius: BorderRadius.circular(10),
                                  cursorColor: Color(0xff1F41BB),
                                ),
                              ),
                              SizedBox(height: 10),
                              DInput(
                                boxSpec: BoxSpec(
                                  border: BorderSide(color: blueColor),
                                  borderRadius: BorderRadius.circular(10),
                                  focusedBorder: BorderSide(
                                    color: Color(0xff1F41BB),
                                  ),
                                ),
                                inputSpec: InputSpec(
                                  hint: 'Address',
                                  controller: _addressController,
                                  borderRadius: BorderRadius.circular(10),
                                  cursorColor: Color(0xff1F41BB),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: blueColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Use the outer context that has access to AuthCubit
                                await context.read<AuthCubit>().updateProfile(
                                  name: _nameController.text.trim(),
                                  address: _addressController.text.trim(),
                                );
                                Navigator.pop(dialogContext);
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(color: blueColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(blueColor),
                        minimumSize: WidgetStatePropertyAll(
                          Size(double.infinity, 60),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: Text('Edit'),
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
}
