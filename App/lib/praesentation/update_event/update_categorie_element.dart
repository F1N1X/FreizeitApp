import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freizeit_app/application/event_update_bloc/bloc/eventupdate_bloc.dart';
import 'package:freizeit_app/core/pictures_path.dart';

class UpdateCategorieElement extends StatelessWidget {
  final String categorie;
  final Size size;
  const UpdateCategorieElement(
      {super.key, required this.categorie, required this.size});

  @override
  Widget build(BuildContext context) {
    GetPathToPicture path = GetPathToPicture();
    return BlocConsumer<EventupdateBloc, EventupdateState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkResponse(
          onTap: () {},
          child: Container(
              height: 20,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Image.asset(path.getPathToPicture(categorie))),
                    Text(
                      categorie.toUpperCase(),
                      style: const TextStyle(
                        letterSpacing: 3,
                        color: Color.fromARGB(255, 126, 126, 126),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const Icon(
                      Icons.swipe,
                      color: Colors.black,
                      size: 24.0,
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
