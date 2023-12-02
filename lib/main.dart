import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/cubit_bloc/download_data/download_bloc.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/newuser_cubit/new_user_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/profile_cubit/profile_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/view_all_movies_cubit/view_all_movie_cubit.dart';
import 'package:shinestreamliveapp/ui/dashboard/movieplay.dart';
import 'package:shinestreamliveapp/ui/payment/payment.dart';
import 'package:shinestreamliveapp/ui/splash.dart';
import 'package:shinestreamliveapp/utils/check_internet.dart';
import 'package:shinestreamliveapp/utils/globle_var.dart';

import 'cubit_bloc/home_cubit/home_cubit.dart';
import 'cubit_bloc/login_cubit.dart';
import 'cubit_bloc/otp_cubit/otp_cubit.dart';
import 'cubit_bloc/payment/payment_cubit.dart';
import 'di/locator.dart';
late SharedPreferences prefs;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await init();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
}

Future init() async {
  prefs = await SharedPreferences.getInstance();

}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [

          BlocProvider(create: (context) => getIt<LoginCubit>(),),
          BlocProvider(create: (context) => getIt<NewUserCubit>(),),
          BlocProvider(create: (context) => getIt<OtpCubit>(),),
          BlocProvider(create: (context) => getIt<HomeCubit>()),
          BlocProvider(create: (context) => getIt<MovieCubit>()),
          BlocProvider(create: (context) => getIt<ProfileCubit>()),
          BlocProvider(create: (context) => getIt<MovieCubit>()),
          BlocProvider(create: (context) => getIt<VideoplayerCubit>()),
          BlocProvider(create: (context) => getIt<SeriesCubit>()),
          BlocProvider(create: (context) => getIt<PaymentCubit>()),
          BlocProvider(create: (context) => getIt<MovieByLanguageCubit>()),
          BlocProvider(create: (context) => getIt<DownloadCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(useMaterial3: true,
            // scaffoldBackgroundColor: Colors.black
            brightness: Brightness.dark,
          //     pageTransitionsTheme:PageTransitionsTheme(
          //   builders: {
          //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          //   TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          //   },
          // ),
            // scaffoldBackgroundColor: Colors.,
          ),
          home: const Splash(),
        ));
  }
}


