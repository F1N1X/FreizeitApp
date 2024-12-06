import 'package:flutter/material.dart';
import 'package:freizeit_app/praesentation/update_event/update_categorie_element.dart';

class UpdateCategorieList extends StatelessWidget {
  const UpdateCategorieList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: PageController(viewportFraction: 0.9),
        children: [
          UpdateCategorieElement(
            size: size,
            categorie: 'beer',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'bike',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'board-game',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'camera',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'chess',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'console',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'disco',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'explore',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'dog',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'fishing',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'fitness',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'holidays',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'horse',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'jogging',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'climbing',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'material-arts',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'meeting',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'motorcross',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'cinema',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'bowling',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'swimming',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'soccer',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'studying',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'tabletennis',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'teaching',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'tennis',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'volleyball',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'walk',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'yoga',
          ),
          UpdateCategorieElement(
            size: size,
            categorie: 'penpaper',
          )
        ],
      ),
    );
  }
}
