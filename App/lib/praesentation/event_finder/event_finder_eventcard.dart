import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_bloc/bloc/event_bloc.dart';
import 'package:freizeit_app/dependency_injection.dart';

import '../../Model/event.dart';

class EventFindCard extends StatelessWidget {
  final Event event;
  const EventFindCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<EventBloc>(),
      child: InkResponse(
        onTap: () {
          BlocProvider.of<EventBloc>(context).add(AddEventToUser(id: event.id));
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
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'lib/images/eventliste_center.png',
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
      ),
    );
  }
}
