import 'package:flutter/material.dart';
import '../../ui/auctioneer/auctioneer_profile.dart';
import '../styles/custom_google_fonts.dart';
import 'custom_listtile_widget.dart';

class CustomMenuDrawer extends StatelessWidget {
  const CustomMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  margin: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blueGrey
                            .withOpacity(0.7), // Specify the border color here
                        width: 3.0, // Specify the border width here
                      ),
                    ),
                  ),
                  child: Text('MENU',
                      style: customGoolgeFonts(
                          const Color.fromARGB(
                            255,
                            1,
                            102,
                            161,
                          ),
                          FontWeight.bold,
                          25)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 38,
                  color: Colors.blue,
                ),
                title: Text('Profile',
                    style: customGoolgeFonts(
                        const Color.fromARGB(
                          255,
                          1,
                          102,
                          161,
                        ),
                        FontWeight.bold,
                        25)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuctioneerProfile(),
                      ));
                },
              ),
              CustomListTileWidget(
                iconPath: "assets/icons/icon_dollar.png",
                text: "Opportunities",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              CustomListTileWidget(
                iconPath: "assets/icons/icon_payment.png",
                text: "Payment Methods",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 38,
                  color: Colors.blue,
                ),
                title: Text('Settings',
                    style: customGoolgeFonts(
                        const Color.fromARGB(
                          255,
                          1,
                          102,
                          161,
                        ),
                        FontWeight.bold,
                        25)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              CustomListTileWidget(
                iconPath: "assets/icons/icon_privacy.png",
                color: const Color.fromARGB(255, 4, 136, 9),
                text: "Privacy Policy",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              CustomListTileWidget(
                iconPath: "assets/icons/icon_terms.png",
                text: "Terms & Conditons",
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Center(
                child: Text(
                  'Version: 1.0.0',
                  style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        1,
                        102,
                        161,
                      ),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
