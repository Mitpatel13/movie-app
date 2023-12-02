import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/otp_cubit/otp_cubit.dart';
import 'package:shinestreamliveapp/data/models/changepasswordmodel.dart';
import 'package:shinestreamliveapp/ui/onboarding/welcome_screen.dart';
import '../../cubit_bloc/login_cubit.dart';
import '../../data/models/forgotpasswordmodel.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/font_family_constants.dart';
import '../../utils/font_size_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/bottomnavbar.dart';
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
    mobno=prefs.getString(SharedConstants.mobileNumber) ?? "";
    print("MOBILE NO FROM LOCALE${mobno}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
            body: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if(state is LoginLoaded){
                  changePassModel = state.response;
                  if(changePassModel[0].msg.contains("Successfully"))
                    {
                      print("printing mob no");
                      print(mobno);

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),), (route) => false);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigation(index: 0)),(route) => false,);
                    }
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: systemHeight(5, context),
                    ),
                    Image.asset("assets/splashLogo.png", height: 165,),
                    Container(
                        margin: EdgeInsets.all(systemHeight(3, context)),
                        child: Center(
                          child: Text(
                            "Shine Stream Live - Change Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: FontFamilyConstants.interBold,
                                fontSize: FontSizeConstants.size28,
                                color: ColorConstantss.red),
                          ),
                        )
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                        
                        }, builder: (context, state) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              StreamBuilder(
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
                                        loginCubit.validatePassword(
                                            value);
                                      },
                                      inputtype: [],
                                      textInputType: TextInputType.name,
                                    );
                                  }),
                              SizedBox(
                                height: systemHeight(0.6, context),
                              ),


                              CustomButton.getButton(
                                  "Submit", ColorConstantss.white,
                                  ColorConstantss.red,
                                  systemWidth(95, context), () {
                                    if(passController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                      Text("Please Enter New Password")));
                                    }
                                    else if(passController.text.length <8){
                                      // passError =true;
                                      // setState(() {
                                      //
                                      // });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                      Text("Password length should be min 8")));
                                    }
                                    else if(mobno!="" && passController.text.isNotEmpty)
                                      {
                                        FormData jsonBody = new FormData.fromMap({ "mobile_no": mobno,"password":passController.text });
                                        loginCubit.changePassword(jsonBody,context);

                                      }

                              }
                              ),


                            ],
                          ),)
                        ,
                      );
                    }),
                  ],
                ),
              ),
            )
        ));
  }
}
