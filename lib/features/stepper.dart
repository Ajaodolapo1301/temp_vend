// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:primhex/core/constants/textStyleConstants.dart';
// import 'package:primhex/core/features/sendPackage/model/delivery_time_model.dart';
// import 'package:primhex/core/features/sendPackage/model/package_model.dart';
// import 'package:primhex/core/features/sendPackage/model/radioModel.dart';
// import 'package:primhex/core/features/sendPackage/widget/delivery_time.dart';
// import 'package:primhex/core/features/sendPackage/widget/delivery_type.dart';
// import 'package:primhex/core/features/sendPackage/widget/item_box.dart';
// import 'package:primhex/core/features/sendPackage/widget/order_Info.dart';
// import 'package:primhex/core/features/sendPackage/widget/radioWidget.dart';
// import 'package:primhex/core/features/sendPackage/widget/receiver_info.dart';
//
// import 'package:primhex/core/utils/function/bottom_sheet/bottom_sheet.dart';
// import 'package:primhex/core/utils/function/timePicker.dart';
//
// import 'package:primhex/core/utils/navigation/navigator.dart';
// import 'package:primhex/core/utils/sizeConfig/sizeConfig.dart';
// import 'package:primhex/core/utils/styles/color_utils.dart';
// import 'package:primhex/core/utils/widgets/custom_button.dart';
// import 'package:primhex/core/utils/widgets/custom_text_field.dart';
// import 'package:status_change/status_change.dart';
//
// class StepperPage extends StatefulWidget {
//   const StepperPage({Key key}) : super(key: key);
//
//   @override
//   _StepperPageState createState() => _StepperPageState();
// }
//
// class _StepperPageState extends State<StepperPage> {
//   int _processIndex = 0;
//   Pages pages = Pages.Order;
//   int upperBound = 2;
//   StepperType stepperType = StepperType.horizontal;
//   int activeStep = 2;
//   var sendersName;
//   var senderAddress;
//   var senderPhone;
//   var senderSending;
//   var packageSize;
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
//
//
//   List process = ["Order Info", "Receiver Info", "Review"];
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar:
//           kAppBar("Check Price", showLead: true, onPress: () => pop(context)),
//
//       body: SafeArea(
//         child: Container(
//           // padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               Container(
//                 height: 100,
//                 child: StatusChange.tileBuilder(
//                     theme: StatusChangeThemeData(
//                       direction: Axis.horizontal,
//                       connectorTheme:
//                           ConnectorThemeData(space: 1.0, thickness: 1.0),
//                     ),
//                     builder: StatusChangeTileBuilder.connected(
//                         itemWidth: (_) =>
//                             MediaQuery.of(context).size.width / process.length,
//                         nameWidgetBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               process[index],
//                               style: kBold500.copyWith(color: getColor(index, _processIndex)),
//                             ),
//                           );
//                         },
//                         indicatorWidgetBuilder: (_, index) {
//                           if (index <= _processIndex) {
//                             return GestureDetector(
//                                 onTap: (){
//                                   setState(() {
//
//                                     if (index == 0) {
//                                       _processIndex = 0;
//                                       pages = Pages.Order;
//                                     } else if (index == 1) {
//                                       _processIndex --;
//                                       pages = Pages.Receiver;
//                                     } else if (index == 2) {
//                                       _processIndex --;
//                                       pages = Pages.Review;
//                                     }
//                                   });
//                                 },
//                               child: DotIndicator(
//                                 size: 35.0,
//                                 color: Color(0xffEAEAEA),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(6.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: blue
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return  DotIndicator(
//                               size: 35.0,
//                               color: Color(0xffEAEAEA),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.white
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         lineWidgetBuilder: (index) {
//                           if (index > 0) {
//                             if (index == _processIndex) {
//                               final prevColor = getColor(index - 1, _processIndex);
//                               final color = getColor(index, _processIndex);
//                               var gradientColors;
//                               gradientColors = [
//                                 prevColor,
//                                 Color.lerp(prevColor, color, 0.5)
//                               ];
//                               return DecoratedLineConnector(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: gradientColors,
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return SolidLineConnector(
//                                 color: getColor(index, _processIndex),
//                               );
//                             }
//                           } else {
//                             return null;
//                           }
//                         },
//                         itemCount: process.length)),
//               ),
//               pages == Pages.Order
//                   ? SenderWidget(processIndex: _processIndex, onpress: (value){
//                     setState(() {
//                      var  v = value["index"];
//                      _processIndex = v;
//                         move(v: v,);
//                     });
//               },)
//                   : pages == Pages.Receiver
//                   ? ReceiverInfo(processIndex: _processIndex, onpress: (value){
//                 setState(() {
//                   var  v = value["index"];
//                   _processIndex = v;
//                     move(v: v);
//                 });
//               },)
//                   : reviewWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void move({v, }){
//     // Pages pages = Pages.Order;
//     if (v == 1) {
//       pages = Pages.Receiver;
//     } else if (v == 2) {
//       pages = Pages.Review;
//     } else if (v == 3) {
//       print("done");
//     }
//   }
//
//   Widget reviewWidget(){
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
//         child: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Sender’s Info",
//                   style: TextStyle(
//                       color: kTitleTextfieldColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 1.7 * SizeConfig.textMultiplier),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//
//                   padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                   decoration: BoxDecoration(
//                       color: blue.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
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
//                           width: MediaQuery.of(context).size.width/2,
//                           child: Text("8, Idowu Taylor Street, Victoria Island Lagos, Nigeria", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                       SizedBox(height: 8,),
//
//                       Text("+234 123 456 789",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//
//             SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Receiver Info",
//                   style: TextStyle(
//                       color: kTitleTextfieldColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 1.7 * SizeConfig.textMultiplier),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//
//                   padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                   decoration: BoxDecoration(
//                       color: blue.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Bayo Alawaiye", style: kBold700.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//
//                           IconButton(icon: Icon(Icons.edit, color: Colors.black, size: 15,),)
//                         ],
//                       ),
//                       Container(
//                           width: MediaQuery.of(context).size.width/2,
//                           child: Text("8, Idowu Taylor Street, Victoria Island Lagos, Nigeria", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                       SizedBox(height: 8,),
//
//                       Text("+234 123 456 789",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//
//
//             SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Package Info",
//                   style: TextStyle(
//                       color: kTitleTextfieldColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 1.7 * SizeConfig.textMultiplier),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//
//                   padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
//                   decoration: BoxDecoration(
//                       color: blue.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Bike Delivery", style: kBold700.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//
//                           IconButton(icon: Icon(Icons.edit, color: Colors.black, size: 15,),)
//                         ],
//                       ),
//                       Container(
//                           width: MediaQuery.of(context).size.width/2,
//                           child: Text("Bag of Shoes", style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),)),
//
//                       SizedBox(height: 8,),
//
//                       Text("Standard Delivery  (1-2days)",  style: kBold400.copyWith(fontSize: 1.4 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//
//
//             SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Pickup Time",
//                   style: TextStyle(
//                       color: kTitleTextfieldColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 1.7 * SizeConfig.textMultiplier),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 20),
//                   decoration: BoxDecoration(
//                       color: blue.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Text("Bike Delivery", style: kBold500.copyWith(fontSize: 1.9 * SizeConfig.textMultiplier, color: kTitleTextfieldColor),),
//                 ),
//
//                 SizedBox(
//                   height: 4.5 * SizeConfig.heightMultiplier,
//                 ),
//                 CustomButton(
//                     text: "Next",
//                     type: ButtonType.outlined,
//                     textColor: Colors.white,
//                     onPressed: () {
//                       print(_processIndex);
//                       setState(() {
//                         _processIndex++;
//                         if (_processIndex == 1) {
//                           pages = Pages.Receiver;
//                         } else if (_processIndex == 2) {
//                           pages = Pages.Review;
//                         } else if (_processIndex == 3) {
//                           print("done");
//                         }
//                       });
//                     }),
//                 SizedBox(
//                   height: 4.5 * SizeConfig.heightMultiplier,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // setState(() {
// // _processIndex++;
// // if (_processIndex == 1) {
// // pages = Pages.Receiver;
// // } else if (_processIndex == 2) {
// // pages = Pages.Review;
// // } else if (_processIndex == 3) {
// // print("done");
// // }
// // });
//
//
//
//
//
//
//
//
//
