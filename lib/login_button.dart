import 'package:flutter/material.dart';

class LoginButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Button'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/tela1');
          },
          child: Text('Entrar'),
        ),
      ),
    );
  }
}
