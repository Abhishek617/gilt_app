import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:guilt_app/constants/app_settings.dart';

class SetOnMapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<SetOnMapScreen> {
  late String selectedAddress;
  late GoogleMapController _controller;
  late Marker myMarker = new Marker(markerId: MarkerId('Address_Marker'));
  List<dynamic> addressList = [];
  Mode _mode = Mode.overlay;
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
    List<dynamic> locations = await locationFromAddress(selectedAddress);
    setState(() {
      addressList = locations;
      print(addressList);

      addMarker(LatLng(addressList[0].latitude, addressList[0].longitude));
    });
  }

  getAddressFromLocation() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        currentPos.latitude, currentPos.longitude);
    setState(() {
      Placemark add = placeMarks[0];
      selectedAddress = (add.name ?? '') +
          ',' +
          (add.subLocality ?? '') +
          ',' +
          (add.locality ?? '') +
          ',' +
          (add.country ?? '') +
          ',' +
          (add.postalCode ?? '');
    });
  }

  addMarker(LatLng markerPosition) {
    try {
      currentPos = markerPosition;
      getAddressFromLocation();
      myMarker = Marker(
          markerId: MarkerId('Address_Marker'),
          draggable: true,
          infoWindow: InfoWindow(title: 'Address', snippet: selectedAddress),
          position: markerPosition);
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
        ..addListener(_onScroll);
      moveCamera();
    } catch (err) {
      print(err);
    }
  }

  Widget _buildDropdownMenu() => DropdownButton(
        value: _mode,
        items: <DropdownMenuItem<Mode>>[
          DropdownMenuItem<Mode>(
            child: Text("Overlay"),
            value: Mode.overlay,
          ),
          DropdownMenuItem<Mode>(
            child: Text("Fullscreen"),
            value: Mode.fullscreen,
          ),
        ],
        onChanged: (m) {
          setState(() {
            _mode = m as Mode;
          });
        },
      );

  void onError(PlacesAutocompleteResponse response) {
    print(response);
  }

  Future<void> _handlePressButton() async {
    try {
      // show input autocomplete with selected mode
      // then get the Prediction selected
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        types: [],
        strictbounds: false,
        apiKey: AppSettings.googleMapAPIKey,
        onError: onError,
        mode: _mode,
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        components: [],
      );

      displayPrediction(p!);
    } catch (err) {
      print(err);
    }
  }

  Future<Null> displayPrediction(Prediction p) async {
    try {
      if (p != null) {
        // get detail (lat/lng)
        GoogleMapsPlaces _places = GoogleMapsPlaces(
          apiKey: AppSettings.googleMapAPIKey,
          apiHeaders: await GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry?.location.lat;
        final lng = detail.result.geometry?.location.lng;
        setState(() {
          addMarker(LatLng(lat!, lng!));
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ IconButton(
          onPressed: _handlePressButton,
          icon: Icon(Icons.search),
        ),],
        title: Text('Map'),
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
                    markers: Set.from([myMarker]),
                    onMapCreated: mapCreated,
                  )
                : Center(
                    child: Text('Map is loading...'),
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
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: currentPos,
      zoom: 14.0,
      bearing: 45.0,
      tilt: 45.0,
    )));
  }
}
