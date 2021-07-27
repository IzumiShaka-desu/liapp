import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/provider/main_provider.dart';
import 'package:liapp/screen/page_container.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 20, left: 30),
      color: ColorPalette.secondary,
      child: Consumer<MainProvider>(
        builder: (context, provider, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: ColorPalette.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: CircleAvatar(
                      minRadius: 35,
                      maxRadius: 40,
                      backgroundColor: ColorPalette.mainWhite,
                      backgroundImage: provider.photoProfile != null
                          ? FileImage(provider.photoProfile)
                          : AssetImage('images/icon.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo_outlined),
                      onPressed: () async {
                        var picker = ImagePicker();
                        PickedFile image;
                        try {
                          image = await picker.getImage(
                              source: ImageSource.gallery);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        if (image != null) {
                          provider.photoProfile = File(image.path);
                          provider.refresh();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              provider.currentUser.name,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: ColorPalette.textDark,
                  ),
            ),
            SizedBox(height: 10),
            Text(
              provider.currentUser.email,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: ColorPalette.textDark,
                  ),
            ),
            Container(
              width: size.width * 0.6,
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PageContainer(),
                  ),
                ),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app),
                    Text('  Log out'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
