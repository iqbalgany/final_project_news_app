import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),

            Center(
              child: Stack(
                children: [
                  /// Profile Picture
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(
                      'https://tse3.mm.bing.net/th/id/OIP.IvQ6zp4yhQsC3MFzlkrhTgHaHa?w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
                    ),
                  ),

                  /// Edit Button
                  Positioned(
                    bottom: 4,
                    right: 6,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            /// Fields 1: Name
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(title: Text('Thomas Shelby'), onTap: () {}),
            ),
            SizedBox(height: 20),

            /// Fields 2: Email
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: Text('Thomas.Shelby@example.com'),
                onTap: () {},
              ),
            ),
            SizedBox(height: 20),

            /// Fields 3: Phone
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(title: Text('+1 (555) 123-4567'), onTap: () {}),
            ),
            SizedBox(height: 20),

            /// Fields 4: Address
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(title: Text('Birmingham, UK'), onTap: () {}),
            ),
            SizedBox(height: 20),

            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.black),
                minimumSize: WidgetStatePropertyAll(Size(double.infinity, 60)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
