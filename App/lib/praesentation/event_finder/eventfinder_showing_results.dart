import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/praesentation/event_finder/event_finder_card.dart';
import 'package:freizeit_app/praesentation/personalevent/widgets/event_empty.dart';

import '../../routes/router.gr.dart';

class EventFinderSearchingBody extends StatelessWidget {
  const EventFinderSearchingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFinderBloc, EventFinderState>(
        builder: (context, state) {
      if (state is EventFinderFiltered && state.eventList.isEmpty) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: EmptyEvents(),
        );
      } else if (state is EventFinderFiltered && state.eventList.isNotEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
              itemCount: state.eventList.length,
              itemBuilder: (((context, index) {
                final currentEvent = state.eventList[index];
                return EventFinderCard(event: currentEvent);
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
                      icon: const Icon(Icons.check),
                      color: Colors.white,
                    )
                  ],
                ),
              )),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
