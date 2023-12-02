import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO 1 Variable
  bool isSigned = false;
  String fullName = "";
  String username = "";
  int favouritCandiCount = 0;

  // TODO 5. Implementasi Fungsi Sign In
  void signIn() {
    setState(() {
      Navigator.pushNamed(context, '/signin');
      // isSigned = !isSigned;
    });
  }

  // TODO 6. Implementasi Fungsi Sign Out
  void signOut() {
    setState(() {
      isSigned = !isSigned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wisata Candi')),
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // TODO: 2. Profile Header
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple, width: 2),
                              shape: BoxShape.circle),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/placeholder_image.png'),
                          ),
                        ),
                        if (isSigned)
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                              ))
                      ],
                    ),
                  ),
                ),
                // TODO: 3. Profile Info
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  height: 4,
                ),
                // Pengguna
                ProfileInfoItem(
                    icon: Icons.lock,
                    label: 'Pengguna',
                    value: username,
                    iconColor: Colors.amber),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  height: 4,
                ),
                // Nama
                ProfileInfoItem(
                    icon: Icons.person,
                    label: 'Nama',
                    value: fullName,
                    showEditIcon: isSigned,
                    onEditPressed: () {
                      // Tindakan saat ikon edit ditekan
                      debugPrint("Icon edit ditekan ...");
                    },
                    iconColor: Colors.blue),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  height: 4,
                ),
                // Favorit
                ProfileInfoItem(
                    icon: Icons.favorite,
                    label: 'Favorit',
                    value: favouritCandiCount > 0 ? "$favouritCandiCount" : '',
                    iconColor: Colors.red),

                // TODO: 4. Profile Header
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  height: 20,
                ),
                isSigned
                    ? TextButton(
                        onPressed: signOut, child: const Text("Sign Out"))
                    : TextButton(
                        onPressed: signIn, child: const Text("Sign In"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
