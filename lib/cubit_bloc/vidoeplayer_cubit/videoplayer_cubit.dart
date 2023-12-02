import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shinestreamliveapp/data/repository/videoplayerrepository.dart';

import '../../di/locator.dart';

part 'videoplayer_state.dart';

class VideoplayerCubit extends Cubit<VideoplayerState> {
  final videoPlayer = getIt<VideoPlayerRepository>();
  VideoplayerCubit() : super(VideoPlayerLoading());
  getVideo(var jsonBody) async{
    try{
      emit(VideoPlayerLoading());
      var response = await videoPlayer.getVideo(jsonBody);
      // var response = await loginRepo.checkLogin(jsonBody);
      emit(VideoPlayerLoaded(response));

    } catch(error) {
      emit(VideoPlayerError(error));
    }
  }
}
