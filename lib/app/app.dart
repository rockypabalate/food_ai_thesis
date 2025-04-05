import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_service_impl.dart';
import 'package:food_ai_thesis/services/api/shared_preferences/shared_preference_impl.dart';
import 'package:food_ai_thesis/services/api/shared_preferences/shared_preference_service.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_impl.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:food_ai_thesis/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:food_ai_thesis/ui/views/home/home_view.dart';
import 'package:food_ai_thesis/ui/views/sign_up/sign_up_view.dart';
import 'package:food_ai_thesis/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:food_ai_thesis/ui/views/login/login_view.dart';
import 'package:food_ai_thesis/ui/views/register/register_view.dart';
import 'package:food_ai_thesis/ui/views/mainpage/mainpage_view.dart';
import 'package:food_ai_thesis/ui/views/post_recipe/post_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/my_profile/my_profile_view.dart';
import 'package:food_ai_thesis/ui/views/image_processing/image_processing_view.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/dashboard_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/check_auth/check_auth_view.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/widget_search_allrecipes_view.dart';
import 'package:food_ai_thesis/ui/views/seeall_filipino_recipes/seeall_filipino_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/seeall_featured_recipes/seeall_featured_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/seeall_liked_viewed_recipes/seeall_liked_viewed_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_view.dart';
import 'package:food_ai_thesis/ui/views/edit_profile/edit_profile_view.dart';
import 'package:food_ai_thesis/ui/views/image_classification/image_classification_view.dart';
import 'package:food_ai_thesis/ui/views/sign_in/sign_in_view.dart';
import 'package:food_ai_thesis/ui/views/create_recipe/create_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/upload_recipe_image/upload_recipe_image_view.dart';

import 'package:food_ai_thesis/ui/views/single_view_page_recipe/single_view_page_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/loginregister/loginregister_view.dart';
import 'package:food_ai_thesis/ui/views/ai_processing/ai_processing_view.dart';
import 'package:food_ai_thesis/ui/views/setting_page/setting_page_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),

    CustomRoute(
      page: LoginView,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 500,
    ),
    CustomRoute(
      page: RegisterView,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 500,
    ),
    CustomRoute(
      page: MainpageView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 500,
    ),
    MaterialRoute(page: PostRecipeView),
    MaterialRoute(page: MyProfileView),
    MaterialRoute(page: ImageProcessingView),
    MaterialRoute(page: DashboardRecipesView),
    MaterialRoute(page: CheckAuthView, initial: true),
    MaterialRoute(page: WidgetSearchAllrecipesView),
    MaterialRoute(page: SeeallFilipinoRecipesView),
    MaterialRoute(page: SeeallFeaturedRecipesView),
    MaterialRoute(page: SeeallLikedViewedRecipesView),
    MaterialRoute(page: DisplaySingleRecipeView),
    MaterialRoute(page: UserDashboardView),
    MaterialRoute(page: EditProfileView),
    MaterialRoute(page: ImageClassificationView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: CreateRecipeView),
    MaterialRoute(page: UploadRecipeImageView),

    MaterialRoute(page: SingleViewPageRecipeView),
    CustomRoute(
      page: LoginregisterView,
      transitionsBuilder: TransitionsBuilders.zoomIn,
      durationInMilliseconds: 500,
    ),
    MaterialRoute(page: AiProcessingView),
    MaterialRoute(page: SettingPageView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: ApiServiceImpl, asType: ApiServiceService),
    LazySingleton(classType: AuthServiceImpl, asType: AuthApiService),
    LazySingleton(
        classType: SharedPreferenceServiceImpl,
        asType: SharedPreferenceService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
