import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rootanya/data/network/contact_repository.dart';
import 'package:rootanya/data/network/google_map_repository.dart';
import 'package:rootanya/data/network/history_repository.dart';
import 'package:rootanya/data/network/medicine_repository.dart';
import 'package:rootanya/data/network/notification_repository.dart';
import 'package:rootanya/data/network/user_repository.dart';
import 'package:rootanya/data/prefs/prefs_repository.dart';
import 'package:rootanya/redux/add_contact/add_contact_middleware.dart';
import 'package:rootanya/redux/add_medicine/add_medicine_middleware.dart';
import 'package:rootanya/redux/app/app_middleware.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/app/app_state_reducer.dart';
import 'package:rootanya/redux/auth/auth_middleware.dart';
import 'package:rootanya/redux/contract/contact_middleware.dart';
import 'package:rootanya/redux/medicine_list/medicine_list_middleware.dart';
import 'package:rootanya/redux/medicine_notification/medicine_notification_middleware.dart';
import 'package:rootanya/redux/nearby_pharmacies/nearby_pharmacies_middleware.dart';
import 'package:rootanya/redux/notification_list/notification_list_middleware.dart';
import 'package:rootanya/redux/usages/usage_middleware.dart';
import 'package:rootanya/service/localtion_service.dart';
import 'package:rootanya/service/notification_service.dart';
import 'package:redux/redux.dart';

FlutterLocalNotificationsPlugin initLocalNotification() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  return flutterLocalNotificationsPlugin;
}

GoogleMapsPlaces initGoogleMapPlaces() {
  var placeApi = GoogleMapsPlaces(apiKey: "AIzaSyCgKZXhqaMrJkKsDY3CqLog8PwDvD_1vlc");
  return placeApi;
}

Future<Store<AppState>> createStore() async {
  var sharedPreferencesRepository = SharedPreferencesRepository();
  var userRepository = UserRepository();
  var medicineRepository = MedicineRepository();
  var historyRepository = UsageRepository();
  var googleMapRepository = GoogleMapRepository(initGoogleMapPlaces());
  var notificationRepository = NotificationRepository();
  var contractRepository = ContractRepository();
  var notificationService = NotificationService(initLocalNotification());
  var locationService = LocationService();

  return Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..addAll(createAppMiddleware(userRepository, sharedPreferencesRepository))
        ..addAll(createAuthMiddleware(
          userRepository,
          sharedPreferencesRepository,
        ))
        ..addAll(createNearbyPharmaciesMiddleware(googleMapRepository, locationService))
        ..addAll(createAddMedicineMiddleware(medicineRepository))
        ..addAll(createMedicineMiddleware(medicineRepository))
        ..addAll(createAddContactMiddleware(contractRepository))
        ..addAll(createContactsMiddleware(contractRepository))
        ..addAll(createUsageMiddleware(historyRepository))
        ..addAll(createNotificationListMiddleware(
          notificationRepository,
          notificationService,
        ))
        ..addAll(createMedicineNotificationMiddleware(
          notificationRepository,
          notificationService,
        )));
}
