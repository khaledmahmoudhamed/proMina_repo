import 'dart:io';

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
      {String? email, String? password, required BuildContext context}) async {
    try {
      emit(AppLoadingState());
      var response = await dioHelper.postData(
          endPoint: endPoint, data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        emit(SuccessUserLoginState());
        for (int i = 0; i < response.data['item'].length; i++) {
          if (response.data['item'][i]['name'] == 'Login') {
            print("################## Login ####################");
            var newResponse =
                response.data['item'][i]['request']['body']['formdata'];
            if (newResponse[i]['key'] == 'email' ||
                newResponse[i]['key'] == 'password') {
              if (newResponse[i]['value'] == email) {
                print("vaild email");
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const GalleryScreen()),
                  (route) => false,
                );
              } else if (newResponse[i]['value'] == password) {
                print("vaild password");
              } else {
                print("not valid email or password");
                return showMyDialog(
                    context: context,
                    title: const Text('Error'),
                    line1: const Text('invalid email or password.'),
                    line2: const Text('please enter valid email or password '),
                    okButton: const Text("ok"));
              }
            }
          } else {
            print(
                "############### ${response.data['item'][i]['name']} #######################");
          }
        }
      } else {
        emit(FailedUserLoginState());
        print("################ ${response.statusMessage}");
      }
    } catch (e) {
      emit(ErrorUserLoginState());
      rethrow;
    }
  }

  File? file;
  ImagePicker imagePicker = ImagePicker();
  pickImage({required ImageSource source}) async {
    var pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      emit(ImageUploadingSuccessfullyState());
    }
    return null;
  }

  List images = [];
  uploadImage({
    required BuildContext context,
  }) async {
    try {
      emit(ImageLoadingState());
      var response = await dioHelper.postData(
        endPoint: endPoint,
      );
      if (response.statusCode == 200) {
        emit(ImageUploadingSuccessfullyState());
        for (int i = 0; i < response.data['item'].length; i++) {
          if (response.data['item'][i]['name'] == 'Upload Image') {
            var newResponse =
                response.data['item'][i]['request']['body']['formdata'];
            Map<String, dynamic> imageData = {
              "key": "img",
              "type": 'file',
              "src": file!.path
            };
            images.add(imageData);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Text("Image Uploaded Successfully"),
                  );
                });
            images = newResponse;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const GalleryScreen()),
              (route) => false,
            );
            return newResponse;
          } else {
            print("########################## ");
          }
        }
      } else {
        emit(FailedImageUploadingState());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  color: Colors.grey,
                  child: Text("Failed To Uploaded Image"),
                ),
              );
            });
        print("################ ${response.statusMessage}");
      }
    } catch (e) {
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
