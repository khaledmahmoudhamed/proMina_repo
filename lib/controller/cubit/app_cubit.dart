import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina/controller/data/remote/dio_helper.dart';
import 'package:pro_mina/controller/data/remote/end_point.dart';

import '../../view/screens/gallery_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();
  loginData(
      {String? email,
      String password = 'password',
      required BuildContext context}) async {
    try {
      emit(AppLoadingState());
      Response response = await dioHelper.postData(
          endPoint: endPoint, data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        emit(UserLoginSuccessState());
        print(
            "####################### ${response.statusCode} ####################");
        for (int i = 0; i < response.data['item'].length; i++) {
          if (response.data['item'][i]['name'] == 'Login') {
            var newResponse =
                response.data['item'][i]['request']['body']['formdata'];
            if (newResponse[i]['key'] == 'email') {
              if (newResponse[i]['value'] == email) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GalleryScreen()));
              } else {
                print("not valid email or password");
                return AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  descTextStyle:
                      TextStyle(fontSize: 18.sp, color: Colors.white),
                  desc: 'not valid email or password',
                  dialogBackgroundColor: Colors.green.withOpacity(0.1),
                )..show();
              }
              emit(UserLoginSuccessState());
            }
          } else {
            print(
                "############### ${response.data['item'][i]['name']} #######################");
          }
        }
      } else {
        print("################ ${response.statusMessage}");
        emit(UserLoginFailedState());
      }
    } catch (e) {
      rethrow;
    }
  }

  File? file;
  ImagePicker imagePicker = ImagePicker();
  pickImageFromGallery({required ImageSource source}) async {
    var pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      emit(ImageUploadingSuccessfullyState());
    }
    return null;
  }

  List imageResponse = [];
  Future<List> uploadImage({
    required BuildContext context,
  }) async {
    try {
      emit(ImageLoadingState());
      var response = await dioHelper.postData(
        endPoint: endPoint,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> images = {
          "key": "img",
          "type": "file",
          "src": file
        };
        imageResponse.add(images);
        emit(ImageUploadingSuccessfullyState());
        print("################### image response $imageResponse");
        /* Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const GalleryScreen()));*/
      } else {
        emit(FailedImageUploadingState());

        print("################ ${response.statusMessage}");
      }
      return imageResponse;
    } catch (e) {
      print(" ############################ Rethrow Error");
      rethrow;
    }
  }

  Future<void> showMyDialog(
      {required BuildContext context,
      Widget? title,
      required Widget line1,
      required Widget line2,
      required Widget okButton}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.3),
          title: title,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 50.h,
                ),
                line1,
                SizedBox(
                  height: 15.h,
                ),
                line2
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: okButton,
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
