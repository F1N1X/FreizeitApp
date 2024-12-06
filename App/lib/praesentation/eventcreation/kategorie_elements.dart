import 'package:flutter/material.dart';
import 'package:freizeit_app/praesentation/eventcreation/categorie_element.dart';

class CategoriePageView extends StatelessWidget {
  const CategoriePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.3,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: PageController(viewportFraction: 0.9),
        children: [
          CategorieElement(
            size: size,
            categorie: 'beer',
          ),
          CategorieElement(
            size: size,
            categorie: 'bike',
          ),
          CategorieElement(
            size: size,
            categorie: 'board-game',
          ),
          CategorieElement(
            size: size,
            categorie: 'camera',
          ),
          CategorieElement(
            size: size,
            categorie: 'chess',
          ),
          CategorieElement(
            size: size,
            categorie: 'console',
          ),
          CategorieElement(
            size: size,
            categorie: 'disco',
          ),
          CategorieElement(
            size: size,
            categorie: 'explore',
          ),
          CategorieElement(
            size: size,
            categorie: 'dog',
          ),
          CategorieElement(
            size: size,
            categorie: 'fishing',
          ),
          CategorieElement(
            size: size,
            categorie: 'fitness',
          ),
          CategorieElement(
            size: size,
            categorie: 'holidays',
          ),
          CategorieElement(
            size: size,
            categorie: 'horse',
          ),
          CategorieElement(
            size: size,
            categorie: 'jogging',
          ),
          CategorieElement(
            size: size,
            categorie: 'climbing',
          ),
          CategorieElement(
            size: size,
            categorie: 'material-arts',
          ),
          CategorieElement(
            size: size,
            categorie: 'meeting',
          ),
          CategorieElement(
            size: size,
            categorie: 'motorcross',
          ),
          CategorieElement(
            size: size,
            categorie: 'cinema',
          ),
          CategorieElement(
            size: size,
            categorie: 'bowling',
          ),
          CategorieElement(
            size: size,
            categorie: 'swimming',
          ),
          CategorieElement(
            size: size,
            categorie: 'soccer',
          ),
          CategorieElement(
            size: size,
            categorie: 'studying',
          ),
          CategorieElement(
            size: size,
            categorie: 'tabletennis',
          ),
          CategorieElement(
            size: size,
            categorie: 'teaching',
          ),
          CategorieElement(
            size: size,
            categorie: 'tennis',
          ),
          CategorieElement(
            size: size,
            categorie: 'volleyball',
          ),
          CategorieElement(
            size: size,
            categorie: 'walk',
          ),
          CategorieElement(
            size: size,
            categorie: 'yoga',
          ),
          CategorieElement(
            size: size,
            categorie: 'penpaper',
          )
        ],
      ),
    );
  }
}
