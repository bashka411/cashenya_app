import 'package:cashenya_app/app_bloc/app_bloc.dart';
import 'package:cashenya_app/features/home/ui/home_page.dart';
import 'package:cashenya_app/features/login/ui/login_page.dart';
import 'package:flutter/material.dart';


List<Page> onGenerateAppViewPages(
  AuthStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AuthStatus.authenticated:
      return [HomePage.page()];
    case AuthStatus.unauthenticated:
      return [LogInPage.page()];
  }
}
