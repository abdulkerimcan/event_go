import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.padding.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _header(),
            Column(
              children: [
                Text("Register for free",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black)),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: _inputDecoration("Name", "Enter your name")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration:
                        _inputDecoration("Surname", "Enter your surname")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: _inputDecoration("E-mail", "Enter your email")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:
                      _inputDecoration("Password", "Enter your password"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: _inputDecoration(
                      "Confirm your password", "Confirm your password"),
                ),
                const SizedBox(
                  height: 10,
                ),
                _registerButton(context),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const Text("or continue with"),
                const SizedBox(
                  height: 10,
                ),
                _loginContainersRow(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _signInButton(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  Text _header() {
    return Text(
      "EventGO",
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: const Color(0xff5265FF)),
    );
  }

  TextButton _signInButton(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Sign in",
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: const Color(0xff5265FF)),
      ),
    );
  }

  Row _loginContainersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _customContainer("assets/icons/ic_facebook.png", "Facebook"),
        _customContainer("assets/icons/ic_google.png", "Google")
      ],
    );
  }

  ElevatedButton _registerButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          "Register",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.white),
        ));
  }

  Container _customContainer(String iconPath, String label) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(offset: Offset(-0.3, 0.2)),
        BoxShadow(offset: Offset(0.1, 0.4))
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: context.sized.width * 0.4,
      height: context.sized.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            iconPath,
            height: context.sized.mediumValue,
            width: context.sized.mediumValue,
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
    );
  }
}
