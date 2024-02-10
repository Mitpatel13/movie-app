import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/data/models/changepasswordmodel.dart';
import 'package:shinestreamliveapp/ui/onboarding/welcome_screen.dart';
import '../../cubit_bloc/login_cubit.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends BaseScreen<ChangePassword> {
  TextEditingController passController = TextEditingController();
  late List<ChangePasswordModel> changePassModel = [];
  bool passError = false;
  late String mobno;

  var loginCubit = getIt<LoginCubit>();

  @override
  void initState() {
    mobno = prefs.getString(SharedConstants.mobileNumber) ?? "";
    print("MOBILE NO FROM LOCALE $mobno");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard when tapped outside of text field
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoaded) {
              changePassModel = state.response;
              if (changePassModel[0].msg.contains("Successfully")) {
                print("printing mob no");
                print(mobno);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                );
              }
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top:MediaQuery.sizeOf(context).height/3.h),
                  child: Center(
                    child: Text(
                      "Shine Stream Live - Change Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontFamilyConstants.interBold,
                        fontSize: FontSizeConstants.size28,
                        color: ColorConstantss.red,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.all(15.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StreamBuilder<bool>(
                            stream: loginCubit.passStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                passError = snapshot.data!;
                              }
                              return TextFieldComponent(
                                prodNameController: passController,
                                hintText: "Enter New Password*",
                                errorText: "Enter a valid Password",
                                errorTextShow: passError,
                                onchange: (value) {
                                  loginCubit.validatePassword(value);
                                },
                                inputtype: [
                                  LengthLimitingTextInputFormatter(15),
                                ],
                                textInputType: TextInputType.name,
                              );
                            },
                          ),
                          SizedBox(
                            height: systemHeight(0.6, context),
                          ),
                          CustomButton.getButton(
                            "Submit",
                            ColorConstantss.white,
                            ColorConstantss.red,
                            systemWidth(95, context),
                                () {
                              if (passController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please Enter New Password"),
                                  ),
                                );
                              } else if (passController.text.length < 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Password length should be min 8"),
                                  ),
                                );
                              } else if (mobno.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                FormData jsonBody = FormData.fromMap({
                                  "mobile_no": mobno,
                                  "password": passController.text
                                });
                                loginCubit.changePassword(jsonBody, context);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
