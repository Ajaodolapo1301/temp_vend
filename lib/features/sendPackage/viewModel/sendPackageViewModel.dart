import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/constants/keyConstants.dart';
import '../../../core/services/LocationService/locationServices.dart';
import '../../../core/utils/myUtils/myUtils.dart';
import '../../authentication/model/initialModel.dart';
import '../api/data_source/remote_data_source/create_order_api.dart';
import '../model/addressModel.dart';

class SendPackageViewModel extends BaseViewModel {
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  TextEditingController whatAreYouSending = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController addInfo = TextEditingController();

  PackageSize? _packageSize;
  PackageSize get packageSize => _packageSize!;
  set packageSize(PackageSize value) {
    _packageSize = value;
    notifyListeners();
  }

  DateTime? toUTC;

  DeliveryType? _deliveryType;
  DeliveryType get deliveryType => _deliveryType!;
  set deliveryType(DeliveryType value) {
    _deliveryType = value;
    notifyListeners();
  }

  DeliveryTime? _deliveryTime;
  DeliveryTime get deliveryTime => _deliveryTime!;
  set deliveryTime(DeliveryTime value) {
    _deliveryTime = value;
    notifyListeners();
  }

  bool scheduleLater = false;

  int selectedDeliveryTimeIndex = 0;
  int selectedPackageSizeIndex = 0;
  int selectedDeliveryTypeIndex = 0;

  AddressModel? _currentAddress;
  TextEditingController senderAddress = TextEditingController();
  TextEditingController receiverAddressController = TextEditingController();

  AddressModel? _receiverAddress;
  AddressModel get currentAddress => _currentAddress!;
  AddressModel get receiverAddress => _receiverAddress!;

  set currentAddress(AddressModel address) {
    _currentAddress = address;
    notifyListeners();
  }

  set receiverAddress(AddressModel address) {
    _receiverAddress = address;
    notifyListeners();
  }

  SendPackageViewModel() {
    MyUtils.googleAPIKey().then((key) {
      _places = GoogleMapsPlaces(apiKey: key);
    });
  }

  LocationService locationService = LocationService();

  GoogleMapsPlaces? _places;

  Future<dynamic> getCurrrent() async {
    setBusy(true);
    try {
      var res = await locationService.determinePosition();
      Location location = Location(lat: res["lat"], lng: res["lon"]);

      var raw = await CreateOrderImpl().getRawResponse(
          apiKey: API_KEY, lat: location.lat, lon: location.lng);
      print(raw);
      if (raw["error"] == false) {
        currentAddress = AddressModel(
            res["lat"], res["lon"], res["addressLine"], raw["rawResponse"]);
        senderAddress.text = currentAddress.description!;
      }

      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> doSearch(String value) async {
    Map<String, dynamic> result = {};
    if (MyUtils.autoCompleteTimes <= _maxUsage) {
      if (value.isNotEmpty) {
        try {
          setBusy(true);
          final res = await _places!.autocomplete(
            value,
            language: "en",
            types: [],
            components: [Component(Component.country, "NG")],
          );
          setBusy(false);
          print(res);
          if (res.errorMessage?.isNotEmpty == true ||
              res.status == "REQUEST_DENIED") {
            result['error'] = false;
            result['message'] = "Unable to get location details ${res.status}";
          } else {
            if (res.predictions.isEmpty) {
              result['error'] = false;
              result['message'] = "Could not get location";
            } else {
              result['error'] = false;
              result['places'] = res;

              //showPredictions();
            }
          }
        } catch (e) {
          print("$e");
          result['error'] = false;
          result['message'] = e.toString();
        }
      } else {
        result['error'] = false;
        result['message'] = "Unable to get location details";
      }
    } else {
      result['error'] = false;
      result['message'] = "Unable to get location details";
    }

    print("$result");
    return result;
  }

  Future getPredictionLatLng(Prediction p, {bool fromReceiver = false}) async {
    // print("hereeee");
    setBusy(true);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places!.getDetailsByPlaceId(p.placeId!);

      PlaceDetails? res = detail.result;

      if (res == null) {}

      // handleError("Unable to get address details");
      final lat = res.geometry?.location.lat;
      final lng = res.geometry?.location.lng;
      // print(lng);
      // print(lat);
      var raw = await CreateOrderImpl().getRawResponse(
          apiKey: API_KEY,
          lat: res.geometry!.location.lat,
          lon: res.geometry!.location.lng);
      // print("yyyyyyyyyyy$raw");
      fromReceiver
          ? receiverAddress =
              AddressModel(lat!, lng!, p.description!, raw["rawResponse"])
          :
          // receiverAddressController.text = receiverAddress?.description;
// print("eeeee  $receiverAddress");
          currentAddress =
              AddressModel(lat!, lng!, p.description!, raw["rawResponse"]);
      senderAddress.text = currentAddress.description!;
      receiverAddressController.text = receiverAddress.description!;

      setBusy(false);

      notifyListeners();
    }
  }
}

final int _maxUsage = 40;
