import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MySnack(),
  ));
}

class MySnack extends StatefulWidget {
  const MySnack({super.key});

  @override
  State<MySnack> createState() => _MySnackState();
}

class _MySnackState extends State<MySnack> {
  void showPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Contact",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("📞 9778368160"),
              SizedBox(height: 6),
              Text("📧 asnuafnan@gmail.com"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Portfolio")),
      body: Center(
        child: ElevatedButton(
          onPressed: showPopup,
          child: const Text("Contact"),
        ),
      ),
    );
  }
}
