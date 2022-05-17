import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/GlobalState/appState.dart';
import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_text_field.dart';
import '../../../core/widget/loading_overlay_widget.dart';
import '../../authentication/viewModel/loginState.dart';
import '../viewModel/profileViewModel.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> with AfterLayoutMixin<EditPage> {
  final _formKey = GlobalKey<FormState>();

  LoginState? loginState;
  AppState? appState;
  ProfileState? profileState;
  String? accountName;
  String? email;
  String? phone;
  bool isVisiblePassword = false;
  File? idFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    profileState = Provider.of<ProfileState>(context);
    appState = Provider.of<AppState>(context);
    // print(loginState.user.token);
    return LoadingOverlayWidget(
      loading: profileState?.busy,
      child: Scaffold(
        // appBar: kAppBar("Edit Profile",
        //     onPress: () => pop(context), showAction: false),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.4 * SizeConfig.heightMultiplier,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     _getFromGallery();
                          //   },
                          //   child: Container(
                          //     height: 12 * SizeConfig.heightMultiplier,
                          //     width: 26.1 * SizeConfig.widthMultiplier,
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: loginState!.user.profileImageUrl != null && idFile == null? NetworkImage(loginState!.user.profileImageUrl,)
                          //               : idFile == null &&
                          //                       loginState!
                          //                               .user.profileImageUrl ==
                          //                           null
                          //                   ? AssetImage(
                          //                       "$imagePath/wallet/emptyImage.png")
                          //                   : FileImage(idFile!),
                          //         ),
                          //         color: Colors.blue,
                          //         shape: BoxShape.circle),
                          //   ),
                          // ),
                          Positioned(
                              bottom: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  _getFromGallery();
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.camera_enhance_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            header: "Account Name",
                            hint: "John Doe",
                            textEditingController: nameController,
                            type: FieldType.text,
                            validator: (v) {
                              if (v!.isEmpty) {
                                //Todo validate first and last name
                                return "Name is Required";
                              }
                              accountName = v;
                              return null;
                            },
                          ),
                          CustomTextField(
                            header: "Email Address",
                            hint: "ajaodlp@xyz.com",
                            type: FieldType.text,
                            textEditingController: emailController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Email is required";
                              } else if (!EmailValidator.validate(
                                  value.replaceAll(" ", "").trim())) {
                                return "Email is invalid";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            header: "Phone Number",
                            hint: "08065083711",
                            textEditingController: phoneController,
                            type: FieldType.phone,
                            textInputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              new LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                          SizedBox(
                            height: 7.3 * SizeConfig.heightMultiplier,
                          ),
                          CustomButton(
                              text: "Update Profile",
                              type: ButtonType.outlined,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  updateProfile();
                                }
                              }),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile!.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      idFile = croppedImage;
      setState(() {});
    }
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (idFile != null) {
        upload();
      }
    });
  }

  void upload() async {
    var res = await profileState!
        .uploadimage(profile_image: idFile, token: loginState!.user.token);
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      appState!.successDialog(context, r, () {
        pop(context);
        pop(context);
        // pushReplacementTo(context, Home());
      });
    });
    getuser();
  }

  void updateProfile() async {
    var res = await profileState!.editprofile(
        token: loginState!.user.token,
        full_name: nameController.text,
        dob: "",
        gender: "",
        city: "",
        state: "",
        home_address: "");
    res.fold((l) => kShowSnackBar(context, l.props.first.toString()), (r) {
      appState!.successDialog(context, r, () {
        pop(context);
        // pop(context);
        // pushReplacementTo(context, Home());
      });
    });
    getuser();
  }

  void getuser() async {
    var res = await loginState!
        .getUser(token: loginState!.user.token, id: loginState!.user.id);
    res.fold((l) {
      kShowSnackBar(context, l.props.first.toString());
    }, (r) {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      nameController.text = loginState!.user.fullName!;
      emailController.text = loginState!.user.email!;
      phoneController.text = loginState!.user.phone!;
    });
  }
}
