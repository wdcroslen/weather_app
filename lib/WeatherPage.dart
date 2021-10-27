import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Results"),
      ),

      body: SingleChildScrollView(child:
        Column(children: <Widget> [
         Center(child: Text("Weather Summary",style: TextStyle(color: Colors.pink,fontSize: 24,fontWeight: FontWeight.bold),)),
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
                              if(items.length==1)Text("${dates[0]}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                              if(items.length==1)Text("${items[0]}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),

                              if(items.length!=1 && items.length!=10)Text("${dates[index]}",style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),),
                              if(items.length!=1 && items.length!=10)Text("${items[index]}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),

                              if(items.length==10)Text("${dates[index]}",style: TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),),
                              if(items.length==10)Text("${items[index]}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),

                              if (items.length==10) Image.asset('assets/images/' +images[index],
            width: 50,
            height: 50,
            fit:BoxFit.fill

            ),
                              if(items.length!=10)Image.asset('assets/images/' +
                                  images[index],
                                  width: 80,
                                  height: 80,
                                  fit:BoxFit.fill

                              ),])
                    )
                ),
                Divider(
                  height: 4,
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
