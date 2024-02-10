
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/cubit_bloc/payment/payment_cubit.dart';
import 'package:shinestreamliveapp/ui/newHome/homescreen.dart';
import 'package:shinestreamliveapp/utils/app_log.dart';

import '../../data/models/planmodel.dart';
import '../../data/models/tokenModel.dart';
import '../../data/repository/paymentrepository.dart';
import '../../di/locator.dart';
import '../../main.dart';
import '../../utils/color_constants.dart';
import '../../utils/shared_prefs.dart';
import '../widget_components/app_bar_components.dart';
import '../widget_components/bottomnavbar.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends BaseScreen<Payment> {
  String result = "";
  late TokenModel tokenModel;
  List<PlanModel> planModel = [];
  var paymentCubit = getIt<PaymentCubit>();
  var paymentRepo = getIt<PaymentRepository>();

  String paymentMethod = 'Unknown';


  @override
  void initState() {
    checkLocation();

    paymentCubit.planDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstant(
        isLeading: true,
(){Navigator.pop(context);
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }),
      body:
      BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {

            if (state is TokenLoaded) {
              tokenModel = state.response;
              print(tokenModel.res.body.txnToken);
              AppLog.d(tokenModel.res);

              try {
                var response = AllInOneSdk.startTransaction(
                    "CDHMjd82751472977989",
                    tokenModel.orderId,
                    tokenModel.amount.toString(),
                    tokenModel.res.body.txnToken,
                    "https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=${tokenModel.orderId}",
                    false,
                    false);
                response.then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(),));
                  if (value!['STATUS'] == 'TXN_SUCCESS') {
                    FormData jsonBody =  FormData.fromMap({
                      "TXNID": value['TXNID'],
                      "CURRENCY": value['CURRENCY'],
                      "CHECKSUMHASH": value['CHECKSUMHASH'],
                      "MID": value['MID'],
                      "ORDERID": value['ORDERID'],
                      "RESPCODE": value['RESPCODE'],
                      "RESPMSG": value['RESPMSG'],
                      "STATUS": value['STATUS'],
                      "TXNAMOUNT": value['TXNAMOUNT'],
                      "BANKTXNID": value['BANKTXNID'],
                    });
                    paymentRepo.callbackApiForPaytmResponse(jsonBody);
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ParentWidget(),));
                      prefs.setString(SharedConstants.subScription,'1');

                    });
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ParentWidget()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(),));


                    // Send the success response to the POST API
                  }
                  print(value);
                  AppLog.d("VALUE AFTER RESPONSE${value}");
                  AppLog.d("VALUE AFTER RESPONSE ==== ${response}");



                  setState(() {
                    result = value.toString();
                  });
                }).catchError((onError) {
                  if (onError is PlatformException) {
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Payment()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      AppLog.d(onError.details['CHECKSUMHASH']);
                      if (onError.message == 'User has not completed transaction.') {
                        FormData jsonBody =  FormData.fromMap({
                          "TXNID": onError.details['TXNID'],
                          "CURRENCY": onError.details['CURRENCY'],
                          "CHECKSUMHASH": onError.details['CHECKSUMHASH'],
                          "MID": onError.details['MID'],
                          "ORDERID": onError.details['ORDERID'],
                          "RESPCODE": onError.details['RESPCODE'],
                          "RESPMSG": onError.details['RESPMSG'],
                          "STATUS": onError.details['STATUS'],
                          "TXNAMOUNT": onError.details['TXNAMOUNT'],
                          // "BANKTXNID": onError.details['BANKTXNID'],
                        });
                        paymentRepo.callbackApiForPaytmResponse(jsonBody);
                        AppLog.d("STAUS FAIL BY USER");
                      }
                      result = onError.message??"NULL EROOR" + " \n  " + onError.details.toString();
                      AppLog.d("REDSULE ====  ${result}");

                    });
                  } else {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Payment()));
                    setState(() {
                      result = onError.toString();
                      AppLog.d("REDSULE ${result}");
                    });
                  }
                });
                // response.then((value) {
                //   print(value);
                //   print("Printing the value in the response API");
                //   print(value);
                //   // setState(() {
                //   //   result = value.toString();
                //     AppLog.e("Result = ${result.toString()}");
                //     // final snackBar = SnackBar(
                //     //   content: Text(result.toString()),
                //     // );
                //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //   // });
                // }).catchError((onError,t) {
                //   if (onError is PlatformException) {
                //     final snackBar = SnackBar(
                //       content: Text(onError.toString()),
                //     );
                //     Navigator.pop(context);
                //
                //
                //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //   } else {
                //     setState(() {
                //       print("Printing the result error in the response API");
                //       result = onError.toString();
                //       // final snackBar = SnackBar(
                //       //   content: Text(result.toString()),
                //       // );
                //       Navigator.pop(context);
                //       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //
                //     });
                //   }
                //   AppLog.e("TRACE ON PAYMRNT ::: $t");
                // });
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
              Logger().d("PLAN ERROR ${state}");
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
                        // Text(paymentMethod),
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
  Future<void> checkLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            paymentMethod = 'Location permission denied';
          });
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (position.latitude >= 6.75 &&
          position.latitude <= 35.75 &&
          position.longitude >= 68.17 &&
          position.longitude <= 97.25) {
        setState(() {
          paymentMethod = 'Paytm';
        });
      } else {
        setState(() {
          paymentMethod = 'PayPal';
        });
      }
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        paymentMethod = 'Unknown';
      });
    }
  }


  design(PlanModel planModel) {
    return InkWell(
      onTap: () async{
        String? userID =prefs.getString("${SharedConstants.udid}");
        // paymentMethod == 'Paytm'?
        await paymentCubit.tokenApi(userID.toString(), planModel.planId, planModel.planAmount);
            // :
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //     UsePaypal(
        //
        //
        //       /// if testing purpose sandboxmode true and change client key and secrete key
        //
        //
        //
        //         sandboxMode: false,
        //         clientId:
        //         "Abm6DBQ-1lH7yMpPls-5GwhV5pFWG4tU4UjHZz53oMkbDa5freDZJe9vmb1x8VFjG-AC-PSkVjR6AgsJ",
        //         // "Ac6HIRbAECXDyVWDPtVZejDqWng_Hbmgf-ujEk8vdzfPqoayMtlD2WHntaEacA6LMpKpFMlenCCydoVr",
        //         secretKey:
        //         "ELhWgFdh5NGfkVftghxDSojbHEl3HN0mrU32Hp7yiSTLIDKrwSU5uly2zFZeL8koswx9OV7U7fMGjVEN",
        //         // "EFUtd5R8C6vYNDDnYKu3SP3gSmydb_c3yj5BImyJyChPkkh6H5WgCxWU5nBz-QkyXZcOFWB0UstVOfU1",
        //         returnURL: "https://www.google.com/return",
        //         cancelURL: "https://www.facebook.com/cancel",
        //         transactions: [
        //           {
        //             "amount": {
        //               "total": '1.00',
        //               "currency": "USD",
        //               "details": {
        //                 "subtotal": '1.00',
        //                 "shipping": '0',
        //                 "shipping_discount": 0
        //               }
        //             },
        //             "description":
        //             "The payment transaction description.",
        //             // "payment_options": {
        //             //   "allowed_payment_method":
        //             //       "INSTANT_FUNDING_SOURCE"
        //             // },
        //             "item_list": {
        //               "items": [
        //                 {
        //                   "name": "A demo product",
        //                   "quantity": 1,
        //                   "price": '1.00',
        //                   "currency": "USD"
        //                 }
        //               ],
        //
        //               // shipping address is not required though
        //               // "shipping_address": {
        //               //   "recipient_name": "Jane Foster",
        //               //   "line1": "Travis County",
        //               //   "line2": "",
        //               //   "city": "Austin",
        //               //   "country_code": "US",
        //               //   "postal_code": "73301",
        //               //   "phone": "+00000000",
        //               //   "state": "Texas"
        //               // },
        //             }
        //           }
        //         ],
        //         note: "Contact us for any questions on your order.",
        //         onSuccess: (Map params) async {
        //
        //           print("onSuccess: $params");
        //           Logger().f(params);
        //           Logger().e("Sucess");
        //
        //         },
        //         onError: (error,t) {
        //           print("onError: $error");
        //           Logger().e(error);
        //           Logger().e(t);
        //         },
        //         onCancel: (params) {
        //           print('cancelled: $params');
        //           Logger().e("CANCELLED ::: ${params}");
        //
        //         }),));
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
