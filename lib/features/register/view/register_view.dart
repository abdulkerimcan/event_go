import 'package:eventgo/features/register/cubit/login_cubit.dart';
import 'package:eventgo/features/register/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../product/widget/custom_clip_path.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(const LoginInitialState(),
          emailController, passwordController, _formKey),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: _titleContainer(context),
            ),
            Padding(
              padding: context.padding.normal,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _registerText(context),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _nameTextForm(),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _surnameTextForm(),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _emailTextForm(),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _passwordTextForm(),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomNormal,
                      child: _confirmPasswordTextForm(),
                    ),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const CircularProgressIndicator();
                          }
                          return _registerButton(context);
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: const Text("or continue with"),
                    ),
                    _loginContainersRow(),
                  ],
                ),
              ),
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

  TextFormField _confirmPasswordTextForm() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Cannot be empty";
        } else if (value != passwordController.text) {
          return "passwords does not match";
        }
        return null;
      },
      controller: confirmPasswordController,
      obscureText: true,
      decoration:
          _inputDecoration("Confirm your password*", "Confirm your password"),
    );
  }

  TextFormField _passwordTextForm() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Cannot be empty";
        } else if (value != confirmPasswordController.text) {
          return "passwords does not match";
        }
        return null;
      },
      controller: passwordController,
      obscureText: true,
      decoration: _inputDecoration("Password*", "Enter your password"),
    );
  }

  TextFormField _emailTextForm() {
    return TextFormField(
        validator: (value) {
          if (value != null && !value.ext.isValidEmail) {
            return "Invalid E-mail";
          }
          return null;
        },
        controller: emailController,
        decoration: _inputDecoration("E-mail*", "Enter your email"));
  }

  TextFormField _surnameTextForm() {
    return TextFormField(
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Cannot be empty";
          }
          return null;
        },
        controller: surNameController,
        decoration: _inputDecoration("Surname*", "Enter your surname"));
  }

  TextFormField _nameTextForm() {
    return TextFormField(
        controller: nameController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Cannot be empty";
          }
          return null;
        },
        decoration: _inputDecoration("Name*", "Enter your name"));
  }

  Container _titleContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xff5265FF),
      height: context.sized.height * 0.2,
      child: Center(child: _header()),
    );
  }

  Text _registerText(BuildContext context) {
    return Text("Register for free",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black));
  }

  Text _header() {
    return Text(
      "EventGO",
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(color: Colors.white),
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
        onPressed: () {
          context.read<LoginCubit>().login();
        },
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
