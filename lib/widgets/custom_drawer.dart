import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatefulWidget {
  final User user;
  const CustomDrawer({super.key, required this.user});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            // currentAccountPicture: CircleAvatar(backgroundImage: AssetImage(),),
            accountName: Text(
              (widget.user.displayName != null) ? widget.user.displayName! : "",
            ),
            accountEmail: Text(widget.user.email!),
          ),
          ListTile(
            title: Text('Suporte'),
            leading: Icon(Icons.contact_support_rounded),
            onTap: () {
              Navigator.pushNamed(context, Routes.support);
            },
          ),
          ListTile(
            title: Text('Registro de produtos'),
            leading: Icon(Icons.fiber_new_rounded),
            onTap: () {
              Navigator.pushNamed(context, Routes.productRegister);
            },
          ),
          ListTile(
            title: Text('Pagamento'),
            leading: Icon(Icons.payments_rounded),
            onTap: () {
              Navigator.pushNamed(context, Routes.pagamento);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: const Text("Sair"),
            onTap: () {
              AuthService().userLogout();
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
