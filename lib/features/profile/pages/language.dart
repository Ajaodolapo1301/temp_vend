import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../model/languageModel.dart';
import '../widget/languageWidget.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<LanguageModel> languageData = [];

  @override
  void initState() {
    languageData.add(LanguageModel(isSelected: true, text: "English"));
    languageData.add(LanguageModel(isSelected: false, text: "French"));
    languageData.add(LanguageModel(isSelected: false, text: "Spanish"));
    languageData.add(LanguageModel(isSelected: false, text: "German"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffE5E5E5
      // ),
      appBar: const CustomAppBar(label: "Report", showAction: true),

      // kAppBar("Language", onPress: ()=> pop(context), showAction: true),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.4 * SizeConfig.heightMultiplier,
              ),
              const Text("Select your preferred language"),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (languageData[index].text == "French") {
                          toast("Changing Language to French");
                          await context.setLocale(const Locale("fr"));
                        } else if (languageData[index].text == "Spanish") {
                          toast("Changing Language to Spanish");
                          await context.setLocale(const Locale("es"));
                        } else if (languageData[index].text == "German") {
                          toast("Changing Language to German");
                          await context.setLocale(const Locale("de"));
                        } else {
                          toast("Changing Language to English");
                          await context.setLocale(const Locale("en"));
                        }

                        setState(() {
                          languageData
                              .forEach((element) => element.isSelected = false);
                          languageData[index].isSelected = true;
                        });
                      },
                      child: LanguageWidget(
                        items: languageData[index],
                      ),
                    );
                  },
                  itemCount: languageData.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
