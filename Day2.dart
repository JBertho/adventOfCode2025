import 'dart:io';

void findAllDuplicates() async {
  final file = File('resources/dayTwo.txt');
  final lines = await file.readAsLines();

  var errorsRepsonse = 0;

  for(var line in lines) {
    print(line);
    var ranges = line.split(",");
    for(var range in ranges) {
      var limits = range.split("-");
      if(limits.length >= 2) {
        var start = int.parse(limits[0]);
        var end = int.parse(limits[1]);
        print('$start et $end');
        for (int i = start; i <= end; i++) {
          String valueStr = "$i";
          var isValid = true;
          for(int i = (valueStr.length/2).ceil(); i >0; i--) {
            print("LE I : $i");
            var analysePart = valueStr.substring(0,(i).round());
            print('Start analysing $analysePart');
            var nextAnalyseStart = analysePart.length;
            print("Max search : ${valueStr.length~/analysePart.length } analysePart : $nextAnalyseStart");
            for(int y = 1; y < (valueStr.length~/analysePart.length); y++) {
              print("Check size : ${nextAnalyseStart + y} max size ${valueStr.length}");
              if(nextAnalyseStart + y <= valueStr.length ) {
                var analyse = valueStr.substring(nextAnalyseStart, nextAnalyseStart + y);
                print('current analyse : $analyse');
                if(analyse != analysePart) {
                  isValid = false;
                }
              }
            }
          }
          if(isValid) {
            print("validate : $i");
            errorsRepsonse += i;
          }
        }
      }
    }
  }

  print("$errorsRepsonse");
}

void main() {
  findAllDuplicates();
}