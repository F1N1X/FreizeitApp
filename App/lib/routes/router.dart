import 'package:auto_route/auto_route.dart';
import 'package:freizeit_app/praesentation/citymap/citymap.dart';
import 'package:freizeit_app/praesentation/event_finder/eventfinder_init_page.dart';
import 'package:freizeit_app/praesentation/event_finder/eventfinder_loading_results.dart';
import 'package:freizeit_app/praesentation/event_message/eventmessage_start.dart';
import 'package:freizeit_app/praesentation/eventcreation/event_creation.dart';
import 'package:freizeit_app/praesentation/eventcreation/event_creation_from_start.dart';
import 'package:freizeit_app/praesentation/login_splash/logincheck_splash.dart';
import 'package:freizeit_app/praesentation/personalevent/personalevents.dart';
import 'package:freizeit_app/praesentation/startpage/startpage.dart';
import 'package:freizeit_app/praesentation/update_event/update_event.dart';
import 'package:freizeit_app/praesentation/welcome_screen/welcome_page.dart';
import 'package:freizeit_app/praesentation/welcome_screen/welcome_screen.dart';

import '../praesentation/event_detail/event_detail_page.dart';
import '../praesentation/login/widgets/login_page.dart';
import '../praesentation/register/register_page_start.dart';
import '../praesentation/verifyemail/verification_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: InitFinder, initial: false),
  AutoRoute(page: LoadingEventFinder, initial: false),
  AutoRoute(page: InitialEventUpdate, initial: false),
  AutoRoute(page: CityPage, initial: false),
  AutoRoute(page: EventCreationPage, initial: false),
  AutoRoute(page: WelcomeScreen, initial: false),
  AutoRoute(page: LoginPage, initial: false),
  AutoRoute(page: WelcomePage, initial: false),
  AutoRoute(page: EventDetail, initial: false),
  AutoRoute(page: EventMessagesPage, initial: false),
  AutoRoute(page: EventCreationFromWelcome, initial: false),
  AutoRoute(page: LoginSplashPage, initial: true),
  AutoRoute(page: PersonalEventPage, initial: false, fullscreenDialog: true),
  AutoRoute(page: VerificationPage, initial: false),
  AutoRoute(page: RegisterPage, initial: false),
  AutoRoute(page: StartPage, initial: false),
  AutoRoute(page: EventCreationFromWelcome, initial: false),
])
class $AppRouter {}
//flutter packages pub run build_runner build     