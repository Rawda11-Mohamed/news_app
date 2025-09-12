import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khaber_app/cubits/location/location_cubit.dart';
import 'package:khaber_app/cubits/location/location_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Location'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LocationSuccess) {
            return GoogleMap(
              // mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: state.latLng,
                zoom: 14.0,
              ),
              // onMapCreated: (GoogleMapController controller) {
              //   context.read<LocationCubit>().controller.complete(controller);
              // },
              // markers: context.read<LocationCubit>().markers,
            );
          }
          return const Center(child: Text('Press the button to get your location'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationCubit>().getLocation();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}


