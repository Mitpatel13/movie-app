import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/payment/payment_cubit.dart';
import 'package:shinestreamliveapp/ui/dashboard/homescreen.dart';
import 'package:shinestreamliveapp/ui/payment/select_payment_method.dart';

import '../../data/models/planmodel.dart';
import '../../data/models/tokenModel.dart';
import '../../di/locator.dart';
import '../../payment_library/paytm_payment/all_in_one_for_paytm.dart';
import '../../utils/color_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/app_bar_components.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends BaseScreen<Payment> {
  String result = "";
  late TokenModel tokenModel;
  List<PlanModel> planModel = [];
  var paymentCubit = getIt<PaymentCubit>();

  @override
  void initState() {
    paymentCubit.planDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
        isLeading: true,

          SizedBox(),(){Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }),
      body:
      BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {

            if (state is TokenLoaded) {
              tokenModel = state.response;
              print(tokenModel.res.body.txnToken);

              try {
                var response = AllInOneSdk.startTransaction(
                    "CDHMjd82751472977989",
                    tokenModel.orderId,
                    // "100",
                    tokenModel.amount.toString(),
                    tokenModel.res.body.txnToken,
                    "",
                    false,
                    false);
                response.then((value) {
                  print(value);
                  print("Printing the value in the response API");
                  print(value);
                  setState(() {
                    result = value.toString();
                    final snackBar = SnackBar(
                      content: Text(result.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }).catchError((onError) {
                  if (onError is PlatformException) {
                    final snackBar = SnackBar(
                      content: Text(onError.toString()),
                    );
                    Navigator.pop(context);


                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    setState(() {
                      print("Printing the result error in the response API");
                      result = onError.toString();
                      final snackBar = SnackBar(
                        content: Text(result.toString()),
                      );
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    });
                  }
                });
              } catch (err,t) {
                Logger().e(err);
                Logger().e(t);

              }
            }
            if(state is TokenError){
              Logger().d("TOKEN ERROR ${state}");
              Navigator.pop(context);
            }
            if(state is PlanError){
              Logger().d("TOKEN ERROR ${state}");
              Navigator.pop(context);
            }
            // TODO: implement listener
          },
          child: BlocBuilder<PaymentCubit, PaymentState>(

            builder: (context, state) {
              if(state is PlanLoading){
                return Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CupertinoActivityIndicator(color: ColorConstantss.red,radius: 15,animating: true),)
                ],);
              }
              else if(state is PlanLoaded)
                {
                  planModel = state.response;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(int i = 0; i < planModel.length; i++)
                          ...[
                            design(planModel[i]),
                            SizedBox(
                              height: 15,
                            )
                          ],

                        SizedBox(
                          height: 10,

                        ),

                      ],
                    ),
                  );
                }
              // else if(state is PlanError){
              //    Navigator.pop(context);
              //    return Container()
              // }
              else{
                return Container();
              }
            },
          )
      ),
    );
  }

  design(PlanModel planModel) {
    return InkWell(
      onTap: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userID =prefs.getString("${SharedConstants.udid}");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPaymentMethodScreen(map:planModel),));
        //
        await paymentCubit.tokenApi(userID.toString(), planModel.planId, planModel.planAmount);
        // Navigator.pop(context);
      },
      child: Center(
        child: Container(

          decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepOrange
                  ]
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(2.0, 2.0)
                )
              ]
          ),
          child: Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plan Name :" + planModel.planName,
                    style: TextStyle(
                      fontFamily: 'GeoBook',
                      fontSize: 18,
                      color: ColorConstantss.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    "Plan Days :" + planModel.planDays,
                    style: TextStyle(
                      fontFamily: 'GeoBook',
                      fontSize: 18,
                      color: ColorConstantss.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Plan Amount :" + planModel.planAmount,
                    style: TextStyle(
                      fontFamily: 'GeoBook',
                      fontSize: 18,
                      color: ColorConstantss.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(

                          width: 135,
                          height: 50,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.pink,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black45,
                          ),

                          child: Center(
                            child: Text("Subscribe", style: TextStyle(
                              fontFamily: 'GeoBook',
                              fontSize: 18,
                              color: ColorConstantss.white,
                              fontWeight: FontWeight.w400,
                            ),),
                          )
                      )
                  ),

                ],
              )),
        ),
      ),
    );
  }
}
