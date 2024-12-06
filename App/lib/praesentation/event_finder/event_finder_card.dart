import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/Model/event.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/core/pictures_path.dart';

class EventFinderCard extends StatelessWidget {
  final Event event;
  const EventFinderCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final GetPathToPicture helper = GetPathToPicture();

    return InkResponse(
      onTap: () {},
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
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkResponse(
                  onTap: () {
                    BlocProvider.of<EventFinderBloc>(context)
                        .add(AddTipedEventToUser(id: event.id));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'lib/images/join.png',
                      height: 40,
                      width: 40,
                    ),
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
