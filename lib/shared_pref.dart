import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  final nameController = TextEditingController();
  final phnController = TextEditingController();
  String _savedName = '';
  String _savedPhn = '';

  Future<void> loadDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('name') ?? '';
      _savedPhn = prefs.getString('phone') ?? '';
      nameController.text = _savedName;
      phnController.text = _savedPhn;
    });
  }

  Future<void> saveDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phnController.text);
    setState(() {
      _savedName = nameController.text;
      _savedPhn = phnController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User Info Saved!')),
    );
  }

  void initState() {
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Phone Number',
              ),
              controller: phnController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                onPressed: saveDetails,
                child: Text('Save')),
            SizedBox(height: 20),
            Text('Saved Name: $_savedName'),
            SizedBox(height: 20),
            Text('Saved Phone: $_savedPhn'),
          ],
        ),
      ),
    );
  }
}
