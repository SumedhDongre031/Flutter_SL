import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:test_sl/utils/utils.dart';
class LocationService{
  Location location = Location();
  late LocationData _locData;

  Future<Map<String,double?>?> initializeAndGetLocation(BuildContext context) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // Check whether location is enabled or not in the device
    serviceEnabled =await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled){
        if(context.mounted){
          Utils.showSnackBar("Please Enable Location Service", context);
          return null;
        }
      }
    }
    // If service is enabled then ask permission for location
    permissionGranted = await location.hasPermission();

    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        if(context.mounted){
          Utils.showSnackBar("Please Allow Location Access", context);
          return null;
        }
      }
    }

    // after permission is granted then return the cordinates
    _locData = await location.getLocation();
    return {
      'latitued': _locData.latitude,
      'longitued': _locData.longitude,
    };
  }

}