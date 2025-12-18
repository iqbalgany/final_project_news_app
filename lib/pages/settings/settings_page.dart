import 'package:final_project_news_app/blocs/auth_cubit.dart';
import 'package:final_project_news_app/utils/colors.dart';
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.notifications_none_outlined),
              title: Text('notifications'),
              trailing: Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.light_mode_outlined),
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
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.star_border),
              title: Text('Rate App'),
              trailing: Icon(Icons.chevron_right_sharp),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.share_outlined),
              title: Text('Share App'),
              trailing: Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),

              trailing: Icon(Icons.chevron_right_rounded),

              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.rule_outlined),
              title: Text('Terms & Conditions'),
              trailing: Icon(Icons.chevron_right_rounded),

              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.cookie_outlined),
              title: Text('Cookies Policy'),
              trailing: Icon(Icons.chevron_right_rounded),

              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.contact_phone_outlined),
              title: Text('Contact'),
              trailing: Icon(Icons.chevron_right_rounded),

              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text('Feedback'),
              trailing: Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 14),

            ListTile(
              leading: Icon(Icons.run_circle_outlined),
              title: Text('Logout'),
              trailing: IconButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                icon: Icon(Icons.logout_rounded),
              ),
            ),
            SizedBox(height: 14),
            Container(height: 1, color: blueColor),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
