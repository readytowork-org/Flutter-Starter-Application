import 'package:basic_app/components/alert_dialog.dart';
import 'package:basic_app/components/google_maps.dart';
import 'package:basic_app/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  // final String _image = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> imgFromCamera() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      // print('image from camera $image');
      // setState(() {
      //   _image = image;
      // });
    } catch (error) {
      // print("error from gallery $error");
    }
  }

  Future<void> imgFromGallery() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // print('image from camera $image');
      // setState(() {
      //   _image = image;
      // });
    } catch (error) {
      // print("error from camera $error");
    }
  }

  void showSelectOptions(primaryContext) {
    showCupertinoModalPopup(
        context: primaryContext,
        builder: (primaryContext) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: const Text('Take a Photo'),
                    onPressed: () async {
                      Navigator.pop(primaryContext);
                      imgFromCamera();
                    }),
                CupertinoActionSheetAction(
                    child: const Text('Choose From Gallery'),
                    onPressed: () async {
                      var permission = await Permission.camera.request();
                      print("the permission result is $permission");
                      Navigator.pop(primaryContext);
                      if (permission == PermissionStatus.permanentlyDenied ||
                          permission == PermissionStatus.denied) {
                        ShowDialogBox.dialogBoxes(
                            context: context,
                            alertTitle: "Permission Denied",
                            alertMessage: "Do you want to open Settings?",
                            onPressYesButton: () {
                              openAppSettings();
                              Navigator.pop(context);
                            },
                            onPressNoButton: () {
                              Navigator.pop(context);
                            });
                      } else if (permission == PermissionStatus.granted) {
                        imgFromGallery();
                      } else {
                        ShowDialogBox.dialogBoxes(
                            context: context,
                            alertTitle: "Restricted",
                            alertMessage:
                                "This feature restricted in your device",
                            onPressYesButton: () {
                              Navigator.pop(context);
                            },
                            onPressNoButton: () {
                              Navigator.pop(context);
                            });
                      }
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.deepPurpleAccent,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration:
                      const BoxDecoration(color: Colors.deepPurpleAccent),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      BuildContext primaryContext = context;
                      showSelectOptions(primaryContext);
                    },
                    child: const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/login_image.jpg')),
                  ),
                  accountEmail: const Text('pratik.adhikari@readytowork.jp'),
                  accountName: const Text('Pratik Adhikari'),
                )),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                    context, RoutesAvailable.populatTvShowsRoute);
              },
              leading: const Icon(
                Icons.tv,
                color: Colors.white,
                size: 24.0,
              ),
              title: const Text(
                'TV Shows',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            // SizedBox(height: 10),
            const ListTile(
              leading: Icon(
                Icons.slow_motion_video_sharp,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Upcoming Movies',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            // const SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutesAvailable.locationRoute);
              },
              leading: const Icon(
                Icons.share_location_outlined,
                color: Colors.white,
                size: 24.0,
              ),
              title: const Text(
                'Location',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('loggedInValue', false);
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesAvailable.authenticationRoute,
                    (Route<dynamic> route) => false);
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 24.0,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            // const RenderGoogleMaps()
          ],
        ),
      ),
    );
  }
}
