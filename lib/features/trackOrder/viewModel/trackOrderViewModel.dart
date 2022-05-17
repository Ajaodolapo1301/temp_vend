import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/GlobalState/baseState.dart';
import '../../../core/error/failures.dart';
import '../../../core/services/LocationService/googleNetwork.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../model/trackOrderModel.dart';
import '../repo/trackOrderRepo.dart';

abstract class AbstractTrackOrderViewModel extends BaseViewModel {
  Future<Either<Failure, TrackOrderModel>> trackOrder({id, token});
}

class TrackOrderViewModel extends AbstractTrackOrderViewModel {
  final Set<Polyline> _polyLine = {};
  Set<Polyline> get polyLine => _polyLine;
  Completer<GoogleMapController> completerController = Completer();
  GoogleMapController? mapController;

  GoogleMapsServices googleMapsServices = GoogleMapsServices();
  @override
  Future<Either<Failure, TrackOrderModel>> trackOrder({id, token}) async {
    setBusy(true);
    var res = await TrackOrderRepoImpl().trackOrder(id: id, token: token);
    setBusy(false);
    res.fold((l) {
      return l.props.first.toString();
    }, (r) {
      // _myOrder = r;
    });

    return res;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

//    print(lList.toString());

    return lList;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void onRoute(String encodedPoly) {
    _polyLine.add(Polyline(
        polylineId: PolylineId(toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encodedPoly)),
        color: primaryColor));
    notifyListeners();
  }

  void locationsOfRider(TrackOrderModel trackOrderModel) async {
    LatLng rider = trackOrderModel.riderCoordinate == null
        ? LatLng(double.parse(trackOrderModel.senderInfo!.pickupLat!),
            double.parse(trackOrderModel.senderInfo!.pickupLong!))
        : LatLng(double.parse(trackOrderModel.riderCoordinate!.riderLat!),
            double.parse(trackOrderModel.riderCoordinate!.riderLong!));
    LatLng user = LatLng(
        double.parse(trackOrderModel.receiverInfo!.destinationLat!),
        double.parse(trackOrderModel.receiverInfo!.destinationLong!));
    String route = await googleMapsServices.getRouteCoordinates(
        user
        // LatLng(6.605874, 3.349149)

        ,
        rider);

    onRoute(route);
    notifyListeners();
  }

  onMapCreated({GoogleMapController? controller}) {
    mapController = controller;
    completerController.complete(controller);
    // mapController.setMapStyle(mapStyle);
  }
}
