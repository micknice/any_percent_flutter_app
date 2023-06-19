import 'package:flutter/material.dart';

class EditStackView extends StatefulWidget {
  const EditStackView({super.key});

  @override
  State<EditStackView> createState() => _EditStackViewState();
}

class _EditStackViewState extends State<EditStackView> {
  late List _sets;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Column(
        children: [
          ListView.builder(
              itemCount: _sets.length, itemBuilder: (contxt, index) {})
        ],
      ),
    );
  }
}
