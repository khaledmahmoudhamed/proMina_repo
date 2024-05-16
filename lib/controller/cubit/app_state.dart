part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppLoadingState extends AppState {}

final class SuccessUserLoginState extends AppState {}

final class FailedUserLoginState extends AppState {}

final class ErrorUserLoginState extends AppState {}

final class ImageLoadingState extends AppState {}

final class ImageUploadingSuccessfullyState extends AppState {}

final class FailedImageUploadingState extends AppState {}
