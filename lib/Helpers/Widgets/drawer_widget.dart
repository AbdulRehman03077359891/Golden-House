import 'package:flutter/material.dart';
import 'package:golden_house/Helpers/Animation/tile_animation.dart';
import 'package:golden_house/Stacks/Auth/Controllers/auth_controller.dart';

class AdminDrawerWidget extends StatefulWidget {
  final userData;

  const AdminDrawerWidget({
    super.key,
    required this.userData,
  });

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      elevation: 50,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromARGB(255, 236, 236, 230),
                    Color.fromARGB(255, 180, 182, 179),
                  ],
                ),
              ),
              // currentAccountPicture:                           GestureDetector(
              //               onTap: () {
              //                 if (fireController.userData["profilePic"] != null) {
              //                   animateController.showSecondPage(
              //                     "Profile Picture",
              //                     fireController.userData["profilePic"] ?? 'assets/images/profilePlaceHolder.jpg',
              //                     context,
              //                   );
              //                 }
              //               },
              //               child: Hero(
              //                 tag: "Profile Picture",
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     boxShadow: const [
              //                       BoxShadow(
              //                         color: Colors.cyan,
              //                         blurRadius: 10,
              //                         spreadRadius: 1,
              //                       ),
              //                     ],
              //                     borderRadius: BorderRadius.circular(50),
              //                     border: Border.all(
              //                       color: const Color.fromARGB(255, 245, 222, 224),
              //                       width: 2,
              //                       style: BorderStyle.solid,
              //                     ),
              //                     image: DecorationImage(
              //                       image: fireController.userData["profilePic"] != null
              //                           ? CachedNetworkImageProvider(fireController.userData["profilePic"])
              //                           : const AssetImage('assets/images/profilePlaceHolder.jpg') as ImageProvider,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
accountName: Text(widget.userData["userData"]["userName"], style: const TextStyle(fontWeight: FontWeight.bold,shadows: [BoxShadow(color: Color.fromARGB(115, 24, 255, 255),blurRadius: 3,spreadRadius: 3)]),),
              accountEmail: Text(widget.userData["userData"]["userEmail"], style: const TextStyle(fontWeight: FontWeight.bold,shadows: [BoxShadow(color: Color.fromARGB(115, 24, 255, 255),blurRadius: 3,spreadRadius: 3)]),),
            ),
            ..._buildSlidingTiles(),
          ],
        ),
      
    );
  }

  List<Widget> _buildSlidingTiles() {
    final tiles = [
      {
        'icon': Icons.person_rounded,
        'title': "Personal Data",
        "onPress": () {}
        // Get.to(
        //       PersonalData(
        //         imageUrl: fireController.userData["profilePic"] ?? '',
        //         userName: fireController.userData["userName"],
        //         userUid: widget.userUid,
        //         gender: fireController.userData["userGender"],
        //         contact: fireController.userData["userContact"],
        //         dob: fireController.userData["dateOfBirth"],
        //         address: fireController.userData["userAddress"],
        //         userEmail: fireController.userData["userEmail"],
        //       ),
        //     ),
      },
      {
        'icon': Icons.category,
        'title': "Add Levels",
        "onPress": () {}
        //  Get.to(AddLevel(
        //     userName: fireController.userData["userName"],
        //     userEmail: fireController.userData["userEmail"],
        //     profilePicture: fireController.userData["profilePic"] ?? ''))
      },
      {
        'icon': Icons.class_,
        'title': "Add Classes",
        "onPress": () {}
        //  Get.to(AddClasses(
        //     userUid: widget.userUid,
        //     userName: fireController.userData["userName"],
        //     userEmail: fireController.userData["userEmail"],
        //     profilePicture: fireController.userData["profilePic"] ?? ''))
      },
      {
        'icon': Icons.pages,
        'title': "Add Exams",
        "onPress": () {}
        //  Get.to(AddExams(
        //     userUid: widget.userUid,
        //     userName: fireController.userData["userName"],
        //     userEmail: fireController.userData["userEmail"],
        //     profilePicture: fireController.userData["profilePic"] ?? ''))
      },
      {
        'icon': Icons.list_alt,
        'title': "View Classes",
        "onPress": () {}
        // => Get.to(ClassData(
        //     userUid: widget.userUid,
        //     userName: fireController.userData["userName"],
        //     userEmail: fireController.userData["userEmail"],
        //     profilePicture: fireController.userData["profilePic"] ?? ''))
      },
      {
        'icon': Icons.logout,
        'title': "Log Out",
        "onPress": () {authService.logout();}
        //  showConfirmationDialog(context,() => fireController.logOut())
      },
    ];

    return List.generate(tiles.length, (index) {
      return SlidingTileAnimation(
        index: index,
        child: ListTile(
          leading: Icon(
            tiles[index]['icon'] as IconData,
            color: const Color.fromARGB(255, 21, 49, 71),
          ),
          title: Text(
            tiles[index]['title'] as String,
            style: const TextStyle(
              color: Color.fromARGB(255, 21, 49, 71),
              fontWeight: FontWeight.bold,
              shadows: [BoxShadow(color: Colors.cyan,blurRadius: 2,spreadRadius: 2)]
            ),
          ),
          onTap: tiles[index]['onPress'] as Function(),
        ),
      );
    });
  }
}
