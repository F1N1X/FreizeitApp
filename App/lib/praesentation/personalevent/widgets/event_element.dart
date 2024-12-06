import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/core/pictures_path.dart';

import '../../../routes/router.gr.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final GetPathToPicture helper = GetPathToPicture();

    return InkResponse(
      onTap: () {
        AutoRouter.of(context).push(EventDetailRoute(event: event));
      },
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 239, 243),
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          ),
          height: 130,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 44, 43, 43),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontFamily: 'RobotoMono'),
                    ),
                    Text(event.eventDescription,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 43, 43),
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono')),
                    Text(event.eventType,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 43, 43),
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono')),
                    Text("${event.memberCount}/${event.maxMember}",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 43, 43),
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono')),
                    Text(
                        helper.transformDateToString(
                            event.startDate as Timestamp),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 43, 43),
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono')),
                  ],
                ),
                const Expanded(child: SizedBox()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    helper.getPathToPicture(event.eventType),
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
