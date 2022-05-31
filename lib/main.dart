import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  // print(email);
  runApp(MaterialApp(home: email == null ? const Login() : const Home()));
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //after the login REST api call && response code ==200
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', 'useremail@gmail.com');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => const Home()));
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => const Login()));
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
