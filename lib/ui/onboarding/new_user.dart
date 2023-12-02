import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/newuser_cubit/new_user_cubit.dart';
import 'package:shinestreamliveapp/ui/onboarding/otpscreen.dart';
import 'package:shinestreamliveapp/ui/onboarding/welcome_screen.dart';

import '../../cubit_bloc/otp_cubit/otp_cubit.dart';
import '../../data/models/otpmodel.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/button_widget.dart';
import '../widget_components/text_field_components.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends BaseScreen<NewUser> {
  var newUserCubit = getIt<NewUserCubit>();
  var otpCubit = getIt<OtpCubit>();
  late TwoFactorOtpModel otpModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConController = TextEditingController();

  bool nameError = false;
  bool phoneError = false;
  bool emailError = false;
  bool passError = false;
  bool passConError = false;

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: systemHeight(5, context),
              ),
              Image.asset("assets/splashLogo.png",height: 165,),
              Container(
                  margin: EdgeInsets.all(systemHeight(3, context)),
                  child: Center(
                    child: Text(
                      "Shine Stream Live - New User",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: FontFamilyConstants.interBold,
                          fontSize: FontSizeConstants.size28,
                          color: ColorConstantss.red),
                    ),
                  )),
              BlocConsumer<NewUserCubit, NewUserState>(
                  listener: (context, state) {
                if (state is RegisterLoading) {
                  //LoaderWidget.showProgressIndicatorAlertDialog(context);
                  CircularProgressIndicator();
                } else if(state is RegisterLoaded){

                  otpCubit.otpLoad(phoneController.text);
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
                            stream: newUserCubit.nameStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                nameError = snapshot.data!;
                              }
                              return TextFieldComponent(
                                prodNameController: nameController,
                                hintText: "Enter Name*",
                                errorText: "Enter a valid Name",
                                errorTextShow: nameError,
                                onchange: (value) {
                                  newUserCubit.validateName(value.trim());
                                },
                                inputtype: [],
                                textInputType: TextInputType.name,
                              );
                            }),
                        SizedBox(
                          height: systemHeight(0.6, context),
                        ),
                        StreamBuilder(
                            stream: newUserCubit.phoneStream,
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
                                  newUserCubit.validatePhoneNumber(value.trim());
                                },
                                inputtype: [],
                                textInputType: TextInputType.number,
                              );
                            }),
                        SizedBox(
                          height: systemHeight(0.6, context),
                        ),
                        StreamBuilder(
                            stream: newUserCubit.emailStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                emailError = snapshot.data!;
                              }
                              return TextFieldComponent(
                                prodNameController: emailController,
                                hintText: "Enter Email*",
                                errorText: "Enter a valid Email",
                                errorTextShow: emailError,
                                onchange: (value) {
                                  newUserCubit.validateEmail(value.trim());
                                },
                                inputtype: [],
                                textInputType: TextInputType.name,
                              );
                            }),
                        SizedBox(
                          height: systemHeight(0.6, context),
                        ),
                        StreamBuilder(
                            stream: newUserCubit.passStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                passError = snapshot.data!;
                              }
                              return TextFieldComponent(
                                prodNameController: passController,
                                hintText: "Enter Password*",
                                errorText: "Enter a valid Password",
                                errorTextShow: passError,
                                onchange: (value) {
                                  newUserCubit.validatePassword(value.trim());
                                },
                                inputtype: [],
                                textInputType: TextInputType.name,
                              );
                            }),
                        SizedBox(
                          height: systemHeight(0.6, context),
                        ),
                        StreamBuilder(
                            stream: newUserCubit.passConStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                passConError = snapshot.data!;
                              }
                              return TextFieldComponent(
                                prodNameController: passConController,
                                hintText: "Enter Confirm Password*",
                                errorText: "Password Mismatch",
                                errorTextShow: passConError,
                                onchange: (value) {
                                  //newUserCubit.valid(value.trim());
                                },
                                inputtype: [],
                                textInputType: TextInputType.name,
                              );
                            }),
                        CustomButton.getButton("Register", ColorConstantss.white,
                            ColorConstantss.red, systemWidth(95, context), () {

                          if (phoneController.text.isNotEmpty &&
                              passController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              nameController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {

                            if (!phoneError && !passError && !emailError && !passConError && !nameError) {
                              FormData jsonBody = new FormData.fromMap({ "user_name": nameController.text,
                                "email": emailController.text,"mobile_no":phoneController.text,"password":passController.text});
                              newUserCubit.register(jsonBody,context);
                            }
                          } else {
                            newUserCubit.validatePassword(passController.text);
                            newUserCubit.validateEmail(emailController.text);
                            newUserCubit.validatePhoneNumber(phoneController.text);
                            newUserCubit.validateName(nameController.text);
                          }
                        }),
                        SizedBox(
                          height: systemHeight(0.6, context),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Already registered, Sign-in Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: FontFamilyConstants.interBold,
                                    fontSize: FontSizeConstants.size18,
                                    color: ColorConstantss.red),
                              ),
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
