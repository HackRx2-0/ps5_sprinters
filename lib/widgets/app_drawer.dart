import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.blue[800],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: Text(
                    'Hey!  Vishu',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  subtitle: Text('Kanpur, Uttar Pradesh',
                      style: TextStyle(color: Colors.white)),
                  //trailing: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop Online'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Bills and Recharge History'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Calculators'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.query_stats),
            title: Text('Raised Requests'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Raise a query'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.touch_app),
            title: Text('Get in Touch'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {},
          )
        ],
      ),
    );
  }
}
