import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/discovery/discovery.dart';
import 'package:music_app/ui/home/viewmodel.dart';
import 'package:music_app/ui/setting/setting.dart';
import 'package:music_app/ui/user/user.dart';
import 'package:flutter/services.dart';
import '../../data/model/song.dart';
import '../../icons/app_icons.dart';
import '../../icons/icons_app.dart';
import '../now_playing/playing.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, primary: Colors.white, onPrimary: Colors.white,),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingTab()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items: const [
            BottomNavigationBarItem(icon: Icon(FlutterIcon.home)),
            BottomNavigationBarItem(icon: Icon(FlutterIcon.music)),
            BottomNavigationBarItem(icon: Icon(FlutterIcon.heart)),
            BottomNavigationBarItem(icon: Icon(FlutterIcon.user)),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPageState();
  }
}

class HomeTabPageState extends StatefulWidget {
  const HomeTabPageState({super.key});

  @override
  State<HomeTabPageState> createState() => _HomeTabPageStateState();
}

class _HomeTabPageStateState extends State<HomeTabPageState> {
  List<Song> songs = [];
  late MusicAppViewModel _viewModel;

  @override
  void initState() {
    _viewModel = MusicAppViewModel();
    _viewModel.loadSongs();
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF020E1E),
                    Color(0XFF00384F),
                    Color(0xFF030C1D),
                    Color(0xFF003E57),
                    Color(0xFF030C1E)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.search_sharp, color: Colors.white),
                        Image.asset(
                          'assets/logo.png',
                          height: 33,
                          width: 108,
                        ),
                        const Icon(Icons.more_vert, color: Colors.white)
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                        padding: const EdgeInsets.only(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://scontent.fdad2-1.fna.fbcdn.net/v/t39.30808-6/444484446_1020563112759415_4121857495037451150_n.png?_nc_cat=108&ccb=1-7&_nc_sid=cc71e4&_nc_eui2=AeHfkGVrvOfFeif5NAKVm1s74qnemKn0slDiqd6YqfSyUGMr5NoMEFN1z3QewbB1Vgh4uILIULVebmbJDmZM5u9N&_nc_ohc=RpcAXM86cJcQ7kNvgFDzr4G&_nc_ht=scontent.fdad2-1.fna&_nc_gid=AP-0H9VtaYxKJ107YcHP2gO&oh=00_AYBxQd3bmMnNXUi9R_l-a9bJ4FoMrDTsFLJ_voodfPUw7Q&oe=67139AFD',
                            width: 334,
                            height: 118,
                            fit: BoxFit.cover,
                          ),
                        )),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            "RECENTLY PLAYED",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Text(
                            "see all",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        'https://i1.sndcdn.com/artworks-kfwBLdecXEgg-0-t500x500.jpg',
                                        height: 185,
                                        width: 147,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                const Text('drunk text',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Text('Henry Moodie',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        'https://toomva.com/images/posts/2024/03/loi-dich-seasons-wave-to-earth-2.png',
                                        height: 185,
                                        width: 147,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                const Text('seasons',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Text('wave to earth',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        'https://i1.sndcdn.com/artworks-wDnRB12ijjMYqWzy-ufzM2A-t500x500.jpg',
                                        height: 185,
                                        width: 147,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                const Text('24/7, 365',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Text('elijah woods',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            "RECOMMENDATIONS",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Text(
                            "see all",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    getBody(),
                  ],
                )
              )),
          // Expanded(child: getBody()),

    );
  }

  @override
  void dispose() {
    _viewModel.songStream.close();
    super.dispose();
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getListView() {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, position) {
          return getRow(position);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0,
            indent: 24,
            endIndent: 24,
          );
        },
        itemCount: songs.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget getRow(int index) {
    return _songItemSection(
      parent: this,
      song: songs[index],
    );
  }

  void observeData() {
    _viewModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
                height: 400,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("Modal Bottom Sheet"),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close Bottom Sheet"))
                    ],
                  ),
                )),
          );
        });
  }

  void navigate(Song song) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        songs: songs,
        playingSong: song,
      );
    }));
  }
}

class _songItemSection extends StatelessWidget {
  _songItemSection({
    required this.parent,
    required this.song,
  });

  final _HomeTabPageStateState parent;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24,
        right: 8,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/spotify.png',
          image: song.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/spotify.png', width: 48, height: 48);
          },
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(
            fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      trailing: IconButton(
          onPressed: () {
            parent.showBottomSheet();
          },
          icon: const Icon(Icons.more_horiz, color: Colors.white,)),
      onTap: () {
        parent.navigate(song);
      },
    );
  }
}
