import 'package:cloud_firestore/cloud_firestore.dart';

class GetPathToPicture {
  String getPathToPicture(String categorie) {
    switch (categorie) {
      case 'beer':
        return "lib/images/beer.png";
      case 'bike':
        return "lib/images/bike.png";
      case 'board-game':
        return "lib/images/board-game.png";
      case 'camera':
        return "lib/images/camera.png";
      case 'chess':
        return "lib/images/chess.png";
      case 'console':
        return "lib/images/console.png";
      case 'disco':
        return "lib/images/disco.png";
      case 'explore':
        return "lib/images/explore.png";
      case 'dog':
        return "lib/images/dog.png";
      case 'fishing':
        return "lib/images/fishing.png";
      case 'fitness':
        return "lib/images/fitness.png";
      case 'holidays':
        return "lib/images/holidays.png";
      case 'horse':
        return "lib/images/horse.png";
      case 'jogging':
        return "lib/images/jogging.png";
      case 'climbing':
        return "lib/images/climbing.png";
      case 'material-arts':
        return "lib/images/material-arts.png";
      case 'meeting':
        return "lib/images/meeting.png";
      case 'motorcross':
        return "lib/images/motocross.png";
      case 'cinema':
        return "lib/images/cinema.png";
      case 'bowling':
        return "lib/images/bowling.png";
      case 'swimming':
        return "lib/images/swimming.png";
      case 'soccer':
        return "lib/images/soccer.png";
      case 'studying':
        return "lib/images/studying.png";
      case 'tabletennis':
        return "lib/images/tabletennis.png";
      case 'teaching':
        return "lib/images/teaching.png";
      case 'tennis':
        return "lib/images/tennis.png";
      case 'volleyball':
        return "lib/images/volleyball.png";
      case 'walk':
        return "lib/images/walk.png";
      case 'yoga':
        return "lib/images/yoga.png";
      case 'penpaper':
        return "lib/images/penpaper.png";
    }
    //Not Found Bild
    return "lib/images/yoga.png";
  }

  String transformDateToString(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formatedDate = "";
    formatedDate =
        "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    return formatedDate;
  }

  DateTime timeStampToDayTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  String transformDateTimeToString(DateTime dateTime) {
    return "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }
}
