import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/basescreen/base_screen.dart';
import 'package:shinestreamliveapp/data/models/planmodel.dart';
import 'package:shinestreamliveapp/ui/widget_components/app_bar_components.dart';
import 'package:shinestreamliveapp/utils/app_assets.dart';

import '../../cubit_bloc/payment/payment_cubit.dart';
import '../../di/locator.dart';
import '../../utils/color_constants.dart';
import '../../utils/shared_prefs.dart';
class SelectPaymentMethodScreen extends StatefulWidget {
  final PlanModel map;
   SelectPaymentMethodScreen({super.key,required this.map});

  @override
  State<SelectPaymentMethodScreen> createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends BaseScreen<SelectPaymentMethodScreen> {
  var paymentCubit = getIt<PaymentCubit>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar:
    AppBarConstant(
        isLeading: true,
        SizedBox(),(){Navigator.pop(context);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }),body:
      Padding(
        padding:  EdgeInsets.symmetric(vertical: systemHeight(10, context),horizontal: 15),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? userID =prefs.getString("${SharedConstants.udid}");
                await paymentCubit.tokenApi(userID.toString(), widget.map.planId,
                    widget.map.planAmount
                );

              }, child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAsset.paytmLogo,width: 80,),
                  // Text("Pay with Paytm"),
                ],
              ),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(ColorConstantss.white),
                      foregroundColor: MaterialStatePropertyAll(ColorConstantss.white))),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    UsePaypal(


                  /// if testing purpose sandboxmode true and change client key and secrete key



                    sandboxMode: false,
                    clientId:
                        "Abm6DBQ-1lH7yMpPls-5GwhV5pFWG4tU4UjHZz53oMkbDa5freDZJe9vmb1x8VFjG-AC-PSkVjR6AgsJ",
                    // "Ac6HIRbAECXDyVWDPtVZejDqWng_Hbmgf-ujEk8vdzfPqoayMtlD2WHntaEacA6LMpKpFMlenCCydoVr",
                    secretKey:
                       "ELhWgFdh5NGfkVftghxDSojbHEl3HN0mrU32Hp7yiSTLIDKrwSU5uly2zFZeL8koswx9OV7U7fMGjVEN",
                    // "EFUtd5R8C6vYNDDnYKu3SP3gSmydb_c3yj5BImyJyChPkkh6H5WgCxWU5nBz-QkyXZcOFWB0UstVOfU1",
                    returnURL: "https://www.google.com/return",
                    cancelURL: "https://www.facebook.com/cancel",
                    transactions: [
                      {
                        "amount": {
                          "total": '1.00',
                          "currency": "USD",
                          "details": {
                            "subtotal": '1.00',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description":
                        "The payment transaction description.",
                        // "payment_options": {
                        //   "allowed_payment_method":
                        //       "INSTANT_FUNDING_SOURCE"
                        // },
                        "item_list": {
                          "items": [
                            {
                              "name": "A demo product",
                              "quantity": 1,
                              "price": '1.00',
                              "currency": "USD"
                            }
                          ],

                          // shipping address is not required though
                          // "shipping_address": {
                          //   "recipient_name": "Jane Foster",
                          //   "line1": "Travis County",
                          //   "line2": "",
                          //   "city": "Austin",
                          //   "country_code": "US",
                          //   "postal_code": "73301",
                          //   "phone": "+00000000",
                          //   "state": "Texas"
                          // },
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {

                      print("onSuccess: $params");
                      Logger().f(params);
                      Logger().e("Sucess");

                    },
                    onError: (error,t) {
                      print("onError: $error");
                      Logger().e(error);
                      Logger().e(t);
                    },
                    onCancel: (params) {
                      print('cancelled: $params');
                      Logger().e("CANCELLED ::: ${params}");

                    }),));


              }, 
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(ColorConstantss.white)),
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAsset.paypalLogo,),
                  // Text("Pay with Paypal"),
                ],
              )),
            ),
          ],
        ),
      ),));
  }
}
