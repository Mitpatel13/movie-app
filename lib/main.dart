import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinestreamliveapp/cubit_bloc/download_data/download_bloc.dart';
import 'package:shinestreamliveapp/cubit_bloc/movie_cubit/movie_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/newuser_cubit/new_user_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/profile_cubit/profile_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/view_all_movies_cubit/view_all_movie_cubit.dart';
import 'package:shinestreamliveapp/ui/splash.dart';
import 'cubit_bloc/episode_cubit/episode_cubit.dart';
import 'cubit_bloc/home_cubit/home_cubit.dart';
import 'cubit_bloc/login_cubit.dart';
import 'cubit_bloc/otp_cubit/otp_cubit.dart';
import 'cubit_bloc/payment/payment_cubit.dart';
import 'cubit_bloc/shows/shws_cubit.dart';
import 'cubit_bloc/shows_episode_cubit/shows_episode_cubit.dart';
import 'di/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ScreenUtilInit(

      builder: (context, child) =>
        MultiBlocProvider(
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
    BlocProvider(create: (context) => getIt<EpisodeCubit>()),
    BlocProvider(create: (context) => getIt<ShowsCubit>()),
    BlocProvider(create: (context) => getIt<ShowsEpisodeCubit>()),
    ],
    child: MaterialApp(
    debugShowCheckedModeBanner: false,

    theme: ThemeData(useMaterial3: true,scaffoldBackgroundColor: Colors.black.withOpacity(0.5),

    brightness: Brightness.dark,
    ),
    home: const Splash(),
    )),

    );
  }
}


