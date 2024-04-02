import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  final Function(int) onItemSelected;
  const MyDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Abishek Chakraborty"),
            accountEmail: const Text("Ac.abishek@gmail.com"),
            arrowColor: Colors.white,
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://as2.ftcdn.net/v2/jpg/03/64/21/11/1000_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage(
                      "https://img.freepik.com/free-photo/dark-room-with-light-background_1409-1809.jpg?w=1060&t=st=1711174591~exp=1711175191~hmac=13873494ac28c1846a9318918c26b37931ff93ab58f847ccf96f1ccd405dd1c5",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourite"),
            onTap: () {
              onItemSelected(3);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Friends"),
            onTap: () {
              onItemSelected(4);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () {
              return;
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Request"),
            onTap: () {
              return;
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              return;
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text("Plolcies"),
            onTap: () {
              return;
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Exit"),
            onTap: () {
              onItemSelected(9);
            },
          )
        ],
      ),
    );
  }
}
