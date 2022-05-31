import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guilt_app/constants/app_settings.dart';
import 'package:mobx/mobx.dart';

class SetOnMapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<SetOnMapScreen> {
  late String selectedAddress;
  late GoogleMapController _controller;
  late Marker MyMarker = new Marker(markerId: MarkerId('Address_Marker'));
  List<Location> addressList = [];
  late PageController _pageController;
  late int prevPage;
  late final ArgumentCallback<LatLng> onTap;
  late LatLng currentPos;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
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

  getPredictions() async {
    List<Location> locations =
        await locationFromAddress(selectedAddress ?? "Gronausest10, Enschede");
    setState(() {
      addressList = locations;
      print(addressList);

      addMarker(LatLng(addressList[0].latitude, addressList[0].longitude));
    });
  }

  getAddressFromLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPos.latitude, currentPos.longitude);
    setState(() {
      Placemark add = placemarks[0];
      selectedAddress = (add.name ?? '') + ',' + (add.subLocality ?? '') + ',' + (add.locality ?? '') + ',' + (add.country ?? '') + ',' + (add.postalCode ?? '');
    });
  }

  addMarker(LatLng markerPosition) {
    currentPos = markerPosition;
    getAddressFromLocation();
    MyMarker = Marker(
        markerId: MarkerId('Address_Marker'),
        draggable: true,
        infoWindow:
            InfoWindow(title: 'Address', snippet: selectedAddress),
        position: markerPosition);
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Location"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context, {"position": currentPos, "address": selectedAddress});
          },
          icon: Icon(
            Icons.chevron_left,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: (addressList.length > 0)
                ? GoogleMap(
                    onTap: (latLng) {
                      setState(() {
                        addMarker(latLng);
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            addressList[0].latitude, addressList[0].longitude),
                        zoom: 13.0),
                    markers: Set.from([MyMarker]),
                    onMapCreated: mapCreated,
                  )
                : Center(child: Text('Map is loading...')),
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
