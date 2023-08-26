import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/product/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: ListView(
          children: [
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(iconData: Icons.person, onPress: () {},color: ColorConstants.primaryColor ),
                title: const Text("Edit Profile"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(
                    iconData: Icons.notifications, onPress: () {},color: ColorConstants.primaryColor ),
                title: const Text("Notification"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(iconData: Icons.lock, onPress: () {},color: ColorConstants.primaryColor ),
                title: const Text("Security"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(
                    iconData: Icons.remove_red_eye, onPress: () {},color: ColorConstants.primaryColor ),
                title: const Text("Appearance"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading:
                    IconContainer(iconData: Icons.info_rounded, onPress: () {},color: ColorConstants.primaryColor ),
                title: const Text("Help"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(iconData: Icons.people,color: ColorConstants.primaryColor ,onPress: () {}),
                title: const Text("Invite Friends"),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Card(
              margin: context.padding.low,
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                contentPadding: context.padding.low,
                leading: IconContainer(iconData: Icons.logout, onPress: () {},color: Colors.red ),
                title: const Text("Logout")
              ),
            )
          ],
        ));
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
