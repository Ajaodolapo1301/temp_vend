// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:intl/intl.dart';
// import 'package:primhex/core/constants/textStyleConstants.dart';
// import 'package:primhex/core/features/sendPackage/model/delivery_time_model.dart';
// import 'package:primhex/core/features/sendPackage/model/package_model.dart';
// import 'package:primhex/core/features/sendPackage/model/radioModel.dart';
// import 'package:primhex/core/features/sendPackage/widget/delivery_time.dart';
// import 'package:primhex/core/features/sendPackage/widget/delivery_type.dart';
// import 'package:primhex/core/features/sendPackage/widget/item_box.dart';
// import 'package:primhex/core/features/sendPackage/widget/radioWidget.dart';
//
// import 'package:primhex/core/utils/function/timePicker.dart';
// import 'package:primhex/core/utils/navigation/navigator.dart';
// import 'package:primhex/core/utils/sizeConfig/sizeConfig.dart';
// import 'package:primhex/core/utils/styles/color_utils.dart';
// import 'package:primhex/core/utils/widgets/custom_button.dart';
// import 'package:primhex/core/utils/widgets/custom_text_field.dart';
//
// class CreateOrder extends StatefulWidget {
//   const CreateOrder({Key key}) : super(key: key);
//
//   @override
//   _CreateOrderState createState() => _CreateOrderState();
// }
//
// class _CreateOrderState extends State<CreateOrder> {
//
//   int upperBound = 2;
//   StepperType stepperType = StepperType.horizontal;
//   int activeStep = 2;
//   var sendersName;
//   var senderAddress;
//   var senderPhone;
//   var senderSending;
//   var packageSize;
//
//
//   var receiverName;
//   var receiverAddress;
//   var receiverPhone;
//   var receiverAddInfo;
//   bool timeSelectedExpress = false;
//   bool standard = true;
//   bool scheduleLater = false;
//   String _scheduleDate;
//   TextEditingController _scheduleController = TextEditingController();
//
//   DateFormat dateFormat = DateFormat("dd/MM/yyyy");
//   List<RadioModel> sampleData = [];
//   List<PackageModel> packageList = [
//     PackageModel(
//       selected: true,
//       text: "< 1kg",
//       image: "${imagePath}order/envelope.png",
//     ),
//     PackageModel(
//       selected: false,
//       text: "2kg - 5kg",
//       image: "${imagePath}order/box.png",
//     ),
//     PackageModel(
//       selected: false,
//       text: "> 5kg",
//       image: "${imagePath}order/bigBox.png",
//     )
//   ];
//
//   List<PackageModel> deliveryList = [
//     PackageModel(
//       selected: true,
//       text: "Bike",
//       image: "${imagePath}order/bike.png",
//     ),
//     PackageModel(
//       selected: false,
//       text: "Car",
//       image: "${imagePath}order/car.png",
//     ),
//     PackageModel(
//       selected: false,
//       text: "Truck",
//       image: "${imagePath}order/truck.png",
//     )
//   ];
//
//   List<DeliveryTimeModel> deliveryTimeList = [
//     DeliveryTimeModel(
//         selected: true, text: "(1 -2 days)", mainText: "Standard Delivery"),
//     DeliveryTimeModel(
//         selected: true, text: "(Same day)", mainText: "Express Delivery"),
//   ];
//
//   @override
//   void initState() {
//     sampleData.add(new RadioModel(
//         isSelected: true, button: Colors.black, text: "Immediately"));
//     sampleData.add(new RadioModel(
//         isSelected: false,
//         button: Color(0xffFEB816),
//         text: "Scheduled for later"));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: kBackground,
//       appBar: kAppBar("Create Order", onPress: ()=> pop(context)),
//       body: SafeArea(
//         child: Column(
//           children: [
//             IconStepper(
//               enableStepTapping: false,
//               icons: [
//                 Icon(Icons.supervised_user_circle),
//                 Icon(Icons.flag),
//                 Icon(Icons.access_alarm),
//               ],
//
//               // activeStep property set to activeStep variable defined above.
//               activeStep: activeStep,
//
//               // This ensures step-tapping updates the activeStep.
//               onStepReached: (index) {
//                 setState(() {
//                   activeStep = index;
//                 });
//               },
//             ),
//             SizedBox(height: 20,),
//             Expanded(child: headerText()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget senderWidget() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: ListView(
//         children: [
//           CustomTextField(
//             header: "Sender’s Name",
//             hint: "John Doe",
//             type: FieldType.text,
//             validator: (v) {
//               if (v.isEmpty) {
//                 //Todo validate first and last name
//                 return "Name is Required";
//               }
//               sendersName = v;
//               return null;
//             },
//           ),
//           CustomTextField(
//             header: "Sender’s Address",
//             hint: "Input Address",
//             type: FieldType.text,
//             validator: (v) {
//               if (v.isEmpty) {
//
//                 return "Address is Required";
//               }
//               senderAddress = v;
//               return null;
//             },
//           ),
//           CustomTextField(
//             header: "Sender’s Phone Number",
//             hint: "08065083711",
//             type: FieldType.phone,
//             textInputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//               new LengthLimitingTextInputFormatter(11),
//             ],
//             validator: (v) {
//               if (v.isEmpty) {
//                 return "Phone is Required";
//               }
//               senderPhone = v;
//               return null;
//             },
//           ),
//           CustomTextField(
//             header: "What are you sending",
//             hint: "Input Address",
//             type: FieldType.text,
//             validator: (v) {
//               if (v.isEmpty) {
//
//                 return "Field is Required";
//               }
//               senderSending = v;
//               return null;
//             },
//           ),
//           SizedBox(
//             height: 1.0 * SizeConfig.heightMultiplier,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Package Size",
//                   style: TextStyle(
//                       color: kTitleTextfieldColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 1.7 * SizeConfig.textMultiplier)),
//               SizedBox(height: 8),
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: packageList.asMap().keys.toList().map((index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           packageList.forEach((element) {
//                             element.selected = false;
//                           });
//                         });
//                         packageList[index].selected = true;
//                       },
//                       child: ItemBox(
//                           text: packageList[index].text,
//                           image: packageList[index].image,
//                           selected: packageList[index].selected),
//                     );
//                   }).toList()),
//             ],
//           ),
//           SizedBox(
//             height: 2.5 * SizeConfig.heightMultiplier,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Delivery Type",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: deliveryList.asMap().keys.toList().map((index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           deliveryList.forEach((element) {
//                             element.selected = false;
//                           });
//                         });
//                         deliveryList[index].selected = true;
//                       },
//                       child: DeliveryType(
//                           text: deliveryList[index].text,
//                           image: deliveryList[index].image,
//                           selected: deliveryList[index].selected),
//                     );
//                   }).toList()),
//             ],
//           ),
//           SizedBox(
//             height: 2.5 * SizeConfig.heightMultiplier,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Delivery Time",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//
//               Row(
//                 children: [
//                   Expanded(
//                       child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               standard = true;
//                               timeSelectedExpress = false;
//                             });
//                           },
//                           child: DeliveryTime(
//                             text: deliveryTimeList[0].text,
//                             mainText: deliveryTimeList[0].mainText,
//                             selected: standard,
//                           ))),
//                   SizedBox(width: 8),
//                   Expanded(
//                       child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               standard = false;
//                               timeSelectedExpress = true;
//                             });
//                           },
//                           child: DeliveryTime(
//                             text: deliveryTimeList[1].text,
//                             mainText: deliveryTimeList[1].mainText,
//                             selected: timeSelectedExpress,
//                           )))
//                 ],
//               )
//
//             ],
//           ),
//           SizedBox(
//             height: 2.5 * SizeConfig.heightMultiplier,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Pick Up Time",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                       child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               scheduleLater = false;
//                               sampleData[0].isSelected = true;
//                               sampleData[1].isSelected = false;
//                             });
//                           },
//                           child: ColorSelectorItem(
//                             items: sampleData[0],
//                           ))),
//                   SizedBox(width: 8),
//                   Expanded(
//                       child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               scheduleLater = true;
//                               sampleData[1].isSelected = true;
//                               sampleData[0].isSelected = false;
//                             });
//                           },
//                           child: ColorSelectorItem(
//                             items: sampleData[1],
//                           ))),
//                 ],
//               ),
//               scheduleLater
//                   ? CustomTextField(
//                       readOnly: true,
//                       prefix: Icon(
//                         Icons.calendar_today_outlined,
//                         color: kTitleTextfieldColor,
//                       ),
//                       hint: "Select Date and Time",
//                       textEditingController: _scheduleController,
//                       onTap: () async {
//                         var date = await selectDate(context);
//                         if (date != null) {
//                           setState(() {
//                             _scheduleDate = dateFormat.format(date);
//                             _scheduleController.text = _scheduleDate;
//                             // _startdatePicked = true;
//                           });
//                         }
//                       },
//                     )
//                   : SizedBox()
//             ],
//           ),
//           SizedBox(
//             height: 4.5 * SizeConfig.heightMultiplier,
//           ),
//           CustomButton(
//               text: "Next",
//               type: ButtonType.outlined,
//               textColor: Colors.white,
//               onPressed: () {
//                 if (activeStep < upperBound) {
//                   setState(() {
//                     activeStep++;
//                   });
//                 }
//               }),
//           SizedBox(
//             height: 4.5 * SizeConfig.heightMultiplier,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget receiverWidget(){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: ListView(
//       children: [
//         CustomTextField(
//           header: "Receiver’s Name",
//           hint: "John Doe",
//           type: FieldType.text,
//           validator: (v) {
//             if (v.isEmpty) {
//               return "Name is Required";
//             }
//             receiverName = v;
//             return null;
//           },
//         ),
//         CustomTextField(
//           header: "Receiver’s Address",
//           hint: "Input Address",
//           type: FieldType.text,
//           validator: (v) {
//             if (v.isEmpty) {
//
//               return "Address is Required";
//             }
//             receiverAddress = v;
//             return null;
//           },
//         ),
//         CustomTextField(
//           header: "Receiver’s Phone Number",
//           hint: "08065083711",
//           type: FieldType.phone,
//           textInputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             new LengthLimitingTextInputFormatter(11),
//           ],
//           validator: (v) {
//             if (v.isEmpty) {
//
//               return "Phone is Required";
//             }
//             receiverPhone = v;
//             return null;
//           },
//         ),
//
//         Container(
//           child: CustomTextField(
//             header: "Additional Information",
//             hint: "Additional Information...",
//             maxLines: 10,
//             maxLength: 300,
//             minLines: 5,
//             type: FieldType.multiline,
//             validator: (v) {
//               if (v.isEmpty) {
//                 //Todo validate first and last name
//                 return "Name is Required";
//               }
//               receiverAddInfo = v;
//               return null;
//             },
//           ),
//         ),
//         SizedBox(
//           height: 4.5 * SizeConfig.heightMultiplier,
//         ),
//         CustomButton(
//             text: "Next",
//             type: ButtonType.outlined,
//             textColor: Colors.white,
//             onPressed: () {
//               if (activeStep < upperBound) {
//                 setState(() {
//                   activeStep++;
//                 });
//               }
//             }),
//         SizedBox(
//           height: 4.5 * SizeConfig.heightMultiplier,
//         ),
//       ],
//       ),
//     );
//   }
//
//
//   Widget reviewWidget(){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: ListView(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Sender’s Info",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//                 Container(
//
//                   padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                 decoration: BoxDecoration(
//                     color: blue.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Emmanuel Bassey", style: kBold700.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//
//                           IconButton(icon: Icon(Icons.edit, color: Colors.black, size: 15,),)
//                         ],
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width/2,
//                           child: Text("8, Idowu Taylor Street, Victoria Island Lagos, Nigeria", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                       SizedBox(height: 8,),
//
//                       Text("+234 123 456 789",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                     ],
//                   ),
//                 )
//             ],
//           ),
//
//           SizedBox(height: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Receiver Info",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//               Container(
//
//                 padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                 decoration: BoxDecoration(
//                     color: blue.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Bayo Alawaiye", style: kBold700.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//
//                         IconButton(icon: Icon(Icons.edit, color: Colors.black, size: 15,),)
//                       ],
//                     ),
//                     Container(
//                         width: MediaQuery.of(context).size.width/2,
//                         child: Text("8, Idowu Taylor Street, Victoria Island Lagos, Nigeria", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                     SizedBox(height: 8,),
//
//                     Text("+234 123 456 789",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                   ],
//                 ),
//               )
//             ],
//           ),
//
//
//           SizedBox(height: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Package Info",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//               Container(
//
//                 padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                 decoration: BoxDecoration(
//                     color: blue.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Bike Delivery", style: kBold700.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//
//                         IconButton(icon: Icon(Icons.edit, color: Colors.black, size: 15,),)
//                       ],
//                     ),
//                     Container(
//                         width: MediaQuery.of(context).size.width/2,
//                         child: Text("Bag of Shoes", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                     SizedBox(height: 8,),
//
//                     Text("Standard Delivery  (1-2days)",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                   ],
//                 ),
//               )
//             ],
//           ),
//
//
//           SizedBox(height: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Pickup Time",
//                 style: TextStyle(
//                     color: kTitleTextfieldColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 1.7 * SizeConfig.textMultiplier),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 20),
//                 decoration: BoxDecoration(
//                     color: blue.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: Text("Bike Delivery", style: kBold500.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//               ),
//
//               SizedBox(
//                 height: 4.5 * SizeConfig.heightMultiplier,
//               ),
//               CustomButton(
//                   text: "Next",
//                   type: ButtonType.outlined,
//                   textColor: Colors.white,
//                   onPressed: () {
//                     if (activeStep < upperBound) {
//                       setState(() {
//                         // activeStep++;
//                       });
//                     }
//                   }),
//               SizedBox(
//                 height: 4.5 * SizeConfig.heightMultiplier,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget headerText() {
//     switch (activeStep) {
//       case 0:
//         return senderWidget();
//
//       case 1:
//         return receiverWidget();
//
//       case 2:
//         return reviewWidget();
//
//       default:
//         return Container();
//     }
//   }
//   //
//   // Widget nextButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Increment activeStep, when the next button is tapped. However, check for upper bound.
//   //       if (activeStep < upperBound) {
//   //         setState(() {
//   //           activeStep++;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Next'),
//   //   );
//   // }
//   //
//   // /// Returns the previous button.
//   // Widget previousButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
//   //       if (activeStep > 0) {
//   //         setState(() {
//   //           activeStep--;
//   //         });
//   //       }
//   //     },
//   //     child: Text('Prev'),
//   //   );
//   // }
// }

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/services/LocationService/locationServices.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../viewModel/sendPackageViewModel.dart';
import '../widget/auto_complete_field.dart';

class EnterAddress extends StatefulWidget {
  final bool fromReceiver;
  const EnterAddress({Key? key, this.fromReceiver = false}) : super(key: key);

  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  bool applyCoupon = false;
  int selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SendPackageViewModel? sendPackageViewModel;

  int? _expiryYear;

  LocationService locationService = LocationService();

  bool receiver = false;
  @override
  void initState() {
    receiver = widget.fromReceiver;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel = Provider.of<SendPackageViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () => pop(context)),
        title: Text(
          "Enter Address",
          style: kBold700.copyWith(
              color: Colors.black, fontSize: 2.2 * SizeConfig.textMultiplier),
        ),
        backgroundColor: Colors.white,
        bottom: BottomApp(
          fromReceiver: receiver,
        ),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              children: [
                receiver
                    ? const SizedBox()
                    : InkWell(
                        onTap: () async {
                          sendPackageViewModel!.getCurrrent();
                          pop(
                            context,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset("${imagePath}order/target.png"),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Choose Current location",
                                style: kBold500.copyWith(
                                    fontSize: 1.9 * SizeConfig.textMultiplier),
                              )
                            ],
                          ),
                        ),
                      )
              ],
            )),
      ),
    );
  }
}

class BottomApp extends StatefulWidget with PreferredSizeWidget {
  final bool? fromReceiver;
  const BottomApp({Key? key, this.fromReceiver}) : super(key: key);

  @override
  _BottomAppState createState() => _BottomAppState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}

class _BottomAppState extends State<BottomApp> {
  SendPackageViewModel? sendPackageViewModel;
  TextEditingController controller = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    // _controller.addListener(onChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendPackageViewModel = Provider.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Column(
        children: [
          AutoCompleteField(
            fromReceiver: widget.fromReceiver!,
            showSavedAddresses: false,
            textStyle: kBold500.copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }
}
