import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import '../../widgets/room_widget.dart';
import '../add_room/add_room_screen.dart';
import 'home_navigator.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() => HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    viewModel.listenRoomUpdate();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => viewModel),
      ],
      child: Stack(children: [
        Container(
          color: themeProvider.isLight ? Colors.white : Colors.black,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Home'),
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: Icon(
                    themeProvider.isLight
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode,
                    size: 35,
                  ),
                  onPressed: () {
                    themeProvider.changeTheme();
                  },
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(child: Consumer<HomeViewModel>(
                  builder: (BuildContext context, HomeViewModel viewModel, child) {
                    return StreamBuilder(
                      stream: viewModel.roomStream,
                      builder: (_, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          viewModel.getRooms();
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1),
                          itemBuilder: (_, index) {
                            return RoomWidget(viewModel.rooms[index]);
                          },
                          itemCount: viewModel.rooms.length,
                        );
                      },
                    );
                  },
                ))
              ],
            ),
          ),
          
        ),
      ]),
    );
  }
}
