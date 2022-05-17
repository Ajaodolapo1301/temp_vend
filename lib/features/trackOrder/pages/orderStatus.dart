import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vend_express/features/profile/pages/contact_us.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/styles/fontSize.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../myOrder/widget/trackOrderWidget.dart';
import '../model/trackOrderModel.dart';
import '../viewModel/trackOrderViewModel.dart';

class OrderStatus extends StatefulWidget {
  final TrackOrderModel? trackOrderModel;
  const OrderStatus({Key? key, this.trackOrderModel}) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus>
    with AfterLayoutMixin<OrderStatus> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  String? _mapStyle;
  var positionHeight = 100.0;
  bool full = true;
  TrackOrderModel? trackOrderModel;
  TrackOrderViewModel? trackOrderViewModel;
  BitmapDescriptor? pickUp;
  BitmapDescriptor? dropOff;
  final Set<Marker> _mark = {};

  @override
  void initState() {
    trackOrderModel = widget.trackOrderModel;

    rootBundle.loadString('assets/mapStyle/uber_style.txt').then((string) {
      _mapStyle = string;
    });

    setSourceAndDestinationIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trackOrderViewModel = Provider.of<TrackOrderViewModel>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: const LatLng(6.44594877, 3.48441658), zoom: 9.5),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,

              myLocationEnabled: true,
              trafficEnabled: false,
              markers: _mark,
              polylines: trackOrderViewModel!.polyLine,
              compassEnabled: true,
              myLocationButtonEnabled: false,
//                onCameraMove: appState.onCameraMove,
//              markers: appState.markers,
//              onCameraMove: appState.onCuserone@gmail.comameraMove,
            ),
          ),

          backCard(),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.25,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: CustomScrollViewContent(
                  trackOrderModel: trackOrderModel,
                ),
              );
            },
          ),

          // Container(
          //   child:   stop(),
          // )
        ],
      ),
    );
  }

  Widget slidWidget() {
    return Container(
        decoration: const BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        // height: 300,
        width: MediaQuery.of(context).size.width,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        icon: full
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                        onPressed: () {}),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery in progress",
                        style: kBold400.copyWith(
                            fontSize: sixteen, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 90,
                        animation: true,
                        lineHeight: 10.0,
                        animationDuration: 2000,
                        percent: 0.9,
                        // center: Text("90.0%"),
                        linearStrokeCap: LinearStrokeCap.butt,
                        progressColor: const Color(0xffacb0f2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        trackOrderModel!.deliveryTime!.name!,
                        style: kBold400.copyWith(
                            fontSize: twelve, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: fourteen,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Time of Arrival",
                      style: kBold400.copyWith(
                          fontSize: fourteen, color: const Color(0xff666E7A)),
                    ),
                    Text(
                      trackOrderModel!.eta!,
                      style: kBold700.copyWith(fontSize: sixteen),
                    )
                  ],
                ),
                SizedBox(
                  height: fourteen,
                ),
                Expanded(
                    child: Column(
                  children: [
                    trackOrderWidget(
                        boldText:
                            "Amount Paid : ₦${trackOrderModel!.payment?.price}",
                        text:
                            "Payment with ${trackOrderModel!.payment?.method}",
                        subtext: "Delivered on 11:15am  24th July 2021",
                        type: "Receiver Info"),
                  ],
                )),
                CustomButton(
                  text: "Contact Us",
                  type: ButtonType.outlined,
                  onPressed: () {
                    pushTo(context, TawkPage());
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ));
  }

  Widget stop() {
    return Positioned(
      bottom: -10,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // toggle();
          });
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            height: positionHeight,
            width: MediaQuery.of(context).size.width,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                            icon: full
                                ? const Icon(Icons.keyboard_arrow_up)
                                : const Icon(Icons.keyboard_arrow_down),
                            onPressed: () {
                              // toggle();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget backCard() {
    return Positioned.fill(
      top: 50.0,
      left: 5,
      child: Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: () {
            pop(context);
          },
          child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: 48.0,
              height: 48.0,
              child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 2.5,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: primaryColor,
                    ),
                  ))),
        ),
      ),
    );
  }

  void _onMapCreated(controller) {
    mapController = controller;
    _controller.complete(controller);
    mapController!.setMapStyle(_mapStyle);
    setStartPin();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    trackOrderViewModel!.locationsOfRider(trackOrderModel!);
  }

  void setStartPin() {
    // source pin
    setState(() {
      _mark.add(Marker(
          markerId: const MarkerId('sourcePin'),
          position: trackOrderModel!.riderCoordinate == null
              ? LatLng(double.parse(trackOrderModel!.senderInfo!.pickupLat!),
                  double.parse(trackOrderModel!.senderInfo!.pickupLong!))
              : LatLng(
                  double.parse(trackOrderModel!.riderCoordinate!.riderLat!),
                  double.parse(trackOrderModel!.riderCoordinate!.riderLong!)),
          icon: pickUp!));
      // destination pin
      _mark.add(Marker(
          markerId: const MarkerId('destPin'),
          position: LatLng(
              double.parse(trackOrderModel!.receiverInfo!.destinationLat!),
              double.parse(trackOrderModel!.receiverInfo!.destinationLong!)),
          icon: dropOff!));
    });
    _controller.future.then((value2) {
      value2.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: trackOrderModel?.riderCoordinate == null
              ? LatLng(double.parse(trackOrderModel!.senderInfo!.pickupLat!),
                  double.parse(trackOrderModel!.senderInfo!.pickupLong!))
              : LatLng(
                  double.parse(trackOrderModel!.riderCoordinate!.riderLat!),
                  double.parse(trackOrderModel!.riderCoordinate!.riderLong!)),

          // LatLng(double.parse(trackOrderModel.senderInfo.pickupLat), double.parse(trackOrderModel.senderInfo.pickupLong)),
          zoom: 13.5)));
    });
  }

  void setSourceAndDestinationIcons() async {
    pickUp = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1.0),
        'assets/images/trackOrder/dest.png');
    dropOff = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1.0),
        'assets/images/trackOrder/dest.png');

    print(pickUp);
  }
}

class CustomScrollViewContent extends StatelessWidget {
  final TrackOrderModel? trackOrderModel;

  const CustomScrollViewContent({Key? key, this.trackOrderModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: CustomInnerContent(
          trackOrderModel: trackOrderModel,
        ),
      ),
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  final TrackOrderModel? trackOrderModel;

  const CustomInnerContent({Key? key, this.trackOrderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(
          height: fourteen,
        ),
        CustomHorizontallyScrollingRestaurants(
          trackOrderModel: trackOrderModel,
        )
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class CustomHorizontallyScrollingRestaurants extends StatelessWidget {
  final TrackOrderModel? trackOrderModel;

  const CustomHorizontallyScrollingRestaurants({Key? key, this.trackOrderModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your package is ${trackOrderModel!.status == "completed" ? "completed" : "ongoing"} ",
                  style:
                      kBold400.copyWith(fontSize: sixteen, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 90,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 2000,
                    percent: trackOrderModel!.progress!.toDouble(),
                    // center: Text("90.0%"),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: complementary
                    // Color(0xffacb0f2),
                    ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  trackOrderModel!.deliveryTime!.name!,
                  style:
                      kBold400.copyWith(fontSize: twelve, color: Colors.white),
                ),
              ],
            ),
          ),

          SizedBox(
            height: fourteen,
          ),
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Estimated Time of Arrival",
                style: kBold400.copyWith(
                    fontSize: fourteen, color: const Color(0xff666E7A)),
              ),
              Text(
                trackOrderModel!.eta!,
                style: kBold700.copyWith(fontSize: sixteen),
              )
            ],
          ),
          //
          SizedBox(
            height: fourteen,
          ),
          SizedBox(
            height: fourteen,
          ),
          Column(
            children: [
              trackOrderWidget(
                  boldText:
                      "Amount Paid : ₦${trackOrderModel!.payment!.price!}",
                  // text: "Payment with ${trackOrderModel.payment.method}",
                  text: trackOrderModel!.receiverInfo!.destinationAddress!,
                  subtext: trackOrderModel!.receiverInfo!.receiverPhoneNumber,
                  type: "Receiver Info"),
            ],
          ),
          SizedBox(
            height: fourteen,
          ),
          CustomButton(
            text: "Contact Us",
            type: ButtonType.outlined,
            onPressed: () {
              pushTo(context, TawkPage());
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
