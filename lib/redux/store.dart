import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_middleware.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_middleware.dart';
import 'package:medical_app/redux/notification_list/notification_list_middleware.dart';
import 'package:medical_app/service/notification_service.dart';
import 'package:redux/redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/app/app_state_reducer.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_middleware.dart';

FlutterLocalNotificationsPlugin initLocalNotification() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      selectNotification: null);

  return flutterLocalNotificationsPlugin;
}

GoogleMapsPlaces initGoogleMapPlaces() {
  var placeApi = new GoogleMapsPlaces("AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w");
  return placeApi;
}

Future<Store<AppState>> createStore() async {
  var userRepository = new UserRepository();
  var medicineRepository = new MedicineRepository();

  var googleMapRepository = new GoogleMapRepository(initGoogleMapPlaces());
  var notificationService = new NotificationService(initLocalNotification());

  return new Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..addAll(createNearbyPharmaciesMiddleware(googleMapRepository))
        ..addAll(createMedicineListMiddleware(medicineRepository))
        ..addAll(createNotificationListMiddleware(userRepository))
        ..addAll(createMedicineNotificationMiddleware(
          userRepository,
          notificationService,
        )));
}
