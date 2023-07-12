import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongScreen extends StatefulWidget {
  const AllSongScreen({Key? key}) : super(key: key);

  @override
  State<AllSongScreen> createState() => _AllSongScreenState();
}

class _AllSongScreenState extends State<AllSongScreen> {

  final OnAudioQuery _audioDeviceQuery = OnAudioQuery();
  bool _hasPermission = false;


  _checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioDeviceQuery.checkAndRequest(
      retryRequest: retry,
    );

    _hasPermission ? setState(() {}) : null;
  }

  @override
  void initState() {
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioDeviceQuery.setLogConfig(logConfig);
    _checkAndRequestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Inch player 2.0.0')),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: !_hasPermission
            ? _noAccessToLibraryWidget()
            : _haveAccessToLibrary()
        )
    );
  }

  _haveAccessToLibrary() {
    return FutureBuilder<List<SongModel>>(
        future: _audioDeviceQuery!.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return _fetchingSongs();
          }
          if (snapshot.data!.isEmpty) {
            return _emptySong();
          }
          if (snapshot.hasError) {
            return _error(snapshot.error.toString());
          }
          return _bodyWidget(songList: snapshot.data);
        },
    );
  }

  _emptySong() {
    return const Center(
      child: Text("No Songs found !"),
    );
  }

  _error(dynamic error) {
    return Center(
      child: Text(error),
    );
  }

  _fetchingSongs() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _bodyWidget({required List<SongModel>? songList}) {
    return ListView.builder(
      itemCount: songList!.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.music_note),
          title: Text(songList![index].displayName),
          subtitle: (songList![index].artist == null) || (songList![index].artist == '<unknown>')
            ? Text('No artist ${'    '}${songList![index].duration}')
            : Text('${songList![index].artist}${'    '}${songList![index].duration}'),
          trailing: const Icon(Icons.more_horiz),
        );
      },
    );
  }

  _noAccessToLibraryWidget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Application doesn't have access to the library"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _checkAndRequestPermissions(retry: true),
              child: const Text("Allow"),
            ),
          ],
        ),
      ),
    );
  }

}
