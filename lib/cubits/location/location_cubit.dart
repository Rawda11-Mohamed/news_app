
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaber_app/cubits/location/location_state.dart';
import 'package:khaber_app/repositories/location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCubit extends Cubit<LocationState>
{
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);
  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  Set<Marker> markers = {};

  changeLocation(LatLng newLocation)
  {
    markers.clear();
    markers.add(
        Marker(
            markerId: MarkerId('New Location'),
            position: newLocation
        )
    );
    emit(LocationSuccess( newLocation));
  }
  getLocation()async
  {
    LocationRepository repo = LocationRepository();
    emit(LocationLoading());
    var response = await repo.getLocation();
    response.fold(
            (String error) => emit(LocationError( error)),
            (position) {
          LatLng latLng = LatLng(position.latitude, position.longitude);
          markers.add(
              Marker(
                  markerId: MarkerId('current location'),
                  position: latLng
              )
          );
          emit(LocationSuccess(latLng));
        }
    );
  }
}
