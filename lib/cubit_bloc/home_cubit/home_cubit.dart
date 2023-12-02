import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/models/homebannermodel.dart';
import 'package:shinestreamliveapp/data/repository/homerepository.dart';

import '../../di/locator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final homeRepo = getIt<HomeRepository>();
  HomeCubit() : super(HBLoading());

  homeBanner() async{
    try{
      emit(HBLoading());
      var response = await homeRepo.homeBanner();
     // var response = await loginRepo.checkLogin(jsonBody);
      emit(HBLoaded(response));

    } catch(error) {
      emit(HBError(error));
    }
  }
  actionMovie() async{
    try{
      emit(ActionLoading());
      var response = await homeRepo.actionMovie();
      print("ACTION ${response}");
     // var response = await loginRepo.checkLogin(jsonBody);
      emit(ActionLoaded(response));

    } catch(error) {
      emit(ActionError(error));
    }
  }
  classicMovie() async{
    try{
      emit(ClassicLoading());
      var response = await homeRepo.classicMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(ClassicLoaded(response));

    } catch(error) {
      emit(ClassicError(error));
    }
  }
  comedyMovie() async{
    try{
      emit(ComedyLoading());
      var response = await homeRepo.comedyMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(ComedyLoaded(response));

    } catch(error) {
      emit(ComedyError(error));
    }
  }
  crimeMovie() async{
    try{
      emit(CrimeLoading());
      var response = await homeRepo.crimeMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(CrimeLoaded(response));

    } catch(error) {
      emit(CrimeError(error));
    }
  }
  romanticMovie() async{
    try{
      emit(RomanticLoading());
      var response = await homeRepo.romanticMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(RomanticLoaded(response));

    } catch(error) {
      emit(RomanticError(error));
    }
  }
  telugufavMovie() async{
    try{
      emit(TeluguFavLoading());
      var response = await homeRepo.telugufavMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(TeluguFavLoaded(response));

    } catch(error) {
      emit(TeluguFavError(error));
    }
  }
  dramaMovie() async{
    try{
      emit(DramaLoading());
      var response = await homeRepo.dramaMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(DramaLoaded(response));

    } catch(error) {
      emit(DramaError(error));
    }
  }
  kidsMovie() async{
    try{
      emit(KidsLoading());
      var response = await homeRepo.kidsMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(KidsLoaded(response));

    } catch(error) {
      emit(KidsError(error));
    }
  }
  sportsMovie() async{
    try{
      emit(SportsLoading());
      var response = await homeRepo.sportsMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(SportsLoaded(response));

    } catch(error) {
      emit(SportsError(error));
    }
  }
  devotionalMovie() async{
    try{
      emit(DevotionalLoading());
      var response = await homeRepo.devotionalMovie();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(DevotionalLoaded(response));

    } catch(error) {
      emit(DevotionalError(error));
    }
  }
  folkSongs() async{
    try{
      emit(FolkLoading());
      var response = await homeRepo.folkSongs();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(FolkLoaded(response));

    } catch(error) {
      emit(FolkError(error));
    }
  }
  oldIsGold() async{
    try{
      emit(OldIsGoldLoading());
      var response = await homeRepo.oldIsGold();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(OldIsGoldLoaded(response));

    } catch(error) {
      emit(OldIsGoldError(error));
    }
  }
  bestHollywood() async{
    try{
      emit(BestHollyLoading());
      var response = await homeRepo.bestHollywood();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(BestHollyLoaded(response));

    } catch(error) {
      emit(BestHollyError(error));
    }
  }
  bestSouth() async{
    try{
      emit(BestSouthLoading());
      var response = await homeRepo.bestSouth();
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(BestSouthLoaded(response));

    } catch(error) {
      emit(BestSouthError(error));
    }
  }
}
final homeCubit = HomeCubit();