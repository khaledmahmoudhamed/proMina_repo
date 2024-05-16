import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina/controller/cubit/app_cubit.dart';

import '../reusable_widgets/reused_button.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
        backgroundColor: const Color(0xFFEBE1FF),
        body: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                if (state is ImageLoadingState) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else if (state is ImageUploadingSuccessfullyState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 30.w),
                            child: Text(
                              "Welcome\nMina",
                              style: TextStyle(fontSize: 25.sp),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(140.r)),
                              color: const Color(0xFFDECFFF),
                            ),
                            alignment: Alignment.center,
                            height: 200.h,
                            width: 170.w,
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundImage:
                                  const AssetImage('assets/khaled.jpeg'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            reusedButton(
                                borderColor: Colors.white,
                                fontSize: 14.sp,
                                child: '  Logout',
                                backGroundColor: Colors.white,
                                widget: Container(
                                    height: 26.h,
                                    width: 24.h,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDC4040),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.white,
                                      size: 25.r,
                                    )),
                                onTap: () {},
                                width: 130.w,
                                fontColor: Colors.black.withOpacity(0.7),
                                radius: 30.r),
                            reusedButton(
                                borderColor: Colors.white,
                                radius: 30.r,
                                child: '  Upload',
                                backGroundColor: Colors.white,
                                onTap: () {
                                  cubit.showMyDialog(
                                      context: context,
                                      line1: reusedButton(
                                          child: '   Gallery',
                                          backGroundColor:
                                              const Color(0xFFEFD8F9),
                                          width: 60.w,
                                          widget: Icon(
                                            Icons.image,
                                            color: const Color(0xFFC678EE),
                                            size: 30.r,
                                          ),
                                          fontSize: 16.sp,
                                          fontColor:
                                              Colors.black.withOpacity(0.7),
                                          borderColor: const Color(0xFFEFD8F9),
                                          radius: 30.r,
                                          onTap: () {
                                            cubit.pickImage(
                                                source: ImageSource.gallery);
                                            cubit.uploadImage(
                                              context: context,
                                            );
                                          }),
                                      line2: reusedButton(
                                          child: '   Camera',
                                          backGroundColor:
                                              const Color(0xFFEBF6FF),
                                          width: 60.w,
                                          widget: Icon(
                                            Icons.camera_alt,
                                            color: const Color(0xFFC678EE),
                                            size: 30.r,
                                          ),
                                          fontSize: 16.sp,
                                          fontColor:
                                              Colors.black.withOpacity(0.7),
                                          borderColor: const Color(0xFFEFD8F9),
                                          radius: 30.r,
                                          onTap: () {
                                            cubit.pickImage(
                                                source: ImageSource.camera);
                                            cubit.uploadImage(context: context);
                                          }),
                                      okButton: const SizedBox());
                                },
                                width: 130.w,
                                fontSize: 14.sp,
                                widget: Container(
                                    height: 26.h,
                                    width: 24.h,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFFF9900),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Icon(
                                      Icons.upload,
                                      color: Colors.white,
                                      size: 25.r,
                                    )),
                                fontColor: Colors.black.withOpacity(0.7)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: GridView.builder(
                          itemCount: cubit.images.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return cubit.file != null
                                ? SizedBox(
                                    height: 60.h,
                                    width: 0.w,
                                    child: Image.file(cubit.file!))
                                : const SizedBox();
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: AlertDialog(
                      content: Text("Error"),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
