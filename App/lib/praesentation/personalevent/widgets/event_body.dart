import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/praesentation/personalevent/widgets/event_element.dart';
import 'package:freizeit_app/praesentation/personalevent/widgets/event_empty.dart';

import '../../../application/event_bloc/bloc/event_bloc.dart';
import '../../../routes/router.gr.dart';

class EventBody extends StatelessWidget {
  const EventBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      if (state is EventLoadingSucced && state.events.isEmpty) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: EmptyEvents(),
        );
      } else if (state is EventLoadingSucced && state.events.isNotEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (((context, index) {
                if (state.events.isEmpty) {
                  return const EmptyEvents();
                } else {
                  final currentEvent = state.events[index];
                  return EventCard(event: currentEvent);
                }
              }))),
          bottomNavigationBar: BottomAppBar(
              color: Colors.blue,
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .replace(const WelcomeScreenRoute());
                      },
                      icon: const Icon(Icons.arrow_back_sharp),
                      color: Colors.white,
                    )
                  ],
                ),
              )),
        );
      } else {
        //Else Fall noch
      }
      return const CircularProgressIndicator();
    });
  }
}
