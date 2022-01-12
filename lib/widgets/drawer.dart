import 'package:basic_app/components/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  String _image = "";

  Future<void> imgFromCamera() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      print('image from camera $image');
      // setState(() {
      //   _image = image;
      // });
    } catch (error) {
      print("error from gallery $error");
    }
  }

  Future<void> imgFromGallery() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      print('image from camera $image');
      // setState(() {
      //   _image = image;
      // });
    } catch (error) {
      print("error from camera $error");
    }
  }

  void showSelectOptions(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: const Text('Take a Photo'),
                    onPressed: () async {
                      // Navigator.pop(context);
                      // imgFromCamera();
                    }),
                CupertinoActionSheetAction(
                    child: const Text('Choose From Gallery'),
                    onPressed: () async {
                      var permission = await Permission.camera.request();
                      print("the permission result is $permission");
                      if (permission == PermissionStatus.permanentlyDenied ||
                          permission == PermissionStatus.denied) {
                        Navigator.pop(context);
                        ShowDialogBox.dialogBoxes(context, "Permission Denied",
                            "Do you want to open Settings?", () {
                          openAppSettings();
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                        });
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //             title: const Text('Permission Denied'),
                        //             content: const Text(
                        //                 "Do you want to open Settings?"),
                        //             actions: [
                        //               TextButton(
                        //                   child: const Text('Yes'),
                        //                   onPressed: () {
                        //                     openAppSettings();
                        //                     Navigator.pop(context);
                        //                   }),
                        //               TextButton(
                        //                   child: const Text('No'),
                        //                   onPressed: () =>
                        //                       Navigator.pop(context)),
                        //             ]));
                      } else if (permission == PermissionStatus.granted) {
                        Navigator.pop(context);
                        imgFromGallery();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                    title: Text(
                                        'Feature restricted in your device'),
                                    content: Text(""),
                                    actions: [
                                      Text('Yes'),
                                      Text('No'),
                                    ]));
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
                      showSelectOptions(context);
                    },
                    child: const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/login_image.jpg')),
                  ),
                  accountEmail: const Text('pratik.adhikari@readytowork.jp'),
                  accountName: const Text('Pratik Adhikari'),
                )),
            const ListTile(
              leading: Icon(
                Icons.tv,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
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
            // SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
