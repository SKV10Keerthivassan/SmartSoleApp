import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';



class LeftExamples extends StatefulWidget {
  @override
  _LeftExamplesState createState() => _LeftExamplesState();
}

class _LeftExamplesState extends State<LeftExamples>{
  
  final DatabaseReference ref1 = FirebaseDatabase.instance.ref('lPress1');
  final DatabaseReference ref2 = FirebaseDatabase.instance.ref('lPress2');
  final DatabaseReference ref3 = FirebaseDatabase.instance.ref('lPress3');
  final DatabaseReference ref4 = FirebaseDatabase.instance.ref('lPress4');
  final DatabaseReference ref5 = FirebaseDatabase.instance.ref('lPress5');
  final DatabaseReference ref6 = FirebaseDatabase.instance.ref('lPress6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('left examples'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded), // Change the icon here
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:Center(
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