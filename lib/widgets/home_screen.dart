import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/data/candi_data.dart';
import 'package:prj_wisatacandisi51/models/candi.dart';
import 'package:prj_wisatacandisi51/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 1. Buat appbar dengan judul wisata candi
      appBar: AppBar(
        title: const Text("Wisata Candi"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: candiList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          Candi candi = candiList[index];
          return ItemCard(
            candi: candi,
          );
        },
      ),
      // TODO 2. Buat body dengan gridview.builder
      // TODO 3. Buat Itemcard sebagai return value dari gridview.builder
    );
  }
}
