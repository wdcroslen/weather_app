import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'WeatherPage.dart';

List items = ["mostly cloudy","rain","mostly sunny","showers","mostly cloudy","rain","rain","mostly sunny","rain","showers","showers","rain","sunny","mostly sunny","showers"];
List dates = ['October 1st', 'October 2nd'];
List images = [];
var webService = "http://cheon.atwebpages.com/weather/?zip=";
//http://www.cs.utep.edu/cheon/cs4381/homework/weather/?zip= "your zip code here" &days= "number of days"
//http://cheon.atwebpages.com/weather/?zip=79938&days=1
void main() {
  runApp(MyApp());
}

final GlobalKey<FormFieldState<String>> _zipcode = GlobalKey();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: RequestScreen(title: 'Weather App'),
    );
  }
}

class RequestScreen extends StatefulWidget {
  RequestScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<RequestScreen> {

  _notEmpty(String value) => value != null && value.isNotEmpty;

   nextPage(){
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => SecondPage()),
     );
   }
    getForecast(String numDays) async {
      RegExp _isLetter = RegExp(r'[a-z]', caseSensitive: false);
      var a = await Forecast().getResponse(Uri.parse(webService + _zip['zipcode'] + '&days=$numDays'));
      print("________________________________________________________________________________");
      if(numDays == '1') {
        var days = a.body.substring(2,((a.body).length-2));
        items = [];
        items.add(days);
      }
      else {
        var days = a.body.split(',');
        print(days);
        for(int i = 0; i < days.length; i++) {
          print(days[i]);
          if (i==0) {
            days[i] = days[i].substring(2, days[i].length - 1);
          } else if (i==days.length-1){
          days[i] = days[i].substring(1, days[i].length - 2);
        } else {
            days[i] = days[i].substring(1, days[i].length - 1);
          }
        }
        print(days);
        items = days;

      }
//      // print("________________________________________________________________________________");
//      print(items);
//      print('hi');
      nextPage();
//      dates = Forecast().getDates(15);
      images = Forecast().getImages();// print("________________________________________________________________________________");
    }

  get _zip =>
      ({
        'zipcode': _zipcode.currentState?.value,
      });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child:Form(
          child:Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container( width: 400,
              child:
              TextFormField(
                key: _zipcode,
                decoration: new InputDecoration(labelText: "Enter the Zipcode"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value.toString().length !=5){
                        return 'Valid ZipCode is required, length of 5';
                      }
                      return null;
                    },
                  ),
              ),
              SizedBox(height: 20),
              Builder(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('1 Day'),
                      onPressed: () {
                        if (Form.of(context)!.validate()) {
                            getForecast('1');
                            dates = Forecast().getDates(1);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SecondPage()),
                            // );
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('5 Days'),
                      onPressed: () {
                        if (Form.of(context)!.validate()) {
                          getForecast('5');
                          dates = Forecast().getDates(5);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SecondPage()),
                          // );
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('10 Days'),
                      onPressed: () {
                        if (Form.of(context)!.validate()) {
                          getForecast('10');
                          dates = Forecast().getDates(10);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SecondPage()),
                          // );
                          //
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () => Form.of(context)!.reset(),
                    )
                  ],
                );
              }),
              SizedBox(height: 250),
              Image.asset('assets/images/sunny.png',
                  width: 150,
                  height: 150,
                  fit:BoxFit.fill

              )],
          ),
        ),
      )
    );
  }
}



class Forecast {
  static final int sunny = 0;
  static final int mostlySunny = 1;
  static final int mostlyCloudy = 2;
  static final int cloudy = 3;
  static final int showers = 4;
  static final int rain = 5;

  DateTime date = DateTime.now();

  int description = 0;


  Future getResponse(var url) async {
    var response;
    if (url == null) {
      print("Oh NO your url isn't right!!");
    } else {
      response = await http.get(url);
    }
    return response;
  }

  List getDates(int numberOfDays) {
    List dates = [];
    if (numberOfDays ==0){
      DateTime currDate = DateTime.now();
      String currentDate = new DateTime(currDate.year, currDate.month, currDate.day).toString();
      List rand = currentDate.split(" ");
      dates.add(rand[0]);
      return dates;
    }
    for (int i = 0; i<numberOfDays; i ++) {
      DateTime currDate = DateTime.now().add(Duration(days: i));
      String currentDate = new DateTime(currDate.year, currDate.month, currDate.day).toString();
      List rand = currentDate.split(" ");
      dates.add(rand[0]);
    }

    return dates;
  }


  getImages() {
    List im = [];

    for (int i = 0; i<items.length; i++) {
      List status = items[i].split(" ");
      if (status.length > 1){
        im.add('mostly_' + status[status.length-1] + '.png');
      } else {
        im.add(status[status.length-1] + '.png');
      }
    }
    return im;
  }



  Image image() => Image.asset('assets/image/${_images[description]}');

  static final _images = [
    'sunny.png',
    'mostlySunny.png',
    'mostlyCloudy.png',
    'cloudy.png',
    'showers.png',
    'rain.png'
  ];
}