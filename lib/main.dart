import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_mina/controller/cubit/app_cubit.dart';
import 'package:pro_mina/view/screens/login.dart';

import 'controller/data/remote/dio_helper.dart';

void main() {
  runApp(const MyApp());
  DioHelper.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setState(() {
      AppCubit cubit = AppCubit()..loginData(context: context);
      cubit.uploadImage(context: context);
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..loginData(context: context)
        ..uploadImage(
          context: context,
        ),
      child: ScreenUtilInit(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const LoginScreen()),
      ),
    );
  }
}
