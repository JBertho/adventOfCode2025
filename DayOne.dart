
import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('resources/dayOne.txt'); // chemin relatif

  Stream<String> lines = file.openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter());
  
  int dial = 50;
  int password = 0;
  await for (var line in lines) {
    var direction = line.substring(0,1);
    int times = int.parse(line.substring(1));
    print("direction $direction deplacement $times");
    if(direction == "R") {
      dial = dial + times;
      print("step R : $dial");
      if(dial == 100) {
        dial = 0;
      }
      else if(dial > 99) {
        password += (dial/100).round();
        print("adding  ${(dial/100).round()}");
        dial = dial%100;
      }
    } else if (direction == "L") {
      dial = dial - times;
      if(dial < 0) {
        if (-dial >100) {
          print("value = $dial adding ${-(dial/100).round()} ");

          password += -(dial/100).round();
        } else {
          print("value = $dial adding 1 ");

          password += 1;
        }
        password += -(dial/100).round();
        print("adding  ${((-dial)/100).round() + 1} ");
        dial = dial%100;
      }
    }
    if(dial == 0) {
      print("EQUALS ZERO");
      if(times < 100) {
        password += 1;
      }
    }
    print("ETAPE COURANTE : " + dial.toString());
  }

  print("resultat finale : $password");
}