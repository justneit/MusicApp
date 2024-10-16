import 'package:music_app/data/source/source.dart';

import '../model/song.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  // Future<List<Song>?> loadData() async {
  //   List<Song> songs = [];
  //   await _remoteDataSource.loadData().then((remoteSongs) {
  //     if (remoteSongs == null) {
  //       _localDataSource.loadData().then((localSongs) {
  //         if (localSongs != null) {
  //           songs.addAll(localSongs);
  //         }
  //       });
  //     }
  //     else {
  //       songs.addAll(remoteSongs);
  //     }
  //   });
  //   return songs;
  // }
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    final remoteSongs = await _remoteDataSource.loadData();
    if (remoteSongs != null) {
      songs.addAll(remoteSongs);
    } else {
      final localSongs = await _localDataSource.loadData();
      if (localSongs != null) {
        songs.addAll(localSongs);
      }
    }
    return songs;
  }
}
