import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/features/home/view/home_view.dart';
import 'package:eventgo/features/login/cubit/login_cubit.dart';
import 'package:eventgo/features/login/cubit/login_state.dart';
import 'package:eventgo/features/register/view/register_view.dart';
import 'package:eventgo/product/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../product/widget/custom_clip.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(const LoginInitialState(),
          _emailController, _passwordController, _formKey),
      child: _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomClipPath(
              title: 'EventGO',
              context: context,
            ),
            Padding(
              padding: context.padding.normal,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: context.padding.onlyBottomLow,
                      child: _loginText(context),
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
                        padding: context.padding.onlyBottomLow,
                        child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginCompleteState) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => const HomeView()));
                            } else if (state is LoginFailState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.message ?? "error occured"),
                              ));
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return const CircularProgressIndicator();
                            }
                            return _loginButton(context);
                          },
                        )),
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
                  "Do not you have an account?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _registerButton(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField _passwordTextForm() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Cannot be empty";
        } else if (value != null && value.length < 6) {
          return "Cannot be less than 6 characters";
        }
        return null;
      },
      controller: _passwordController,
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
        controller: _emailController,
        decoration: _inputDecoration("E-mail*", "Enter your email"));
  }

  Text _loginText(BuildContext context) {
    return Text("Log in Now",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black));
  }

  TextButton _registerButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (contex) => const RegisterView()));
      },
      child: Text(
        "Register",
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: ColorConstants.primaryColor),
      ),
    );
  }

  Row _loginContainersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomContainer(
          context: context,
          imagePath: "assets/icons/ic_facebook.png",
          title: "Facebook",
        ),
        CustomContainer(
          context: context,
          imagePath: "assets/icons/ic_google.png",
          title: "Google",
        ),
      ],
    );
  }

  ElevatedButton _loginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context
            .read<LoginCubit>()
            .login(_emailController.text, _passwordController.text),
        child: Text(
          "Login",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.white),
        ));
  }

  InputDecoration _inputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
    );
  }
}
