import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_mina/controller/cubit/app_cubit.dart';
import 'package:pro_mina/view/reusable_widgets/text_form_field.dart';

import '../reusable_widgets/reused_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6A4E1),
              Color(0xFFF8E8F7),
              Color(0xFFDDCDFF),
              Color(0xFFFFDB9C),
              Color(0xFFFBC3C3),
              Color(0xFFF8BBBB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 50.h,
                      left: 100.w,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40.r,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 80.h, left: 60.w),
                      child: Transform.rotate(
                        angle: -0.3,
                        child: Image.asset(
                          'assets/camera.png',
                          width: 80.w,
                          height: 80.h,
                          color: const Color(0xFF77A1DE),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                    child: Text(
                  "    My\nGallery",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)),
                )),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    if (state is AppLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessUserLoginState) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          height: 350.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Column(
                            children: [
                              Text(
                                "LOG IN",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              textForm(
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false,
                                  validator: (val) {
                                    if (emailController.text.isEmpty) {
                                      return "required field";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  hintText: 'email'),
                              SizedBox(
                                height: 15.h,
                              ),
                              textForm(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: hidden,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidden = !hidden;
                                      });
                                    },
                                    icon: hidden == true
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(
                                            Icons.remove_red_eye_outlined),
                                  ),
                                  validator: (val) {
                                    if (passwordController.text.length < 8) {
                                      return 'password must not be less 8 char';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  hintText: 'Password'),
                              SizedBox(
                                height: 25.h,
                              ),
                              reusedButton(
                                  borderColor: Colors.blue,
                                  radius: 15.r,
                                  width: double.infinity,
                                  widget: const SizedBox(),
                                  child: 'SUBMIT',
                                  backGroundColor: Colors.blue,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.loginData(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  fontSize: 20.sp,
                                  fontColor: Colors.white.withOpacity(0.8)),
                            ],
                          ),
                        ),
                      );
                    } else if (state is FailedImageUploadingState) {
                      return const AlertDialog(
                        content: Text("There is Something Went Wrong"),
                      );
                    } else {
                      return const AlertDialog(
                        content: Center(child: Text("Error")),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
