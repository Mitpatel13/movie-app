import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shinestreamliveapp/ui/dashboard/homescreen.dart';
import 'package:shinestreamliveapp/ui/onboarding/forgotpassword.dart';

import '../../basescreen/base_screen.dart';
import '../../cubit_bloc/login_cubit.dart';
import '../../data/models/checkloginmodel.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/bottomnavbar.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';
import 'new_user.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends BaseScreen<WelcomeScreen> {
  void initState() {}
  late CheckLoginModel loginCheck;
  var loginCubit = getIt<LoginCubit>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //bool nameError = false;
  bool phoneError = false;
  bool passError = false;

  //bool phoneEditFlag = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: systemHeight(5, context),
          ),
          Image.asset("assets/splashLogo.png",height: 165),
          Container(
              margin: EdgeInsets.all(systemHeight(3, context)),
              child: Center(
                child: Text(
                  "Shine Stream Live - Sign-in",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: FontFamilyConstants.interBold,
                      fontSize: FontSizeConstants.size28,
                      color: ColorConstantss.red),
                ),
              )),
          BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
            if (state is LoginLoading) {
              // LoaderWidget.showProgressIndicatorAlertDialog(context);
              CircularProgressIndicator();
            } else if (state is LoginLoaded) {
              // LoaderWidget.removeProgressIndicatorAlertDialog(context);
              var loginCheck = state.response;
              final snackBar = SnackBar(
                content: Text(loginCheck[0].msg),
              );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              if (!loginCheck[0].msg.contains("does not match")) {
                prefs.setString(SharedConstants.mobileNumber, phoneController.text);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation(index: 0)));
              }
            } else if (state is LoginError) {
              // LoaderWidget.removeProgressIndicatorAlertDialog(context);
              var test = state.error;
              final snackBar = SnackBar(
                content: Text(test.toString()),
              );
              Logger().e(test);
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              // LoaderWidget.removeProgressIndicatorAlertDialog(context);
            }
          }, builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: loginCubit.phoneStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            phoneError = snapshot.data!;
                          }
                          return TextFieldComponent(
                            prodNameController: phoneController,

                            hintText: "Enter Mobile Number*",
                            errorText: "Enter a valid Number",
                            errorTextShow: phoneError,
                            onchange: (value) {
                              loginCubit.validatePhoneNumber(value.trim());
                            },
                            inputtype:[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                            textInputType: TextInputType.number,
                          );
                        }),
                    SizedBox(
                      height: systemHeight(0.6, context),
                    ),
                    StreamBuilder(
                        stream: loginCubit.passStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            passError = snapshot.data!;
                          }
                          return TextFieldComponent(
                            prodNameController: passController,
                            hintText: "Enter Your Password*",
                            errorText: "Enter a valid password",
                            errorTextShow: passError,
                            onchange: (value) {
                              loginCubit.validatePassword(value);
                            },
                            inputtype: [],
                            textInputType: TextInputType.visiblePassword,
                          );
                        }),
                    SizedBox(
                      height: systemHeight(0.6, context),
                    ),
                    CustomButton.getButton("LOG IN", ColorConstantss.white,
                        ColorConstantss.red, systemWidth(95, context), () {
                      // var jsonBody = {
                      //   "email":"9060060489",
                      //   "password":"123"
                      // };
                      FormData formData = new FormData.fromMap({
                        "email": phoneController.text,
                        "password": passController.text,
                      });

                      if (phoneController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        if (!phoneError && !passError) {
                          loginCubit.checkLogin(formData,context);
                        }
                      } else {
                        loginCubit.validatePassword(passController.text);
                        loginCubit.validatePhoneNumber(phoneController.text);
                      }
                    }),
                    SizedBox(
                      height: systemHeight(0.6, context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewUser(),
                                    ));
                                print("new user clicked");
                              },
                              child: Text(
                                '    New User    ',
                                style: TextStyle(
                                    fontFamily: FontFamilyConstants.interBold,
                                    fontSize: FontSizeConstants.size18,
                                    color: ColorConstantss.red),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.deepPurpleAccent,
                              thickness: 2,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassword(),
                                    ));
                                print("forgot password clicked");
                              },
                              child: Text(
                                '    Forgot Password   ',
                                style: TextStyle(
                                    fontFamily: FontFamilyConstants.interBold,
                                    fontSize: FontSizeConstants.size18,
                                    color: ColorConstantss.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    )));
  }
}
