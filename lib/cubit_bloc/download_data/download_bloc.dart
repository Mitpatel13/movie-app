// download_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

enum DownloadStatus { loading, loaded, error }

class DownloadState {
  final DownloadStatus status;
  final List<DownloadItem> downloads;

  DownloadState({
    required this.status,
    required this.downloads,
  });
}

class DownloadItem {
  final String title;
  final String description;
  final String url;
  final String imagePath;
  final String status;
  final String taskId;

  DownloadItem({
    required this.title,
    required this.description,
    required this.url,
    required this.imagePath,
    required this.status,
    required this.taskId,
  });
}

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState(status: DownloadStatus.loading, downloads: []));

  Future<void> startDownload(String title, String description, String url, String imagePath) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: 'downloads/',
      fileName: '$title.mp4',
      showNotification: true,
      openFileFromNotification: true,
    );

    final newItem = DownloadItem(
      title: title,
      description: description,
      url: url,
      imagePath: imagePath,
      status: 'Downloading...',
      taskId: taskId!,
    );

    emit(DownloadState(status: DownloadStatus.loading, downloads: [newItem, ...state.downloads]));

    FlutterDownloader.registerCallback((id, status, progress) {
      if (status == DownloadTaskStatus.complete) {
        updateDownloadStatus(id, 'Downloaded');
      } else if (status == DownloadTaskStatus.failed) {
        updateDownloadStatus(id, 'Failed');
      } else if (status == DownloadTaskStatus.running) {
        updateDownloadStatus(id, 'Downloading... $progress%');
      }
    });
  }

  void updateDownloadStatus(String taskId, String status) {
    final updatedDownloads = state.downloads.map((item) {
      if (item.taskId == taskId) {
        return DownloadItem(
          title: item.title,
          description: item.description,
          url: item.url,
          imagePath: item.imagePath,
          status: status,
          taskId: item.taskId,
        );
      } else {
        return item;
      }
    }).toList();

    emit(DownloadState(status: DownloadStatus.loaded, downloads: updatedDownloads));
  }
}
