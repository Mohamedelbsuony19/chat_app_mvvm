import 'package:chat_c5/core/helper/base_mvvm.dart';
import 'package:chat_c5/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';
import 'add_room_viewmodel.dart';
import 'add_room_navigator.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'addroom';

  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  var categories = Category.getCategories();
  late Category selectedItem;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '', des = '';
  @override
  void initState() {
    super.initState();
    selectedItem = categories[0];
    viewModel.navigator = this;
  }

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          Container(
            color: themeProvider.isLight ? Colors.white : Colors.black,
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text("Add Room"),
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
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset:
                            const Offset(0, 2), // changes position of shadow
                       
                      ),
                      //you can set more BoxShadow() here
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          "Create New Room",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset("assets/images/group.png"),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "type here please";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Room Title"),
                        onChanged: (val) {
                          title = val;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: DropdownButton<Category>(
                                value: selectedItem,
                                items: categories
                                    .map((cat) => DropdownMenuItem<Category>(
                                        value: cat,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(cat.image),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(cat.title)
                                            ],
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (val) {
                                  if (val == null) {
                                    return;
                                  }
                                  selectedItem = val;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "type here please";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: "Description"),
                        onChanged: (val) {
                          des = val;
                          setState(() {});
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: const Text("Create"))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      //create room
      viewModel.createingRoom(title, des, selectedItem.id);
    }
  }

  @override
  void createdRoom() {
    showMessage(
      'room created',
      action: () {
        hideDialog();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
