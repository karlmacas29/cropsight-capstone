import 'dart:io';
import 'package:cropsight/views/navigation/scanning.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  File? _image;

  Future<void> pickImage() async {
    final permissionStatus = await _getPermissionStatus();
    if (permissionStatus == PermissionStatus.granted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any,
        );

        if (result != null && result.files.single.path != null) {
          setState(() {
            _image?.deleteSync(); // Delete the previous image file if it exists
            _image = File(result.files.single.path!);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanPage(imageSc: _image),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    } else {
      // Handle the case when permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied')),
      );
    }
  }

  Future<PermissionStatus> _getPermissionStatus() async {
    if (await Permission.storage.request().isGranted) {
      return PermissionStatus.granted;
    } else {
      // For Android 14+, handle the new permissions
      if (await Permission.photos.request().isGranted) {
        return PermissionStatus.granted;
      } else if (await Permission.mediaLibrary.request().isGranted) {
        return PermissionStatus.granted;
      }
    }
    return PermissionStatus.denied;
  }

  Future<void> getImage(BuildContext context, ImageSource source) async {
    final cameraStatus = await Permission.camera.status;
    final photosStatus = await Permission.photos.status;

    if (cameraStatus.isDenied || photosStatus.isDenied) {
      final requestCamera = await Permission.camera.request().isGranted;
      final requestPhotos = await Permission.photos.request().isGranted;

      if (!requestCamera || !requestPhotos) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied')),
        );
        return;
      }
    }

    if (cameraStatus.isPermanentlyDenied || photosStatus.isPermanentlyDenied) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Error'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'This app needs camera and photo access to function properly. Please grant the permissions in the settings.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () async {
                  await openAppSettings();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (await Permission.camera.isGranted &&
        await Permission.photos.isGranted) {
      try {
        final pickedFile = await ImagePicker().getImage(source: source);

        if (pickedFile != null) {
          setState(() {
            _image?.deleteSync(); // Delete the previous image file if it exists
            _image = File(pickedFile.path);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanPage(imageSc: _image),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'An error occurred while picking the image. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            shadowColor: Colors.grey,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('What is Cropsight?',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_alt_rounded,
                        color: Color.fromRGBO(2, 101, 0, 1),
                        size: 38,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'Turn your mobile phone into a crop insect identifier',
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_alt_rounded,
                        color: Color.fromRGBO(2, 101, 0, 1),
                        size: 38,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'With just one photo. CropSight diagnosis infected crops and offers a management options for any insects damage',
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.task_alt_rounded,
                        color: Color.fromRGBO(2, 101, 0, 1),
                        size: 38,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'CropSight will give you a insect wikipedia to give a info about different crop insects',
                          style: TextStyle(
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  getImage(context, ImageSource.camera);
                },
                child: Ink(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(23),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Icon(
                              Icons.camera_rounded,
                              color: Colors.white,
                            )),
                        const Text(
                          'Scan',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  pickImage();
                },
                child: Ink(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(23),
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Icon(Icons.photo_library_rounded,
                                color: Colors.white)),
                        const Text(
                          'Photos',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
