import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/constants.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/AboutUs/about_us.dart';
import 'package:social_chat_bot_assistant/screens/DomainPage/domain_screen.dart';
import 'package:social_chat_bot_assistant/screens/Help/help.dart';
import 'package:social_chat_bot_assistant/screens/Login/login_screen.dart';
import 'package:social_chat_bot_assistant/screens/Profile/profile.dart';
import 'package:social_chat_bot_assistant/services/auth_service.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final AuthService _authService = AuthService();
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final userDetails = _authService.currentUser();
    print(userDetails);
    final name = 'name';
    final email = 'email';
    final urlImage =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxHWFss7T4f3QifjwCTUJ-VGqffPBBDI1VlQ&usqp=CAU';

    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Help',
                    icon: Icons.help,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'About Us',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 40),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Log Out',
                    icon: Icons.logout,
                    onClicked: () async {
                      await _authService.signOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    final String urlImage,
    final String name,
    final String email,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    final String text,
    final IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color, fontSize: 20)),
      hoverColor: kPrimaryLightColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DomainScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Profile(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HelpScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUsScreen(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
        break;
    }
  }
}
