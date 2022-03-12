import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:spp_pkl/Page/cara_bayar_page.dart';
import 'package:spp_pkl/Page/invoice_pembayaran_page.dart';
import 'package:spp_pkl/Page/profile_page.dart';

class NavigationBarTool extends StatefulWidget {
  @override
  _NavigationBarToolState createState() => _NavigationBarToolState();
}

class _NavigationBarToolState extends State<NavigationBarTool> {
  int index = 1;

  final screens = [
    ProfilePage(),
    InvoicePembayaranPage(),
    CaraBayarPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.person, size: 30),
      Icon(Icons.list_alt, size: 30),
      Icon(Icons.atm, size: 30),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        backgroundColor: Colors.transparent,
        items: items,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
