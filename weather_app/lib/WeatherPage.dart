import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),

      body: Center( child:
        Column(children: <Widget> [
         Center(child: Text("Weather Summary",style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),)),
          SizedBox(height: 45),


          ListView.builder(
            shrinkWrap: true
            ,itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    child:
                    Container(width: 900,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
//                              Image(),
                              Text("${dates[index]}",style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),),
                              Text("${items[index]}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                              Image.asset('assets/images/' +
                                  images[index],
                                  width: 100,
                                  height: 100,
                                  fit:BoxFit.fill

                              ),])
                    )
                ),
                Divider(
                  height: 12,
                  color: Colors.blueGrey,
                )
              ],
            );
          },itemCount: items.length,),



          SizedBox(height:25),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ]
        ),

      ),
    );
  }
}
