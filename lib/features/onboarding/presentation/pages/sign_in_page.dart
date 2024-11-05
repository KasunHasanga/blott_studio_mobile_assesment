import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widget/app_text_field.dart';
import '../../../../config/constants.dart';
import '../../../../config/fonts.dart';
import '../controller/onboarding_controller.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/login';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKeySignIn = GlobalKey<FormState>();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  late OnBoardingController onBoardingController;

  @override
  void initState() {
    if (Get.isRegistered<OnBoardingController>()) {
      onBoardingController = Get.find();
    } else {
      onBoardingController = Get.put(OnBoardingController());
    }
    // Add listeners to both TextEditingControllers
    firstNameTextEditingController.addListener(_onTextChanged);
    lastNameTextEditingController.addListener(_onTextChanged);

    super.initState();
  }

  // Trigger UI update when text changes
  void _onTextChanged() {
    setState(() {});
  }

  bool isUserFillNamed() {
    return firstNameTextEditingController.text.length > 1 &&
        lastNameTextEditingController.text.length > 1;
  }

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isUserFillNamed()
            ? () {
                if (autoValidateMode != AutovalidateMode.always) {
                  setState(() {
                    autoValidateMode = AutovalidateMode.always;
                  });
                }
                if (formKeySignIn.currentState!.validate()) {
                  onBoardingController.saveUserInfo(
                      firstNameTextEditingController.text,
                      lastNameTextEditingController.text);
                }
              }
            : null,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isUserFillNamed()
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          child: Icon(
            Icons.navigate_next,
            size: 24,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Your legal name'.tr,
                textAlign: TextAlign.start,
                style: AppFonts.styleWithGilroyMediumText(
                    color: Theme.of(context).colorScheme.onSurface,
                    fSize: FontSizeValue.fontSize25),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'We need to know a bit about you so that we can create your account.'
                    .tr,
                textAlign: TextAlign.start,
                style: AppFonts.styleWithGilroyMediumText(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fSize: FontSizeValue.fontSize16),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: formKeySignIn,
                autovalidateMode: autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AppTextField(
                        labelText: 'First name'.tr,
                        textController: firstNameTextEditingController,
                        keyBoardType: TextInputType.text,
                        onValidate: (value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AppTextField(
                        labelText: 'Last name'.tr,
                        textController: lastNameTextEditingController,
                        keyBoardType: TextInputType.text,
                        onValidate: (value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
