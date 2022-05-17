import 'package:after_layout/after_layout.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/styles/fontSize.dart';
import '../../authentication/viewModel/loginState.dart';
import '../../sendPackage/pages/create_order.dart';
import '../model/myOrderModel.dart';
import '../viewModel/myOrderViewModel.dart';
import '../widget/orderWidget.dart';
import 'orderInformation.dart';

const double tabBarItemsHeight = 30;

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder>
    with TickerProviderStateMixin, AfterLayoutMixin<MyOrder> {
  LoginState? loginState;
  MyOrderViewModel? myOrderState;
  bool isPending = false;
  TabController? _tabController;
  List<MyOrderModel> _myCompletedOrder = [];
  List<MyOrderModel> _myPendingOrder = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myOrderState = Provider.of<MyOrderViewModel>(context);
    loginState = Provider.of<LoginState>(context);
    return Scaffold(
      // appBar: kAppBar("My Orders",
      //     onPress: () => pop(context), showAction: false, showLead: false),

      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                height: tabBarItemsHeight,
                child: PreferredSize(
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: kTitleTextfieldColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BubbleTabIndicator(
                      indicatorHeight: 28.0,
                      indicatorRadius: 5,
                      indicatorColor: primaryColor,
                      tabBarIndicatorSize: TabBarIndicatorSize.label,
                    ),
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          'Ongoing',
                          style: kBold400.copyWith(
                              fontSize: fourteen, color: complementary),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                          style: kBold400.copyWith(
                              fontSize: fourteen, color: complementary),
                        ),
                      ),
                    ],
                  ),
                  preferredSize: const Size.fromHeight(30.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    RefreshIndicator(
                      onRefresh: getPendingOrderPull,
                      child: Builder(builder: (context) {
                        if (isPending) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else if (myOrderState?.myOrder == null) {
                          return const Center(child: Text("An error Occured"));
                        } else if (myOrderState!.myOrder.isEmpty) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "${imagePath}order/noOrder.png"),
                                    SizedBox(
                                      height: 5 * SizeConfig.heightMultiplier,
                                    ),
                                    Text(
                                      "No Active Order",
                                      style: kBold700.copyWith(
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return orderWidget(
                                    _myPendingOrder[index], false, () {
                                  pushTo(
                                      context,
                                      OrderInformation(
                                        orderModel: _myPendingOrder[index],
                                        completed: false,
                                      ));
                                });
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: _myPendingOrder.length);
                        }
                      }),
                    ),
                    RefreshIndicator(
                      onRefresh: pull2,
                      child: Builder(builder: (context) {
                        bool isLoading = false;
                        if (isLoading) {
                          return const Center(
                              child: const CupertinoActivityIndicator());
                        } else if (_myCompletedOrder.isEmpty) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "${imagePath}order/noOrder.png"),
                                    SizedBox(
                                      height: 5 * SizeConfig.heightMultiplier,
                                    ),
                                    Text(
                                      "No Completed Order",
                                      style: kBold700.copyWith(
                                          fontSize: 2.2 *
                                              SizeConfig.textMultiplier),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return orderWidget(
                                    _myCompletedOrder[index], true, () {
                                  pushTo(
                                      context,
                                      OrderInformation(
                                        orderModel: _myCompletedOrder[index],
                                        completed: true,
                                      ));
                                });
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: _myCompletedOrder.length);
                        }
                      }),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          pushTo(context, CreateOrder());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: complementary,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getPendingOrder();
    getCompleted();
  }

  getPendingOrder() async {
    setState(() {
      isPending = true;
    });
    myOrderState!
        .getMyOrders(filtered_by: "active", token: loginState?.user.token)
        .then((value) {
      setState(() {
        isPending = false;
      });
      value.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
        _myPendingOrder = r as List<MyOrderModel>;
      });
    });
  }

  Future getPendingOrderPull() async {
    myOrderState
        !.getMyOrders(filtered_by: "active", token: loginState!.user.token)
        .then((value) {
      value.fold(
          (l) => kShowSnackBar(context, l.props.first.toString()), (r) {});
    });
  }

  Future pull2() async {
    await getCompleted();
  }

  getCompleted() async {
    myOrderState
        !.getMyOrders(filtered_by: "completed", token: loginState!.user.token)
        .then((value) {
      value.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
        setState(() {
          _myCompletedOrder = r as  List<MyOrderModel>;
        });
      });
    });
  }
}
