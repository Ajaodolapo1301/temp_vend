import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/GlobalState/appState.dart';
import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../viewModel/profileViewModel.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  ProfileState? profileState;
  LoginState? loginState;
  final _formKey = GlobalKey<FormState>();
  AppState? appState;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileState = Provider.of<ProfileState>(context);
    loginState = Provider.of<LoginState>(context);
    appState = Provider.of<AppState>(context);

    return LoadingOverlayWidget(
      loading: profileState!.busy,
      child: Scaffold(
        appBar: const CustomAppBar(label: "Report", showAction: false),

        // kAppBar("Report", onPress: ()=> pop(context), showAction: false),

        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.5 * SizeConfig.heightMultiplier,
                        ),
                        Container(
                          // height: 400,
                          child: CustomTextField(
                            textEditingController: controller,
                            header: "Report the issues you are facing",
                            hint: "Additional Information...",
                            maxLines: 10,
                            minLines: 10,
                            maxLength: 1000,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            type: FieldType.multiline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.5 * SizeConfig.heightMultiplier,
                  ),
                  CustomButton(
                      text: "Send Report",
                      type: ButtonType.outlined,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendReport();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendReport() async {
    var result = await profileState!
        .reportIssues(message: controller.text, token: loginState!.user.token);
    result.fold(
        (l) => kShowSnackBar(context, l.props.first.toString()),
        (r) => appState!.successDialog(context, r, () {
              pop(context);
              pop(context);
            }));
  }
}
