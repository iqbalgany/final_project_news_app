import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/notification.svg'),
              title: Text('notifications'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/dark_mode.svg'),
              title: Text('Theme'),
              trailing: Switch(
                value: darkMode,
                onChanged: (value) => setState(() {
                  darkMode = value;
                }),
              ),
              onTap: null,
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/star.svg'),
              title: Text('Rate App'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/share.svg'),
              title: Text('Share App'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/privacy.svg'),
              title: Text('Privacy Policy'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/terms and policy.svg'),
              title: Text('Terms & Conditions'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/cookies.svg'),
              title: Text('Cookies Policy'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/message.svg'),
              title: Text('Contact'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/feedback.svg'),
              title: Text('Feedback'),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 14),

            ListTile(
              // leading: SvgPicture.asset('assets/Logout.svg'),
              title: Text('Logout'),
              trailing: IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logut();

                  Navigator.restorablePushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                icon: Icon(Icons.logout_rounded),
              ),
            ),
            SizedBox(height: 14),
            Container(height: 1, color: Colors.grey[400]),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
