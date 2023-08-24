import 'package:eventgo/features/home/home.dart';
import 'package:eventgo/features/login/view/login_view.dart';
import 'package:eventgo/features/register/cubit/register_cubit.dart';
import 'package:eventgo/features/register/cubit/register_state.dart';
import 'package:eventgo/product/widget/custom_clip.dart';
import 'package:eventgo/product/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

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
        create: (context) =>
            RegisterCubit(const RegisterInitialState(), _formKey),
        child: _buildScaffold(context));
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
                      child: BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterCompleteState) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => const HomeView()));
                          } else if (state is RegisterFailState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text(state.message ?? "Error occured")));
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoadingState) {
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

  Text _registerText(BuildContext context) {
    return Text("Register for free",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black));
  }

  TextButton _signInButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (contex) => const LoginView()));
      },
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

  ElevatedButton _registerButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<RegisterCubit>().register(
              nameController.text,
              surNameController.text,
              emailController.text,
              passwordController.text);
        },
        child: Text(
          "Register",
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
