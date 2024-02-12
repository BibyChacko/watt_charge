import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/resource_helper.dart';
import '../../theme/app_theme.dart';
import '../models/content_permission_types.dart';

class ProfilePicWidget extends StatefulWidget {
  final String profilePicUrl;
  final ContentPermissionTypes permission;
  final Function(File) onProfilePicAdded;
  const ProfilePicWidget({
    Key? key,
    required this.profilePicUrl,
    this.permission = ContentPermissionTypes.view,
    required this.onProfilePicAdded,
  }) : super(key: key);

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  bool isFromLocal = false;
  File? imageFile;
  @override
  void initState() {
    if (widget.profilePicUrl.isEmpty) {
      isFromLocal = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !isFromLocal
            ? CircleAvatar(
                radius: 60,
                backgroundImage: CachedNetworkImageProvider(
                  widget.profilePicUrl,
                ),
              )
            : imageFile != null
                ? CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60,

                      backgroundImage: FileImage(
                        imageFile!,
                        scale: .8
                      ),
                    ),
                  )
                : Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 6),
                        borderRadius: BorderRadius.circular(100),
                        color: AppTheme.primary30TintColor),
                    child: const Center(
                        child: Icon(
                      Icons.person_2_outlined,
                      size: 42,
                    ))),
        Positioned(
          bottom: 2,
          right: 4,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: Colors.teal),
            child: IconButton(
                onPressed: () {
                  _selectNewImage(context);
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }

  Future<void> _selectNewImage(BuildContext context) async {
    XFile? imgFile = await ResourceHelper.pickImage();
    if(imgFile == null){
      return;
    }
    imageFile = File(imgFile.path);
    setState(() {});
  }
}
