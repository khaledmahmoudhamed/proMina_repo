part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class AppLoadingState extends AppState {}

final class UserLoginSuccessState extends AppState {}

final class FailedUserLoginState extends AppState {}

final class UserLoginFailedState extends AppState {}

final class ImageLoadingState extends AppState {}

final class ImageUploadingSuccessfullyState extends AppState {}

final class FailedImageUploadingState extends AppState {}
