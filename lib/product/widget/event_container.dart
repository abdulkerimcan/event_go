import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/product/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class EventContainer extends StatelessWidget {
  final EventModel? event;

  const EventContainer({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sized.width / 1.7,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _backgroundImage(context),
          _eventName(context),
          Padding(
            padding: context.padding.onlyLeftLow,
            child: Row(
              children: [
                _categoryContainer(context),
                _participantsRow(context),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.location_on,
              color: ColorConstants.primaryColor,
            ),
            title: Text(
              event?.location ?? "null",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.bookmark_border,
              color: ColorConstants.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Padding _eventName(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Text(
        event?.name ?? "Concert",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _backgroundImage(BuildContext context) {
    return Container(
        height: (context.sized.height * 0.25) / 2,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    AssetImage(event?.image ?? "assets/images/concert.jpg"))));
  }

  Container _categoryContainer(BuildContext context) {
    return Container(
        height: context.sized.normalValue,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: ColorConstants.primaryColor)),
        child: Center(
            child: Text(
          event?.category ?? "Music",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold, color: ColorConstants.primaryColor),
        )));
  }

  Padding _participantsRow(BuildContext context) {
    return Padding(
      padding: context.padding.onlyLeftLow,
      child: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const Align(
              widthFactor: 0.5,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage("assets/images/concert.jpg"),
                ),
              ),
            ),
          context.sized.emptySizedWidthBoxLow,
          Text("${event?.participants?.length ?? 2}K going")
        ],
      ),
    );
  }
}
