import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../model/addressModel.dart';
import '../viewModel/sendPackageViewModel.dart';

class AutoCompleteField extends StatefulWidget {
  final String? labelText;
  final bool showSavedAddresses;
  final FormFieldSetter<AddressModel>? onSaved;
  final String error;
  // final InputBorder enabledBorder;
  // final InputBorder focusedBorder;
  final TextStyle textStyle;
  final autoValidate;
  // final Color progressColor;
  final AddressModel? address;

  final bool? fromReceiver;

  AutoCompleteField(
      {this.labelText,
      this.onSaved,
      this.autoValidate,
      this.error = "Something went wrong",
      // this.focusedBorder,
      // this.enabledBorder,
      this.address,
      this.fromReceiver,
      // this.progressColor =  blue,
      this.textStyle = const TextStyle(color: Colors.white, fontSize: 15.0),
      this.showSavedAddresses = false});

  @override
  _AutoCompleteFieldState createState() => _AutoCompleteFieldState(address);
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  TextEditingController? controller;
  Timer? _timer;
  PlacesAutocompleteResponse? response;
  GoogleMapsPlaces? _places;
  // bool loading;
  OverlayEntry? predictionOverlay;
  AddressModel? address;
  AddressModel? seleAddress;
  String? errorText;
  List<AddressModel>? savedAddresses;
  String? previousText;
  SendPackageViewModel? sendPackageViewModel;
  _AutoCompleteFieldState(AddressModel? address);

  @override
  void initState() {
    controller = TextEditingController(
        text: address == null ? '' : address!.description);
    previousText = controller!.text;
    controller!.addListener(onChange);
    // MyUtils.googleAPIKey().then((key) {
    //   _places = new GoogleMapsPlaces(apiKey: key);
    // });
    // loading = false;
    // if (widget.showSavedAddresses) {
    //   getSavedAddressesFromDB();
    // }
    super.initState();
  }

  @override
  void dispose() {
    _places?.dispose();
    closePredictionOverlay();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel = Provider.of(context);
    return CustomTextField(
      useMargin: false,
      textEditingController: controller,
      hint: "Enter address",
      suffix: sendPackageViewModel!.busy
          ? const CupertinoActivityIndicator()
          : controller!.text.isNotEmpty
              ? _buildClearIcon()
              : widget.showSavedAddresses
                  ? savedAddresses != null && savedAddresses!.isNotEmpty
                      ? _buildAddressIcon()
                      : null
                  : null,
      onSubmit: (_) => widget.onSaved!(address),
      validator: (_) => address == null
          ? errorText != null && errorText!.isNotEmpty
              ? errorText
              : widget.error
          : null,
    );
  }

  Future<Null> onChange() async {
    String value = controller!.text;

    if (previousText == value) {
      return;
    }

    address = null;
    if (value.length >= 3) {
      _timer?.cancel();
      if (value != null) {
        setState(() {
          // loading = true;
        });
      }
      // _timer = new Timer(const Duration(seconds: 2), () {
      //   _timer.cancel();
      //
      // });
      var res = await sendPackageViewModel?.doSearch(value);
      if (res!["error"] == false) {
        setState(() {
          response = res["places"];
        });
        showPredictions();
      }
    } else {
      _timer?.cancel();
      closePredictionOverlay();
    }
    previousText = value;
  }

  Widget _buildLoader() {
    var size = 24.0;
    return Container(
      alignment: Alignment.centerRight,
      width: size,
      height: size,
      margin: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: size,
        height: size,
        child: Theme(
            data: Theme.of(context).copyWith(primaryColor: primaryColor),
            child: const CircularProgressIndicator(
              strokeWidth: 2.0,
            )),
      ),
    );
  }

  Widget _buildClearIcon() {
    return IconButton(
        icon: Icon(
          Icons.clear,
          color: widget.textStyle.color,
        ),
        onPressed: _clearSearchBar);
  }

  Widget _buildAddressIcon() {
    return IconButton(
        icon: SvgPicture.asset(
          "assets/images/location.svg",
          width: 15.0,
          color: widget.textStyle.color,
        ),
        onPressed: null);
  }

  void _clearSearchBar() {
    setState(() {
      controller?.text = "";
      errorText = null;
      response = null;
      // loading = false;
    });
    address = null;
    closePredictionOverlay();
  }

  void showPredictions() {
    if (!mounted || response == null || response?.predictions == null) {
      return;
    }
    if (predictionOverlay == null) {
      final RenderBox? textFieldRenderBox =
          context.findRenderObject() as RenderBox?;
      final RenderBox? overlay =
          Overlay.of(context)!.context.findRenderObject() as RenderBox?;
      final width = textFieldRenderBox!.size.width;
      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          textFieldRenderBox.localToGlobal(
              textFieldRenderBox.size.bottomLeft(Offset.zero),
              ancestor: overlay),
          textFieldRenderBox.localToGlobal(
              textFieldRenderBox.size.bottomRight(Offset.zero),
              ancestor: overlay),
        ),
        Offset.zero & overlay!.size,
      );
      predictionOverlay = OverlayEntry(builder: (context) {
        return Positioned(
            top: position.top - 3,
            left: position.left,
            child: SizedBox(
                width: width,
                child: Card(
                    elevation: 3.0,
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(0.0))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: response!.predictions
                            .map((p) => PredictionTile(
                                  prediction: p,
                                  isLast: response!.predictions.last == p,
                                  onTap: (p) {
                                    closePredictionOverlay();

                                    previousText = p.description;
                                    controller!.text = p.description!;

                                    sendPackageViewModel!.getPredictionLatLng(p,
                                        fromReceiver: widget.fromReceiver!);
                                    pop(context);
                                  },
                                ))
                            .toList(),
                      ),
                    ))));
      });
      Overlay.of(context)!.insert(predictionOverlay!);
    }

    predictionOverlay!.markNeedsBuild();
  }

  void onSelected(Prediction newValue) {}

  handleError(String error) {
    if (mounted) {
      closePredictionOverlay();
      address = null;
      setState(() {
        errorText = error;
        // loading = false;
        response = null;
      });
    }
  }

  void closePredictionOverlay() {
    predictionOverlay?.remove();
    predictionOverlay = null;
  }

  //
  // void _intUsageTimes() async {
  //   MyUtils.autoCompleteTimes =
  //       (await SharedPreferences.getInstance()).getInt(Constants.autoCompleteTimes) ?? 0;
  // }
  //
  // void _saveUsageTimes() async {
  //   (await SharedPreferences.getInstance())
  //       .setInt(Constants.autoCompleteTimes, MyUtils.autoCompleteTimes);
  // }
  //
  // void _handleExcessUsage(String value) async {
  //   var duration = await MyUtils.getRemainingDuration(
  //       Constants.lastAutoCompleteWarningTimeStamp, 20);
  //   if (duration.inMilliseconds < 1 || duration.isNegative) {
  //     MyUtils.autoCompleteTimes = 0;
  //     var preferences = await SharedPreferences.getInstance();
  //     preferences.setInt(Constants.autoCompleteTimes, MyUtils.autoCompleteTimes);
  //     preferences.setInt(Constants.lastAutoCompleteWarningTimeStamp, null);
  //     doSearch(value);
  //   } else {
  //     handleError(
  //         'Address entry overuse. Retry in ${MyUtils.getRemainingTime(duration)}');
  //   }
  // }
  //
  // getSavedAddressesFromDB() async {
  //   var addresses = await AddressesDBHelper().getSavedAddress();
  //   setState(() {
  //     this.savedAddresses = addresses;
  //   });
  // }
  //
  // showSavedAddress() async {
  //   Address address = await showModalBottomSheet<Address>(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SavedAddressSelectedWidget(savedAddresses.reversed.toList());
  //       });
  //
  //   if (address == null) return;
  //
  //   previousText = address.description;
  //   setState(() => controller.text = address.description);
  //   this.address = address;
  // }

}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onTap;
  final bool isLast;

  const PredictionTile(
      {required this.prediction, required this.onTap, required this.isLast});

  @override
  Widget build(BuildContext context) {
    var tile = ListTile(
      onTap: () => onTap(prediction),
      leading: const Icon(
        Icons.location_on,
        color: Colors.grey,
      ),
      title: Text(
        prediction!.description!,
        style: kBold500,
      ),
    );
    return isLast!
        ? tile
        : Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.3))),
            child: tile);
  }
}

final int _maxUsage = 40;
