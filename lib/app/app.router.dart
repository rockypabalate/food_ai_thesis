// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i29;
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/ai_processing/ai_processing_view.dart'
    as _i26;
import 'package:food_ai_thesis/ui/views/check_auth/check_auth_view.dart'
    as _i11;
import 'package:food_ai_thesis/ui/views/create_recipe/create_recipe_view.dart'
    as _i22;
import 'package:food_ai_thesis/ui/views/dashboard_recipes/dashboard_recipes_view.dart'
    as _i10;
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart'
    as _i16;
import 'package:food_ai_thesis/ui/views/edit_profile/edit_profile_view.dart'
    as _i18;
import 'package:food_ai_thesis/ui/views/feedback/feedback_view.dart' as _i28;
import 'package:food_ai_thesis/ui/views/home/home_view.dart' as _i2;
import 'package:food_ai_thesis/ui/views/image_classification/image_classification_view.dart'
    as _i19;
import 'package:food_ai_thesis/ui/views/image_processing/image_processing_view.dart'
    as _i9;
import 'package:food_ai_thesis/ui/views/login/login_view.dart' as _i4;
import 'package:food_ai_thesis/ui/views/loginregister/loginregister_view.dart'
    as _i25;
import 'package:food_ai_thesis/ui/views/mainpage/mainpage_view.dart' as _i6;
import 'package:food_ai_thesis/ui/views/my_profile/my_profile_view.dart' as _i8;
import 'package:food_ai_thesis/ui/views/post_recipe/post_recipe_view.dart'
    as _i7;
import 'package:food_ai_thesis/ui/views/register/register_view.dart' as _i5;
import 'package:food_ai_thesis/ui/views/seeall_featured_recipes/seeall_featured_recipes_view.dart'
    as _i14;
import 'package:food_ai_thesis/ui/views/seeall_filipino_recipes/seeall_filipino_recipes_view.dart'
    as _i13;
import 'package:food_ai_thesis/ui/views/seeall_liked_viewed_recipes/seeall_liked_viewed_recipes_view.dart'
    as _i15;
import 'package:food_ai_thesis/ui/views/setting_page/setting_page_view.dart'
    as _i27;
import 'package:food_ai_thesis/ui/views/sign_in/sign_in_view.dart' as _i20;
import 'package:food_ai_thesis/ui/views/sign_up/sign_up_view.dart' as _i21;
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/single_view_page_recipe_view.dart'
    as _i24;
import 'package:food_ai_thesis/ui/views/startup/startup_view.dart' as _i3;
import 'package:food_ai_thesis/ui/views/upload_recipe_image/upload_recipe_image_view.dart'
    as _i23;
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_view.dart'
    as _i17;
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/widget_search_allrecipes_view.dart'
    as _i12;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i30;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const mainpageView = '/mainpage-view';

  static const postRecipeView = '/post-recipe-view';

  static const myProfileView = '/my-profile-view';

  static const imageProcessingView = '/image-processing-view';

  static const dashboardRecipesView = '/dashboard-recipes-view';

  static const checkAuthView = '/';

  static const widgetSearchAllrecipesView = '/widget-search-allrecipes-view';

  static const seeallFilipinoRecipesView = '/seeall-filipino-recipes-view';

  static const seeallFeaturedRecipesView = '/seeall-featured-recipes-view';

  static const seeallLikedViewedRecipesView =
      '/seeall-liked-viewed-recipes-view';

  static const displaySingleRecipeView = '/display-single-recipe-view';

  static const userDashboardView = '/user-dashboard-view';

  static const editProfileView = '/edit-profile-view';

  static const imageClassificationView = '/image-classification-view';

  static const signInView = '/sign-in-view';

  static const signUpView = '/sign-up-view';

  static const createRecipeView = '/create-recipe-view';

  static const uploadRecipeImageView = '/upload-recipe-image-view';

  static const singleViewPageRecipeView = '/single-view-page-recipe-view';

  static const loginregisterView = '/loginregister-view';

  static const aiProcessingView = '/ai-processing-view';

  static const settingPageView = '/setting-page-view';

  static const feedbackView = '/feedback-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    registerView,
    mainpageView,
    postRecipeView,
    myProfileView,
    imageProcessingView,
    dashboardRecipesView,
    checkAuthView,
    widgetSearchAllrecipesView,
    seeallFilipinoRecipesView,
    seeallFeaturedRecipesView,
    seeallLikedViewedRecipesView,
    displaySingleRecipeView,
    userDashboardView,
    editProfileView,
    imageClassificationView,
    signInView,
    signUpView,
    createRecipeView,
    uploadRecipeImageView,
    singleViewPageRecipeView,
    loginregisterView,
    aiProcessingView,
    settingPageView,
    feedbackView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i5.RegisterView,
    ),
    _i1.RouteDef(
      Routes.mainpageView,
      page: _i6.MainpageView,
    ),
    _i1.RouteDef(
      Routes.postRecipeView,
      page: _i7.PostRecipeView,
    ),
    _i1.RouteDef(
      Routes.myProfileView,
      page: _i8.MyProfileView,
    ),
    _i1.RouteDef(
      Routes.imageProcessingView,
      page: _i9.ImageProcessingView,
    ),
    _i1.RouteDef(
      Routes.dashboardRecipesView,
      page: _i10.DashboardRecipesView,
    ),
    _i1.RouteDef(
      Routes.checkAuthView,
      page: _i11.CheckAuthView,
    ),
    _i1.RouteDef(
      Routes.widgetSearchAllrecipesView,
      page: _i12.WidgetSearchAllrecipesView,
    ),
    _i1.RouteDef(
      Routes.seeallFilipinoRecipesView,
      page: _i13.SeeallFilipinoRecipesView,
    ),
    _i1.RouteDef(
      Routes.seeallFeaturedRecipesView,
      page: _i14.SeeallFeaturedRecipesView,
    ),
    _i1.RouteDef(
      Routes.seeallLikedViewedRecipesView,
      page: _i15.SeeallLikedViewedRecipesView,
    ),
    _i1.RouteDef(
      Routes.displaySingleRecipeView,
      page: _i16.DisplaySingleRecipeView,
    ),
    _i1.RouteDef(
      Routes.userDashboardView,
      page: _i17.UserDashboardView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i18.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.imageClassificationView,
      page: _i19.ImageClassificationView,
    ),
    _i1.RouteDef(
      Routes.signInView,
      page: _i20.SignInView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i21.SignUpView,
    ),
    _i1.RouteDef(
      Routes.createRecipeView,
      page: _i22.CreateRecipeView,
    ),
    _i1.RouteDef(
      Routes.uploadRecipeImageView,
      page: _i23.UploadRecipeImageView,
    ),
    _i1.RouteDef(
      Routes.singleViewPageRecipeView,
      page: _i24.SingleViewPageRecipeView,
    ),
    _i1.RouteDef(
      Routes.loginregisterView,
      page: _i25.LoginregisterView,
    ),
    _i1.RouteDef(
      Routes.aiProcessingView,
      page: _i26.AiProcessingView,
    ),
    _i1.RouteDef(
      Routes.settingPageView,
      page: _i27.SettingPageView,
    ),
    _i1.RouteDef(
      Routes.feedbackView,
      page: _i28.FeedbackView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i29.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i4.LoginView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeftWithFade,
        transitionDuration: const Duration(milliseconds: 700),
      );
    },
    _i5.RegisterView: (data) {
      return _i29.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.RegisterView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeftWithFade,
        transitionDuration: const Duration(milliseconds: 700),
      );
    },
    _i6.MainpageView: (data) {
      return _i29.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i6.MainpageView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 800),
      );
    },
    _i7.PostRecipeView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.PostRecipeView(),
        settings: data,
      );
    },
    _i8.MyProfileView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.MyProfileView(),
        settings: data,
      );
    },
    _i9.ImageProcessingView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ImageProcessingView(),
        settings: data,
      );
    },
    _i10.DashboardRecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.DashboardRecipesView(),
        settings: data,
      );
    },
    _i11.CheckAuthView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.CheckAuthView(),
        settings: data,
      );
    },
    _i12.WidgetSearchAllrecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.WidgetSearchAllrecipesView(),
        settings: data,
      );
    },
    _i13.SeeallFilipinoRecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.SeeallFilipinoRecipesView(),
        settings: data,
      );
    },
    _i14.SeeallFeaturedRecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.SeeallFeaturedRecipesView(),
        settings: data,
      );
    },
    _i15.SeeallLikedViewedRecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.SeeallLikedViewedRecipesView(),
        settings: data,
      );
    },
    _i16.DisplaySingleRecipeView: (data) {
      final args =
          data.getArgs<DisplaySingleRecipeViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.DisplaySingleRecipeView(key: args.key, foodId: args.foodId),
        settings: data,
      );
    },
    _i17.UserDashboardView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.UserDashboardView(),
        settings: data,
      );
    },
    _i18.EditProfileView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.EditProfileView(),
        settings: data,
      );
    },
    _i19.ImageClassificationView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.ImageClassificationView(),
        settings: data,
      );
    },
    _i20.SignInView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.SignInView(),
        settings: data,
      );
    },
    _i21.SignUpView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.SignUpView(),
        settings: data,
      );
    },
    _i22.CreateRecipeView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.CreateRecipeView(),
        settings: data,
      );
    },
    _i23.UploadRecipeImageView: (data) {
      final args = data.getArgs<UploadRecipeImageViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.UploadRecipeImageView(key: args.key, recipeId: args.recipeId),
        settings: data,
      );
    },
    _i24.SingleViewPageRecipeView: (data) {
      final args =
          data.getArgs<SingleViewPageRecipeViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.SingleViewPageRecipeView(
            key: args.key, recipeId: args.recipeId),
        settings: data,
      );
    },
    _i25.LoginregisterView: (data) {
      return _i29.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i25.LoginregisterView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 700),
      );
    },
    _i26.AiProcessingView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.AiProcessingView(),
        settings: data,
      );
    },
    _i27.SettingPageView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.SettingPageView(),
        settings: data,
      );
    },
    _i28.FeedbackView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i28.FeedbackView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DisplaySingleRecipeViewArguments {
  const DisplaySingleRecipeViewArguments({
    this.key,
    required this.foodId,
  });

  final _i29.Key? key;

  final int foodId;

  @override
  String toString() {
    return '{"key": "$key", "foodId": "$foodId"}';
  }

  @override
  bool operator ==(covariant DisplaySingleRecipeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.foodId == foodId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ foodId.hashCode;
  }
}

class UploadRecipeImageViewArguments {
  const UploadRecipeImageViewArguments({
    this.key,
    required this.recipeId,
  });

  final _i29.Key? key;

  final int recipeId;

  @override
  String toString() {
    return '{"key": "$key", "recipeId": "$recipeId"}';
  }

  @override
  bool operator ==(covariant UploadRecipeImageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ recipeId.hashCode;
  }
}

class SingleViewPageRecipeViewArguments {
  const SingleViewPageRecipeViewArguments({
    this.key,
    required this.recipeId,
  });

  final _i29.Key? key;

  final String recipeId;

  @override
  String toString() {
    return '{"key": "$key", "recipeId": "$recipeId"}';
  }

  @override
  bool operator ==(covariant SingleViewPageRecipeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ recipeId.hashCode;
  }
}

extension NavigatorStateExtension on _i30.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainpageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainpageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPostRecipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.postRecipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToImageProcessingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.imageProcessingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCheckAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.checkAuthView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWidgetSearchAllrecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.widgetSearchAllrecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSeeallFilipinoRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.seeallFilipinoRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSeeallFeaturedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.seeallFeaturedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSeeallLikedViewedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.seeallLikedViewedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDisplaySingleRecipeView({
    _i29.Key? key,
    required int foodId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.displaySingleRecipeView,
        arguments: DisplaySingleRecipeViewArguments(key: key, foodId: foodId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUserDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.userDashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToImageClassificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.imageClassificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignInView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signInView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateRecipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createRecipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUploadRecipeImageView({
    _i29.Key? key,
    required int recipeId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.uploadRecipeImageView,
        arguments: UploadRecipeImageViewArguments(key: key, recipeId: recipeId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSingleViewPageRecipeView({
    _i29.Key? key,
    required String recipeId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.singleViewPageRecipeView,
        arguments:
            SingleViewPageRecipeViewArguments(key: key, recipeId: recipeId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginregisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginregisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAiProcessingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.aiProcessingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingPageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.feedbackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainpageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainpageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPostRecipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.postRecipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithImageProcessingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.imageProcessingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCheckAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.checkAuthView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWidgetSearchAllrecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.widgetSearchAllrecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSeeallFilipinoRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.seeallFilipinoRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSeeallFeaturedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.seeallFeaturedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSeeallLikedViewedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.seeallLikedViewedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDisplaySingleRecipeView({
    _i29.Key? key,
    required int foodId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.displaySingleRecipeView,
        arguments: DisplaySingleRecipeViewArguments(key: key, foodId: foodId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUserDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.userDashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithImageClassificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.imageClassificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignInView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signInView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateRecipeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createRecipeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUploadRecipeImageView({
    _i29.Key? key,
    required int recipeId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.uploadRecipeImageView,
        arguments: UploadRecipeImageViewArguments(key: key, recipeId: recipeId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSingleViewPageRecipeView({
    _i29.Key? key,
    required String recipeId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.singleViewPageRecipeView,
        arguments:
            SingleViewPageRecipeViewArguments(key: key, recipeId: recipeId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginregisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginregisterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAiProcessingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.aiProcessingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingPageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingPageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.feedbackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
