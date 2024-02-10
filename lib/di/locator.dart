import 'package:get_it/get_it.dart';
import 'package:shinestreamliveapp/cubit_bloc/home_cubit/home_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/newuser_cubit/new_user_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/otp_cubit/otp_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/payment/payment_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/profile_cubit/profile_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/series_cubit/series_cubit.dart';
import 'package:shinestreamliveapp/cubit_bloc/vidoeplayer_cubit/videoplayer_cubit.dart';
import 'package:shinestreamliveapp/data/repository/forgotpasswordrepository.dart';
import 'package:shinestreamliveapp/data/repository/homerepository.dart';
import 'package:shinestreamliveapp/data/repository/language_repository.dart';
import 'package:shinestreamliveapp/data/repository/movieRepository.dart';
import 'package:shinestreamliveapp/data/repository/paymentrepository.dart';
import 'package:shinestreamliveapp/data/repository/profilerepository.dart';
import 'package:shinestreamliveapp/data/repository/seriesrepository.dart';
import 'package:shinestreamliveapp/data/repository/videoplayerrepository.dart';
import 'package:shinestreamliveapp/data/services/forgotpasswordservice.dart';
import 'package:shinestreamliveapp/data/services/homeservice.dart';
import 'package:shinestreamliveapp/data/services/movieService.dart';
import 'package:shinestreamliveapp/data/services/paymentservice.dart';
import 'package:shinestreamliveapp/data/services/profileservice.dart';
import 'package:shinestreamliveapp/data/services/seriesservice.dart';
import 'package:shinestreamliveapp/data/services/videoplayerservice.dart';
import '../cubit_bloc/download_data/download_bloc.dart';
import '../cubit_bloc/episode_cubit/episode_cubit.dart';
import '../cubit_bloc/login_cubit.dart';
import '../cubit_bloc/movie_cubit/movie_cubit.dart';
import '../cubit_bloc/shows/shws_cubit.dart';
import '../cubit_bloc/shows_episode_cubit/shows_episode_cubit.dart';
import '../cubit_bloc/view_all_movies_cubit/view_all_movie_cubit.dart';
import '../data/api.dart';
import '../data/repository/changepasswordrepository.dart';
import '../data/repository/episoderepository.dart';
import '../data/repository/loginrepository.dart';
import '../data/repository/shows_episode_repository.dart';
import '../data/repository/shows_repository.dart';
import '../data/services/changepasswordservice.dart';
import '../data/services/episodeservice.dart';
import '../data/services/language_movie_service.dart';
import '../data/services/loginservice.dart';
import '../data/services/shoes_episode_service.dart';
import '../data/services/shows_service.dart';


final getIt = GetIt.instance;

void setup() {
  /// Dio
 getIt.registerLazySingleton<Api>(() => Api());

  /// Shred preferences
//  getIt.registerLazySingleton<SharedConstants>(() => SharedConstants());

  /// Local database
 // getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  ///repository

  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository());
  getIt.registerLazySingleton<VideoPlayerRepository>(() => VideoPlayerRepository());
  getIt.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepository());
  getIt.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordRepository());
  getIt.registerLazySingleton<SeriesRepository>(() => SeriesRepository());
  getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepository());
  getIt.registerLazySingleton<LanguageByMovieRepository>(() => LanguageByMovieRepository());
  getIt.registerLazySingleton<WebEpisodeSeriesRepository>(() => WebEpisodeSeriesRepository());
  getIt.registerLazySingleton<ShowsRepository>(() => ShowsRepository());
  getIt.registerLazySingleton<ShowsEpisodeSeriesRepository>(() => ShowsEpisodeSeriesRepository());

  ///service
  getIt.registerLazySingleton<LoginService>(() => LoginService());
  getIt.registerLazySingleton<HomeService>(() => HomeService());
  getIt.registerLazySingleton<ProfileService>(() => ProfileService());
  getIt.registerLazySingleton<MovieService>(() => MovieService());
  getIt.registerLazySingleton<VideoPlayerService>(() => VideoPlayerService());
  getIt.registerLazySingleton<ForgotPasswordService>(() => ForgotPasswordService());
  getIt.registerLazySingleton<ChangePasswordService>(() => ChangePasswordService());
  getIt.registerLazySingleton<SeriesService>(() => SeriesService());
  getIt.registerLazySingleton<PaymentService>(() => PaymentService());
  getIt.registerLazySingleton<LanguageMovieService>(() => LanguageMovieService());
  getIt.registerLazySingleton<WebSeriesEpisodeService>(() => WebSeriesEpisodeService());
  getIt.registerLazySingleton<ShowsService>(() => ShowsService());
  getIt.registerLazySingleton<ShowsEpisodeService>(() => ShowsEpisodeService());


  ///cubit
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
  getIt.registerLazySingleton<NewUserCubit>(() => NewUserCubit());
  getIt.registerLazySingleton<OtpCubit>(() => OtpCubit());
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  getIt.registerLazySingleton<MovieCubit>(() => MovieCubit());
  getIt.registerLazySingleton<VideoplayerCubit>(() => VideoplayerCubit());
  getIt.registerLazySingleton<SeriesCubit>(() => SeriesCubit());
  getIt.registerLazySingleton<PaymentCubit>(() => PaymentCubit());
  getIt.registerLazySingleton<MovieByLanguageCubit>(() => MovieByLanguageCubit());
  getIt.registerLazySingleton<DownloadCubit>(() => DownloadCubit());
  getIt.registerLazySingleton<EpisodeCubit>(() => EpisodeCubit());
  getIt.registerLazySingleton<ShowsCubit>(() => ShowsCubit());
  getIt.registerLazySingleton<ShowsEpisodeCubit>(() => ShowsEpisodeCubit());

}
