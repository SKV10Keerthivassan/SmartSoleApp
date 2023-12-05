import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart';
import 'package:hello/python_map.dart';
import 'package:hello/read_examples.dart';
import 'login_screen.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:photo_view/photo_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello/notification_remainder.dart';
import 'package:hello/left_values.dart';
import 'package:hello/new_map.dart';
import 'package:hello/python_map.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
//import 'package:image_picker_saver/image_picker_saver.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart' as bt;

import 'package:flutter_blue_plus/flutter_blue_plus.dart' as flutter_blue_plus;
import 'package:open_file/open_file.dart';

//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'package:flutter_blue/flutter_blue.dart';
SharedPreferences? prefs;
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

  // Variables to hold the values
  
  // Call the function to fetch and update values
   values[0]= await fetchDataFromFirebase('rPress1/data');
   values[1]= await fetchDataFromFirebase('rPress2/data');
   values[2]= await fetchDataFromFirebase('rPress3/data');
  values[3]= await fetchDataFromFirebase('rPress4/data');
  values[4]= await fetchDataFromFirebase('rPress5/data');
  values[5]= await fetchDataFromFirebase('rPress6/data');

  values[6]= await fetchDataFromFirebase('lPress1/data');
  values[7]= await fetchDataFromFirebase('lPress2/data');
  values[8]= await fetchDataFromFirebase('lPress3/data');
  values[9]= await fetchDataFromFirebase('lPress4/data');
  values[10]= await fetchDataFromFirebase('lPress5/data');
  values[11]= await fetchDataFromFirebase('lPress6/data');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      primarySwatch: Colors.amber,
      ),   
      home: FutureBuilder(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting, show a loading screen or splash screen
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              // User is logged in, navigate to the home screen
              return HomeScreen();
            } else {
              // User is not logged in, navigate to the login screen
              return LoginScreen();
            }
          }
        },
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    // Check the login status from SharedPreferences
    bool isLoggedIn = prefs?.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
  //const LoginScreen(),
}


//image from firebase
class FirebaseImage {
  final String imageUrl;
  FirebaseImage(this.imageUrl);
}

//display image side by side
class ZoomImageScreen extends StatelessWidget {
  final FirebaseImage image1;
  final FirebaseImage image2;

  ZoomImageScreen({required this.image1, required this.image2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom Images'),
      ),
      body: Row(
        children: [
          Expanded(
            child: ZoomableImage(imageUrl: image1.imageUrl),
          ),
          Expanded(
            child: ZoomableImage(imageUrl: image2.imageUrl),
          ),
        ],
      ),
    );
  }
}

//display 1 image and zoom
class ZoomableImage extends StatefulWidget {
  final String imageUrl;

   ZoomableImage({required this.imageUrl});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final PhotoViewController _controller = PhotoViewController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        controller: _controller,
        imageProvider: NetworkImage(widget.imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}

Future<void> loadImageUrls(BuildContext context) async {
  // Fetch image URLs from Firebase Storage
  String imageUrl1 = await firebase_storage.FirebaseStorage.instance.ref('leftfoot.jpeg').getDownloadURL();
  String imageUrl2 = await firebase_storage.FirebaseStorage.instance.ref('rightfoot.jpeg').getDownloadURL();

  // Create FirebaseImage objects
  FirebaseImage image1 = FirebaseImage(imageUrl1);
  FirebaseImage image2 = FirebaseImage(imageUrl2);

  // Navigate to the ZoomImageScreen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ZoomImageScreen(image1: image1, image2: image2),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();

}



int vali=0;
double val1=1;

List<double> values = [0, 0,0,0,0,0,  0,0,0,0,0,0];

Future<double> fetchDataFromFirebase(String path1) async {

  DatabaseReference ref1 = FirebaseDatabase.instance.ref(path1);

  // Get the data once
  DataSnapshot snapshot1 = (await ref1.once()).snapshot;

  // Print the data of the snapshot
  dynamic value = snapshot1.value; // This can be any value, either int or not

  if (value is int) {
    vali = value;
    val1=vali.toDouble(); // Assign value to intValue if it is an int
  } else {
    val1 = value ;
  }
  print(val1);
  return val1; // { "name": "John" }
}


class _HomeScreenState extends State<HomeScreen> {

  final List<CircleInfo> circleList = [
    CircleInfo(left: 130, top: 40, text: ' s1\n ${values[0]}',value: values[0]),
    CircleInfo(left: 120, top: 150, text: ' s2\n ${values[1]}',value: values[1]),
    CircleInfo(left: 190, top: 150, text: ' s3\n ${values[2]}',value: values[2]),
    CircleInfo(left: 250, top: 150, text: ' s4\n ${values[3]}',value: values[3]),
    CircleInfo(left: 150, top: 300, text: ' s5\n ${values[4]}',value: values[4]),
    CircleInfo(left: 180, top: 450, text: ' s6\n ${values[5]}',value: values[5]),
    // Add more CircleInfo objects for additional circles
  ];

  //left foot circle
  final List<CircleInfo> circleList1 = [
    CircleInfo(left: 230, top: 40, text: ' s1\n  ${values[6]}',value: values[6]),
    CircleInfo(left: 100, top: 150, text: ' s2\n  ${values[7]}',value: values[7]),
    CircleInfo(left: 170, top: 150, text: ' s3\n  ${values[8]}',value: values[8]),
    CircleInfo(left: 240, top: 150, text: ' s4\n  ${values[9]}',value: values[9]),
    CircleInfo(left: 200, top: 300, text: ' s5\n  ${values[10]}',value: values[10]),
    CircleInfo(left: 180, top: 450, text: ' s6\n ${values[11]}',value: values[11]),
    // Add more CircleInfo objects for additional circles
  ];

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Sole'),
        ),
      body:
      SingleChildScrollView(
        child:  Column(
       children: [
        Center(
          child: ElevatedButton(
            onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadExamples(),
                  ),
                );
            },
            child: Text('Read Right sensor values'),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeftExamples(),
                  ),
                );
            },
            child: Text('Read left sensor values'),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: (){
                loadImageUrls(context);
            },
            child: Text('image'),
            ),
        ),
      Center(
          child: ElevatedButton(
            onPressed: (){
            /*async {
              values[0]= await fetchDataFromFirebase('rPress1/data');
   values[1]= await fetchDataFromFirebase('rPress2/data');
   values[2]= await fetchDataFromFirebase('rPress3/data');
  values[3]= await fetchDataFromFirebase('rPress4/data');
  values[4]= await fetchDataFromFirebase('rPress5/data');
  values[5]= await fetchDataFromFirebase('rPress6/data');

  values[6]= await fetchDataFromFirebase('lPress1/data');
  values[7]= await fetchDataFromFirebase('lPress2/data');
  values[8]= await fetchDataFromFirebase('lPress3/data');
  values[9]= await fetchDataFromFirebase('lPress4/data');
  values[10]= await fetchDataFromFirebase('lPress5/data');
  values[11]= await fetchDataFromFirebase('lPress6/data');*/
            },
            child: Text('python map'),
          ),
        ),

        //right foot
        Center(
        child: RepaintBoundary(
          key: GlobalKey(),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/rightfoot.jpg',
                width: 450,
                height: 550,
                fit: BoxFit.contain,
                ), // Replace with your image path
              for (var circle in circleList)
                Positioned(
                  left: circle.left,
                  top: circle.top,
                  child: CircleContainer(circle.text,circle.value), // Replace with your custom circle widget
                ),
            ],
          ),
        ),
      ),
      
      //left foot
      Center(
        child: RepaintBoundary(
          key: GlobalKey(),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/leftfoot.jpg',
                width: 450,
                height: 550,
                fit: BoxFit.contain,
                ), // Replace with your image path
              for (var circle in circleList1)
                Positioned(
                  left: circle.left,
                  top: circle.top,
                  child: CircleContainer(circle.text,circle.value), // Replace with your custom circle widget
                ),
            ],
          ),
        ),
      ),

      /*ImageWithCircle(
  imagePath: 'assets/images/rightfoot.jpg',
  circlePosition: Offset(280, 180),
  circleRadius: 17,
  value: 45.5,
  text: '   s3    45.5',
  ),*/
     
       ],  
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RenderRepaintBoundary boundary =
              context.findRenderObject() as RenderRepaintBoundary;
          ui.Image image = await boundary.toImage(pixelRatio: 3.0);
          /*// Save the image or perform any other operations
          // Get the directory path for saving the image
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/output.png';

    // Save the image to the specified path
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    await File(imagePath).writeAsBytes(bytes);

    // Save the image to the device's gallery
    await ImageGallerySaver.saveFile(imagePath);

    // Display a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image saved successfully.'),
    ));*/

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? imageData = byteData?.buffer.asUint8List();
    /*// Save the image to the gallery
    final result = await ImagePickerSaver.saveFile(fileData: imageData);

    // Check if the image was saved successfully
    if (result != null && result.isNotEmpty) {
      print('Image saved successfully: $result');
    } else {
      print('Failed to save image.');
    }*/
        },
        child: Icon(Icons.save),
      ),
    
      
    drawer: Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('username'), 
            accountEmail: Text('useremail@gmail.com'),
            currentAccountPicture: Icon(Icons.account_circle,size: 80,color: Colors.white,),

          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text('Wifi'),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder:(context) => WifiDetails()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active_outlined),
            title: Text('notification'),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder:(context) => ReminderScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('bluetooth'),
            onTap: () {
              /*Navigator.push(
                context, 
                //MaterialPageRoute(builder:(context) => BluetoothControllerScreen()));
                MaterialPageRoute(builder:(context) => BluetoothApp()));*/
            },
          ),
          SizedBox(height: 250),
          Align(
            alignment: Alignment.bottomCenter,
            child:
            ElevatedButton(
              child: const Text("Log Out"),
              onPressed:() {
                // After logout
                prefs?.setBool('isLoggedIn', false);
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
                  
                });
              }
             ),
          ),
        ],
      ),
    ),
  
  );
  }
 }


//wifi credentials
class WifiDetails extends StatefulWidget {
  @override
  _WifiDetailsState createState() => _WifiDetailsState();
}

class _WifiDetailsState extends State<WifiDetails> {

  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isInputValid = false;

  void handleButtonPress() {
    String ssid = ssidController.text;
    String password = passwordController.text;
    // Do something with the entered SSID and password
    _database.child('SSID').set(ssid);
    _database.child('Password').set(password);
    print('SSID: $ssid');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("WIFI CREDENTIALS"),
      
      leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded, // Change the icon here
            ),
        onPressed: () {
              Navigator.pop(context);
            },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: ssidController,
              decoration: const InputDecoration(
                labelText: 'SSID',
              ),
              onChanged: (value) {
              setState(() {
              isInputValid = ssidController.text.isNotEmpty && passwordController.text.isNotEmpty;
              });
            },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
              setState(() {
              isInputValid = ssidController.text.isNotEmpty && passwordController.text.isNotEmpty;
              });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isInputValid ? handleButtonPress : null,
              child:const Text('Connect'),
 
            ),
          ],
          ),
      ),
    );
  }
}

//bluetooth 
/*class BluetoothApp extends StatefulWidget {
  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  late BluetoothDevice _device;
  bool _connected = false;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    bluetoothConnectionState();
  }

  // We are using async callback for using await
  Future<void> bluetoothConnectionState() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }
    
    // For knowing when bluetooth is connected and when disconnected
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });

          break;

        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;

        default:
          print(state);
          break;
      }
    });

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Flutter Bluetooth"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          // Defining a Column containing FOUR main Widgets wrapped with some padding:
          // 1. Text
          // 2. Row
          // 3. Card
          // 4. Text (wrapped with "Expanded" and "Padding")
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "PAIRED DEVICES",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                // Defining a Row containing THREE main Widgets:
                // 1. Text
                // 2. DropdownButton
                // 3. RaisedButton
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      // To be implemented : _getDeviceItems()
                      items: _getDeviceItems(),
                      onChanged: (value) => setState(() => _device = value),
                      value: _device,
                    ),
                    ElevatedButton(
                      onPressed:
                          // To be implemented : _disconnect and _connect
                          _pressed ? null : _connected ? _disconnect : _connect, 
                      child: Text(_connected ? 'Disconnect' : 'Connect'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Defining a Row containing THREE main Widgets:
                    // 1. Text (wrapped with "Expanded")
                    // 2. FlatButton
                    // 3. FlatButton
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "DEVICE 1",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              // To be implemented : _sendOnMessageToBluetooth()
                              _connected ? _sendOnMessageToBluetooth : null,
                          child: Text("ON"),
                        ),
                        ElevatedButton(
                          onPressed:
                              // To be implemented : _sendOffMessageToBluetooth()
                              _connected ? _sendOffMessageToBluetooth : null,
                          child: Text("OFF"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "NOTE: If you cannot find the device in the list, "
                      "please turn on bluetooth and pair the device by "
                      "going to the bluetooth settings",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() {
    if (_device == null) {
      show('No device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth
              .connect(_device)
              .timeout(Duration(seconds: 10))
              .catchError((error) {
            setState(() => _pressed = false);
          });
          setState(() => _pressed = true);
        }
      });
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }
  
  // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }

// Method to send message,
  // for turning the bletooth device on
  void _sendOnMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("1");
        show('Device Turned On');
      }
    });
  }

  // Method to send message,
  // for turning the bletooth device off
  void _sendOffMessageToBluetooth() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("0");
        show('Device Turned Off');
      }
    });
  }
*/

/*
class BluetoothApp extends StatefulWidget {
  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {
  // Initializing the Bluetooth connection state to be unknown
  //BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Initializing a global key, as it would help us in showing a SnackBar later
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  //BluetoothConnection connection;

  late int _deviceState;

  bool isDisconnecting = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green,
    'offTextColor': Colors.red,
    'neutralTextColor': Colors.blue,
  };

  // To track whether the device is still connected to Bluetooth
  //bool get isConnected => connection != null && connection.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  late BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    //FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        //_bluetoothState = state;
      });
    //});

    _deviceState = 0; // neutral

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    /*FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });*/
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    //if (isConnected) {
      isDisconnecting = true;
      //connection.dispose();
      //connection = null;
    }

    //super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<bool> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    //_bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    //if (_bluetoothState == BluetoothState.STATE_OFF) {
      //await FlutterBluetoothSerial.instance.requestEnable();
      //await getPairedDevices();
      return true;
    } //else 
    //{
      //await getPairedDevices();
    //}
    //return false;
  //}

  // For retrieving and storing the paired devices
  // in a list.
*/
  /*
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      //devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    //if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    //setState(() {
      //_devicesList = devices;
    //});
  //}

  // Now, its time to build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Flutter Bluetooth"),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(
                "Refresh",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                // So, that when new devices are paired
                // while the app is running, user can refresh
                // the paired devices list.
                await getPairedDevices().then((_) {
                  show('Device list refreshed');
                });
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                //visible: _isButtonUnavailable &&
                    //_bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Enable Bluetooth',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch(
                      value: _bluetoothState.isEnabled,
                      onChanged: (bool value) {
                        future() async {
                          if (value) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                          } else {
                            await FlutterBluetoothSerial.instance
                                .requestDisable();
                          }

                          await getPairedDevices();
                          _isButtonUnavailable = false;

                          if (_connected) {
                            _disconnect();
                          }
                        }

                        future().then((_) {
                          setState(() {});
                        });
                      },
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                           "PAIRED DEVICES",
                          style: TextStyle(fontSize: 24, color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Device:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) =>
                                  setState(() => _device = value!),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            ElevatedButton(
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected ? _disconnect : _connect,
                              child:
                                  Text(_connected ? 'Disconnect' : 'Connect'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: _deviceState == 0 ? 4 : 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "DEVICE 1",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _deviceState == 0
                                          ? colors['neutralTextColor']
                                          : _deviceState == 1
                                              ? colors['onTextColor']
                                              : colors['offTextColor'],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _connected
                                      ? _sendOnMessageToBluetooth
                                      : null,
                                  child: Text("ON"),
                                ),
                                TextButton(
                                  onPressed: _connected
                                      ? _sendOffMessageToBluetooth
                                      : null,
                                  child: Text("OFF"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "NOTE: If you cannot find the device in the list, please pair the device by going to the bluetooth settings",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          child: Text("Bluetooth Settings"),
                          onPressed: () {
                            FlutterBluetoothSerial.instance.openSettings;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
*/

  // Create the List of devices to be shown in Dropdown Menu
  /*
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // void _onDataReceived(Uint8List data) {
  //   // Allocate buffer for parsed data
  //   int backspacesCounter = 0;
  //   data.forEach((byte) {
  //     if (byte == 8 || byte == 127) {
  //       backspacesCounter++;
  //     }
  //   });
  //   Uint8List buffer = Uint8List(data.length - backspacesCounter);
  //   int bufferIndex = buffer.length;

  //   // Apply backspace control character
  //   backspacesCounter = 0;
  //   for (int i = data.length - 1; i >= 0; i--) {
  //     if (data[i] == 8 || data[i] == 127) {
  //       backspacesCounter++;
  //     } else {
  //       if (backspacesCounter > 0) {
  //         backspacesCounter--;
  //       } else {
  //         buffer[--bufferIndex] = data[i];
  //       }
  //     }
  //   }
  // }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    show('Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  // Method to send message,
  // for turning the Bluetooth device on
  void _sendOnMessageToBluetooth() async {
    connection.output.add(utf8.encode("1" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned On');
    setState(() {
      _deviceState = 1; // device on
    });
  }

  // Method to send message,
  // for turning the Bluetooth device off
  void _sendOffMessageToBluetooth() async {
    connection.output.add(utf8.encode("0" + "\r\n"));
    await connection.output.allSent;
    show('Device Turned Off');
    setState(() {
      _deviceState = -1; // device off
    });
  }

  // Method to show a Snackbar,
  // taking message as the text
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState?.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
}*/