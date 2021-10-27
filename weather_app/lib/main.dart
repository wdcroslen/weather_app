import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:weatherapp/WeatherPage.dart';

List items = ['mostly sunny','sunny'];
List dates = [];
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
        primarySwatch: Colors.blue,
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

  getForecast() async {
    items = await Forecast().getResponse(Uri.parse(webService + _zip['zipcode'] + '&days=1'));
    print(items);
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
                            getForecast();
                            dates = Forecast().getDates(2);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondPage()),
                              //  ImageDescription(imageData: ImageData('title', 'url', 'description', 'tag'),)));
                            );
                        }
                      },
                    ),
                    ElevatedButton(
                      child: Text('5 Days'),
                      onPressed: () {
                        if (Form.of(context)!.validate()) {
                          getForecast();
                          dates = Forecast().getDates(5);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondPage()),
                            //  ImageDescription(imageData: ImageData('title', 'url', 'description', 'tag'),)));
                          );
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

            ],
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

    for (int i = 0; i<numberOfDays; i ++) {
      DateTime currDate = DateTime.now().add(Duration(days: i));
      String currentDate = new DateTime(currDate.year, currDate.month, currDate.day).toString();
      List rand = currentDate.split(" ");
      dates.add(rand[0]);
    }

    print(dates);
    return dates;
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