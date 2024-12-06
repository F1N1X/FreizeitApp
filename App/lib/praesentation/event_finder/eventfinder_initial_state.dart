import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_finder_bloc/bloc/event_finder_bloc.dart';
import 'package:freizeit_app/core/pictures_path.dart';
import 'package:freizeit_app/praesentation/event_detail/event_detail_button.dart';

import '../../routes/router.gr.dart';

class EventFinderInitialWidget extends StatefulWidget {
  const EventFinderInitialWidget({super.key});

  @override
  State<EventFinderInitialWidget> createState() =>
      _EventFinderInitialWidgetState();
}

class _EventFinderInitialWidgetState extends State<EventFinderInitialWidget> {
  String? value;
  DateTime? date;
  DateTime? startDate;
  GetPathToPicture helper = GetPathToPicture();
  String dateString = 'Datum';
  TextEditingController textEditingControllerEventDate =
      TextEditingController();
  double radius = 3;

  @override
  void dispose() {
    super.dispose();
    textEditingControllerEventDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final items = [
      'all',
      'beer',
      'bike',
      'board-game',
      'camera',
      'chess',
      'console',
      'disco',
      'explore',
      'dog',
      'fishing',
      'fitness',
      'holidays',
      'horse',
      'jogging',
      'climbing',
      'material-arts',
      'meeting',
      'motorcross',
      'cinema',
      'bowling',
      'swimming',
      'soccer',
      'studying',
      'tabletennis',
      'teaching',
      'tennis',
      'volleyball',
      'walk',
      'yoga',
      'penpaper'
    ];

    return BlocListener<EventFinderBloc, EventFinderState>(
      listener: (context, state) {
        if (state is EventFinderFiltered) {
          AutoRouter.of(context)
              .replace(LoadingEventFinderRoute(eventList: state.eventList));
        }

        if (state is LoadingEventFilterResults) {
          const CircularProgressIndicator();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/welcomepage_finder.png',
                      scale: 5,
                    ),
                    const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "Finde Events in der Umgebung",
                        style: TextStyle(
                            letterSpacing: 3,
                            color: Color.fromARGB(255, 126, 126, 126),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: size.width,
                        height: 5,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    const Text(
                      "In welchem Umkreis?",
                      style: TextStyle(
                          letterSpacing: 3,
                          color: Color.fromARGB(255, 126, 126, 126),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                        min: 1,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue.shade100,
                        value: radius,
                        label: radius.round().toString(),
                        onChanged: (radius) => setState(() {
                              this.radius = radius;
                            })),
                    const Text(
                      "Wann soll das Event stattfinden?",
                      style: TextStyle(
                          letterSpacing: 3,
                          color: Color.fromARGB(255, 126, 126, 126),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.none,
                      controller: textEditingControllerEventDate,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          iconColor: Colors.grey,
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          prefixIcon: const Icon(Icons.date_range),
                          labelText: dateString),
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050));
                        TimeOfDay? time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());

                        if (date != null && time != null) {
                          DateTime eventData = DateTime(date.year, date.month,
                              date.day, time.hour, time.minute);

                          setState(() {
                            startDate = eventData;
                            dateString =
                                helper.transformDateTimeToString(eventData);
                            textEditingControllerEventDate.text = dateString;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Wähle eine Kategorie",
                      style: TextStyle(
                          letterSpacing: 3,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 14),
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            value: value,
                            icon: const Icon(
                              Icons.category_rounded,
                              color: Colors.grey,
                            ),
                            items: items.map(buildItems).toList(),
                            onChanged: ((value) => setState(() {
                                  this.value = value;
                                }))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkResponse(
                      child: const EventDetailButton(
                        background: Colors.blue,
                        hight: 50,
                        width: 100,
                        text: '',
                        textColor: Colors.white,
                        borderColor: Colors.grey,
                        icon: Icons.search,
                        isIcon: true,
                      ),
                      onTap: () {
                        BlocProvider.of<EventFinderBloc>(context)
                            .add(StartFindingEvent(
                          categorie: value!,
                          time: startDate!,
                          radius: radius,
                        ));
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
      ),
    );
  }

  DropdownMenuItem<String> buildItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
}
