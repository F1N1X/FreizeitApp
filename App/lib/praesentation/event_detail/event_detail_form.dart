import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_detail/bloc/event_detail_bloc.dart';
import 'package:freizeit_app/praesentation/event_detail/event_detail_textfield.dart';
import 'package:freizeit_app/praesentation/event_detail/event_message.dart';

class EventDetailForm extends StatelessWidget {
  const EventDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return BlocConsumer<EventDetailBloc, EventDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                color: Colors.white,
                height: 100,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'lib/images/eventliste_center.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.event.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 43, 43),
                            letterSpacing: 2,
                            fontFamily: 'RobotoMono')),
                  ],
                ),
              ),
            ),
            EventDetailTextField(
              width: width,
              firstText: 'Kategorie',
              eventText: state.event.eventType,
            ),
            EventDetailTextField(
              width: width,
              firstText: 'Beschreibung',
              eventText: state.event.eventDescription,
            ),
            EventDetailTextField(
              width: width,
              firstText: 'Startdatum',
              eventText: '11.11.22',
            ),
            EventDetailTextField(
              width: width,
              firstText: 'Nutzer',
              eventText: "${state.event.memberCount}/${state.event.maxMember}",
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(12),
                  itemCount: state.event.eventMessages?.length,
                  itemBuilder: (context, index) {
                    return MessageCard(
                        message: state.event.eventMessages![index]);
                  },
                ),
              ],
            )
          ]),
        );
      },
    );
  }
}
