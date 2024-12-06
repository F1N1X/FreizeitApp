import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/message_handling/bloc/message_bloc.dart';
import 'package:freizeit_app/praesentation/event_message/eventmessage_card.dart';
import 'package:freizeit_app/routes/router.gr.dart';

class EventChat extends StatelessWidget {
  const EventChat({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is EventForMessageLodingSucceded) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Gruppennachrichten"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  AutoRouter.of(context)
                      .replace(EventDetailRoute(event: state.event));
                },
              ),
              backgroundColor: Colors.blue,
              elevation: 4,
            ),
            body: ListView.builder(
                itemCount: state.event.eventMessages?.length,
                itemBuilder: (((context, index) {
                  if (state.event.eventMessages!.isEmpty) {
                    //Leere Nachrichten Seite noch machen
                    return const CircularProgressIndicator();
                  } else {
                    final message = state.event.eventMessages![index];
                    return GroupCard(message: message);
                  }
                }))),
            bottomNavigationBar: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  child: BottomAppBar(
                      color: Colors.blue,
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                obscureText: false,
                                controller: textController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    iconColor: Colors.grey,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    filled: true,
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    labelText: "Schreibe eine Nachricht"),
                                cursorColor: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<MessageBloc>(context).add(
                                    UpdateEventWithMessage(
                                        message: textController.text,
                                        id: state.event.id.value));
                                textController.text = "Schreibe eine Nachricht";
                              },
                              icon: const Icon(Icons.send),
                              color: Colors.white,
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
