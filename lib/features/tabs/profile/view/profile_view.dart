import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/features/settings/view/settings_view.dart';
import 'package:eventgo/product/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: context.padding.normal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _profileImage(context),
          _userName(context),
          _userFollowers(context),
          const Divider(),
          _headerText("About"),
          _descriptionText(context),
          _headerText("Interest"),
          _interestListView()
        ]),
      ),
    );
  }

  Expanded _interestListView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 120,
            maxCrossAxisExtent: 4),
        itemBuilder: (context, index) {
          return const ActionChip(label: Text("data"));
        },
      ),
    );
  }

  Padding _descriptionText(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
    );
  }

  Padding _headerText(String text) {
    return Padding(
      padding: context.padding.onlyTopNormal,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _userFollowers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("1.203",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.black)),
              Text("Followers", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(width: 0.5), right: BorderSide(width: 0.5))),
          child: Column(
            children: [
              Text("203",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.black)),
              Text(
                "Following",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("9",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.black)),
              Text("Event", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }

  Center _userName(BuildContext context) {
    return Center(
      child: Text(
        "McLovin",
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Center _profileImage(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: context.sized.height * 0.07,
            backgroundImage: const AssetImage("assets/images/mc.jpeg"),
          ),
          _editIcon()
        ],
      ),
    );
  }

  Positioned _editIcon() {
    return Positioned(
      right: -5,
      bottom: -5,
      child: IconButton(
          onPressed: () {},
          icon: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstants.primaryColor),
            child: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            ),
          )),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: _buildAppBarLeading(context),
      actions: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: IconContainer(
            color: ColorConstants.primaryColor ,
              iconData: Icons.settings,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => const SettingsView()));
              }),
        )
      ],
      title: _buildTitle(context),
    );
  }

  Padding _buildAppBarLeading(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalNormal,
      child: const Icon(
        FontAwesomeIcons.ticket,
        color: ColorConstants.primaryColor,
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      "Profile",
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
