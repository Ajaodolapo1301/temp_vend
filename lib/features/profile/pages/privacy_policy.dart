import 'package:flutter/material.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/widget/loading_overlay_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final String lorem =
      "Lorem ipsum dolor sit amet, is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayWidget(
      loading: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          label: "Privacy Policy",
        ),

        // kAppBar("", onPress: ()=> pop(context), showAction: false),

        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.5 * SizeConfig.heightMultiplier,
                      ),
                      Text(lorem),
                      SizedBox(
                        height: 3.0 * SizeConfig.heightMultiplier,
                      ),
                      Text(lorem),
                      SizedBox(
                        height: 3.0 * SizeConfig.heightMultiplier,
                      ),
                      Text(lorem),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
