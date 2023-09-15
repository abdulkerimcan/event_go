import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/features/auth/login/view/login_view.dart';
import 'package:eventgo/features/settings/cubit/settings_cubit.dart';
import 'package:eventgo/features/settings/cubit/settings_state.dart';
import 'package:eventgo/product/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with CustomSheetMixin {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: ListView(
          children: [
            _editProfileCard(context),
            _notificationCard(context),
            _securityCard(context),
            _appearenceCard(context),
            _helpCard(context),
            _inviteCard(context),
            _logoutCard(context),
          ],
        ));
  }

  Card _logoutCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
          onTap: () async {
            await showCustomSheet(context);
          },
          contentPadding: context.padding.low,
          leading: IconContainer(
              iconData: Icons.logout, onPress: () {}, color: Colors.red),
          title: const Text("Logout")),
    );
  }

  Card _inviteCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.people,
            color: ColorConstants.primaryColor,
            onPress: () {}),
        title: const Text("Invite Friends"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  Card _helpCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.info_rounded,
            onPress: () {},
            color: ColorConstants.primaryColor),
        title: const Text("Help"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  Card _appearenceCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.remove_red_eye,
            onPress: () {},
            color: ColorConstants.primaryColor),
        title: const Text("Appearance"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  Card _securityCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.lock,
            onPress: () {},
            color: ColorConstants.primaryColor),
        title: const Text("Security"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  Card _notificationCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.notifications,
            onPress: () {},
            color: ColorConstants.primaryColor),
        title: const Text("Notification"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  Card _editProfileCard(BuildContext context) {
    return Card(
      margin: context.padding.low,
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: context.padding.low,
        leading: IconContainer(
            iconData: Icons.person,
            onPress: () {},
            color: ColorConstants.primaryColor),
        title: const Text("Edit Profile"),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: ColorConstants.primaryColor,
        icon: const Icon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: _buildTitle(context),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      "Settings",
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}

mixin CustomSheetMixin {
  Future<T?> showCustomSheet<T>(BuildContext context) async {
    return await showModalBottomSheet<T>(
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => SettingsCubit(const SettingsInitialState()),
          child: const _CustomSheet(),
        );
      },
    );
  }
}

class _CustomSheet extends StatelessWidget {
  const _CustomSheet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.height * 0.2,
      child: Column(
        children: [
          const _BaseHeader(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is SettingsCompleteState) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ));
                    } else if (state is SettingsFailedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("state.message")));
                    }
                  },
                  builder: (context, state) {
                    print(state);
                    if (state is SettingsLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return const Icon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      color: ColorConstants.primaryColor,
                    );
                  },
                ),
                Text(
                  "Are you sure want to logout",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: ColorConstants.primaryColor),
                          backgroundColor: Colors.white,
                          minimumSize: Size(context.sized.width * 0.3,
                              context.sized.mediumValue)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: ColorConstants.primaryColor),
                          backgroundColor: Colors.white,
                          minimumSize: Size(context.sized.width * 0.3,
                              context.sized.mediumValue)),
                      onPressed: () {
                        context.read<SettingsCubit>().logout();
                      },
                      child: Text(
                        "Yes, Logout",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BaseHeader extends StatelessWidget {
  const _BaseHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Divider(
        color: Colors.black26,
        thickness: 3,
        indent: MediaQuery.of(context).size.width * 0.45,
        endIndent: MediaQuery.of(context).size.width * 0.45,
      ),
    );
  }
}
