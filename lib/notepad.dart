import 'package:basic_auth/auth.service.dart';
import 'package:flutter/material.dart';
import 'file.service.dart';
import 'package:toast/toast.dart';

class NotepadScreen extends StatefulWidget {
  NotepadScreen({Key key}) : super(key: key);

  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  final notepadController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.load().then((result) {
      setState(() {
        notepadController.text = result;
      });
    });
  }

  Future<String> load() {
    return FileService.instance.readData();
  }

  void save() {
    setState(() {
      FileService.instance.writeData(notepadController.text).then((_) {
        Toast.show('Note saved', context);
      });
    });
  }

  void savePassword() {
    AuthService.instance.savePassword(passwordController.text).then((_) {
      Toast.show('Password changed', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test notepad'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: 100,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Write your notes here'
                  ),
                  controller: notepadController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              )
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your new password'
              ),
              controller: passwordController,
              obscureText: true,
            ),
            MaterialButton(
              child: Text('Save password'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: savePassword,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        tooltip: 'Increment',
        child: Icon(Icons.save),
      ),
    );
  }
}
