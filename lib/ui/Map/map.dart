import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guilt_app/constants/app_settings.dart';

class SetOnMapScreen extends StatefulWidget {


  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<SetOnMapScreen> {
  late String selectedAddress;
  late GoogleMapController _controller;
  List<Marker> allMarkers = [];
  List<Location> addressList = [];
  late PageController _pageController;
  late int prevPage;
  @override
  void initState() {
    super.initState();
    addressList.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.timestamp.timeZoneName),
          draggable: false,
          infoWindow:
          InfoWindow(title: element.timestamp.timeZoneName, snippet: element.toString()),
          position: LatLng(element.latitude,element.longitude)));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState((){
      selectedAddress = args['address'];
      getPredictions();
    });
   
    super.didChangeDependencies();
  }
  
  void _onScroll() {
    if (_pageController.page?.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  getPredictions() async{
    List<Location> locations = await locationFromAddress(selectedAddress??"Gronausestraat 710, Enschede");
    setState((){
      addressList = locations;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Set On Map"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(23.766816828336566, 90.43797422492939),
                  zoom: 13.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    // _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: hospitalInfo[_pageController.page!.toInt()].locationCoords,
    //   zoom: 14.0,
    //   bearing: 45.0,
    //   tilt: 45.0,
    // )));
  }
}