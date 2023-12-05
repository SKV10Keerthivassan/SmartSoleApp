import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';



class ReadExamples extends StatefulWidget {
  @override
  _ReadExamplesState createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples>{
  
  final DatabaseReference ref1 = FirebaseDatabase.instance.ref('rPress1');
  final DatabaseReference ref2 = FirebaseDatabase.instance.ref('rPress2');
  final DatabaseReference ref3 = FirebaseDatabase.instance.ref('rPress3');
  final DatabaseReference ref4 = FirebaseDatabase.instance.ref('rPress4');
  final DatabaseReference ref5 = FirebaseDatabase.instance.ref('rPress5');
  final DatabaseReference ref6 = FirebaseDatabase.instance.ref('rPress6');
  
  /*Future<List<dynamic>> fetchData(DatabaseReference ref) async {
  DatabaseEvent snapshot = await ref.once();
  Map<dynamic, dynamic>? data = snapshot.value;
  if (data != null) {
    return data.values.toList();
  } else {
    return [];
  }
}*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded), // Change the icon here
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      /*
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Sensor 1
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '1 - Thumb finger',
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                FutureBuilder<List<dynamic>>(
                  future: fetchData(ref1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<dynamic> data = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${data[index]?.child('data').value.toString()} g/cm2 ',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    } else {
                      return Text('No data available.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    */body:Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children:[

            //Sensor 1
            Container
            (
              width:250,
              height:50,
              decoration:
              BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius:5,
                  offset: Offset(0,3),
                  ),
                ]
              ),
            child:
            Center(
               child: Text('1 - Thumb finger',  style: TextStyle(fontSize: 27,color: Colors.white),),
              ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref1,
              defaultChild: Text('loading'),
              itemBuilder:  (context, snapshot, animation, index) {
              return ListTile(
                title:  Text('${snapshot.child('data').value.toString()} g/cm2 ', style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              );
              }
            ),
          ),
            
          //Sensor 2  
          Container(
            width:250,
            height:50,
            decoration:BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius:5,
                  offset: Offset(0,3),
                  ),
                ]
              ),
            child: 
            Center(
              child: Text('2 - Toes', style: TextStyle(fontSize: 27,color: Colors.white),),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref2,
                defaultChild: Text('loading'),
                itemBuilder:  (context, snapshot, animation, index) {
                return ListTile(
                  title:
                    Text('${snapshot.child('data').value.toString()} g/cm2' , style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                );
              }
              ),
            ),

          //Sensor 3
          Container(
            width:250,
            height:50,
            decoration:BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius:5,
                offset: Offset(0,3),
                ),
              ]
              ),
            child:
            Center(
              child: Text('3 - Toes', style: TextStyle(fontSize: 27,color: Colors.white),),
            ),
           ),
            Expanded(
            child: FirebaseAnimatedList(
              query: ref3,
              defaultChild: Text('loading'),
              itemBuilder:  (context, snapshot, animation, index) {
              return ListTile(
                title: Text('${snapshot.child('data').value.toString()} g/cm2', style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                );
              }
              ),
            ),
            
          //Sensor 4
          Container(
            width:250,
            height:50,
            decoration:BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius:5,
                offset: Offset(0,3),
                ),
              ]
              ),
            child:
            Center(
              child: Text('4 - Toes', style: TextStyle(fontSize: 27,color: Colors.white),),
            ),
           ),
            Expanded(
            child: FirebaseAnimatedList(
              query: ref4,
              defaultChild: Text('loading'),
              itemBuilder:  (context, snapshot, animation, index) {
              return ListTile(
                title: Text('${snapshot.child('data').value.toString()} g/cm2', style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                );
              }
              ),
            ),

            //Sensor 5
            Container(
              width:250,
              height:50,
              decoration:BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius:5,
                  offset: Offset(0,3),
                  ),
                ]
                ),
            child:
             Center(
              child: Text('5 - Inner foot',  style: TextStyle(fontSize: 30,color: Colors.white),),
           ),
           ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref5,
              defaultChild: Text('loading'),
              itemBuilder:  (context, snapshot, animation, index) {
              return ListTile(
                title: Text('${snapshot.child('data').value.toString()} g/cm2', style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                );
            }
            ),
          ),

          //Sensor 6
          Container(
            width:250,
            height:50,
              decoration:BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius:5,
                  offset: Offset(0,3),
                  ),
                ]
              ),
            child:
            Center(
              child: Text('6 - Heel',  style: TextStyle(fontSize: 27,color: Colors.white),),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref6,
              defaultChild: Text('loading'),
              itemBuilder:  (context, snapshot, animation, index) {
              return ListTile(
                title: Text('${snapshot.child('data').value.toString()} g/cm2', style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),  
              );
              }
              ),
            ),
          
          ],
          ),
        ),
      ),
    );
  }
}