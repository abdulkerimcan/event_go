import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/features/tabs/home/cubit/home_cubit.dart';
import 'package:eventgo/product/model/event_model.dart';
import 'package:eventgo/product/widget/event_container.dart';
import 'package:eventgo/product/widget/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: context.padding.normal,
                child: Column(
                  children: [
                    _searchRow(),
                    _seeAllRow("Featured"),
                    _featuredContainer(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: context.sized.normalValue,
                    right: context.sized.normalValue,
                    top: context.sized.lowValue),
                child: _seeAllRow("Trends"),
              ),
              _categoryListView(),
              _trendsEvent(context),
              Padding(
                  padding: EdgeInsets.only(
                      left: context.sized.normalValue,
                      right: context.sized.normalValue,
                      top: context.sized.lowValue),
                  child: _seeAllRow("Nearby Your Location")),
              _trendsEvent(context),
              Padding(
                  padding: EdgeInsets.only(
                      left: context.sized.normalValue,
                      right: context.sized.normalValue,
                      top: context.sized.lowValue),
                  child: _seeAllRow("New Events")),
              _trendsEvent(context)
            ],
          ),
        ),
      ),
    );
  }

  Row _seeAllRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _titleText(title),
        _seeAllTextBtn(),
      ],
    );
  }

  Padding _trendsEvent(BuildContext context) {
    return Padding(
      padding: context.padding.verticalNormal,
      child: SizedBox(
        height: context.sized.height * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.padding.onlyLeftNormal,
              child: EventContainer(
                event: EventModel(
                    name: "DJ Pablito",
                    location: "Antalya/Türkiye",
                    image: "assets/images/concert.jpg",
                    category: "music"),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _categoryListView() {
    return SizedBox(
      height: context.sized.height * 0.06,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.padding.onlyLeftNormal,
            child: _categoryActionChip(context, index),
          );
        },
      ),
    );
  }

  ActionChip _categoryActionChip(BuildContext context, int index) {
    return ActionChip(
        side: const BorderSide(color: ColorConstants.primaryColor),
        onPressed: () {
          context.read<HomeCubit>().selectedItem(index);
        },
        backgroundColor: context.watch<HomeCubit>().state == index
            ? ColorConstants.primaryColor
            : Colors.white,
        label: Text(
          "Concert",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: context.watch<HomeCubit>().state == index
                  ? Colors.white
                  : ColorConstants.primaryColor),
        ));
  }

  Container _featuredContainer() {
    return Container(
      padding: context.padding.medium,
      width: double.infinity,
      height: context.sized.highValue * 2,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/concert.jpg"))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _featuredTitleText(),
          _bookNowBtn(),
        ],
      ),
    );
  }

  Text _featuredTitleText() {
    return Text(
      "International Concert",
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  ElevatedButton _bookNowBtn() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize:
                Size(context.sized.highValue, context.sized.mediumValue)),
        onPressed: () {},
        child: Text(
          "Book Now",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }

  Text _titleText(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  TextButton _seeAllTextBtn() {
    return TextButton(
      onPressed: () {},
      child: Text(
        "See All",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold, color: ColorConstants.primaryColor),
      ),
    );
  }

  Row _searchRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "search",
                fillColor: Colors.grey[200],
                filled: true,
                suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass)),
          ),
        ),
        Padding(
          padding: context.padding.onlyLeftLow,
          child: IconContainer(
              iconData: Icons.filter_list,
              onPress: () {},
              color: ColorConstants.primaryColor),
        )
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: context.padding.horizontalNormal,
        child: const Icon(
          FontAwesomeIcons.ticket,
          color: ColorConstants.primaryColor,
        ),
      ),
      actions: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: IconContainer(
              iconData: FontAwesomeIcons.solidBell,
              onPress: () {},
              color: ColorConstants.primaryColor),
        ),
        Padding(
          padding: context.padding.onlyRightNormal,
          child: IconContainer(
              iconData: FontAwesomeIcons.solidBookmark,
              onPress: () {},
              color: ColorConstants.primaryColor),
        )
      ],
      title: _buildTitle(context),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      "EventGo",
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
