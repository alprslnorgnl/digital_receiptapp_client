import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/check_auth.dart';
import '../components/appbar.dart';
import 'package:http/http.dart' as http;

import '../components/check_favorite_piece.dart';
import '../components/navigate_bar.dart';
import '../components/settings_menu.dart';
import '../components/settings_sub_menu.dart';
import 'change_password.dart';
import 'change_phone_settings.dart';
import 'edit_profile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.delete(
      Uri.parse('http://35.202.100.38:8080/api/BaseUser/deleteAccount'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('jwt_token');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const CheckAuth()),
        (Route<dynamic> route) => false,
      );
    } else {
      // Handle error
      print('Failed to delete account: ${response.body}');
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hesabını sil"),
          content: const Text("Hesabınızı silmek istediğinize emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Kapat"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAccount();
              },
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const Appbar(appbarText: "AYARLAR"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Menu(icon: Icons.person_outline, heading: "Hesap"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                    },
                    child: const SubMenu(
                      text: "Profili düzenle",
                      bildirim: false,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePassword()));
                    },
                    child: const SubMenu(
                      text: "Şifre değiştir",
                      bildirim: false,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePhoneSettings()));
                    },
                    child: const SubMenu(
                      text: "Numara değiştir",
                      bildirim: false,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CheckFavoritePiece()));
                    },
                    child: const SubMenu(
                      text: "Favoriler",
                      bildirim: false,
                    ),
                  ),
                  const SubMenu(
                    text: "Verileri indir",
                    bildirim: false,
                  ),
                  InkWell(
                    onTap: _showDeleteAccountDialog,
                    child: const SubMenu(
                      text: "Hesabını sil",
                      bildirim: false,
                    ),
                  ),
                  const Menu(
                      icon: Icons.notifications_outlined, heading: "Bildirim"),
                  const SubMenu(
                    text: "Bildirim",
                    bildirim: true,
                  ),
                  const Menu(icon: Icons.more_outlined, heading: "Daha fazla"),
                  const SubMenu(
                    text: "Dil",
                    bildirim: false,
                  ),
                  const SubMenu(
                    text: "Ülke",
                    bildirim: false,
                  ),
                  const SubMenu(
                    text: "Privacy & Secure",
                    bildirim: false,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('jwt_token');
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CheckAuth()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Çıkış Yap",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: const NavigateBar(page: 4),
    );
  }
}
