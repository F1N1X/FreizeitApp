import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/user_information/bloc/userinformation_bloc.dart';
import 'package:freizeit_app/routes/router.gr.dart';
import 'package:freizeit_app/praesentation/welcome_screen/widgets/greetings_area.dart';
import 'package:freizeit_app/praesentation/welcome_screen/widgets/menu_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    return BlocBuilder<UserinformationBloc, UserInformationState>(
      builder: (context, state) {
        if (state is LoadingUserSucceded) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(246, 252, 250, 250),
            body: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/images/test.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                GreetingArea(userMail: state.email),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: MenuWidget(
                        widgetSubtitle: "Stadtkarte",
                        iconAssetPath: "lib/images/welcomepage_city.png",
                        onPressed: () {
                          AutoRouter.of(context).replace(const CityPageRoute());
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: MenuWidget(
                        widgetSubtitle: "Meine Events",
                        iconAssetPath: "lib/images/welcomepage_eventlist.png",
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const PersonalEventPageRoute());
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: MenuWidget(
                        widgetSubtitle: "Eventfinder",
                        iconAssetPath: "lib/images/welcomepage_finder.png",
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const InitFinderRoute());
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: MenuWidget(
                        widgetSubtitle: "Event erstellen",
                        iconAssetPath: "lib/images/welcomepage_create.png",
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const EventCreationFromWelcomeRoute());
                        },
                      ),
                    ),
                  ],
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
                              .replace(const LoginPageRoute());
                        },
                        icon: const Icon(Icons.logout_outlined),
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
          );
        }

        return Container();
      },
    );
  }
}
