// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i20;

import '../Model/event.dart' as _i19;
import '../praesentation/citymap/citymap.dart' as _i4;
import '../praesentation/event_detail/event_detail_page.dart' as _i9;
import '../praesentation/event_finder/eventfinder_init_page.dart' as _i1;
import '../praesentation/event_finder/eventfinder_loading_results.dart' as _i2;
import '../praesentation/event_message/eventmessage_start.dart' as _i10;
import '../praesentation/eventcreation/event_creation.dart' as _i5;
import '../praesentation/eventcreation/event_creation_from_start.dart' as _i11;
import '../praesentation/login/widgets/login_page.dart' as _i7;
import '../praesentation/login_splash/logincheck_splash.dart' as _i12;
import '../praesentation/personalevent/personalevents.dart' as _i13;
import '../praesentation/register/register_page_start.dart' as _i15;
import '../praesentation/startpage/startpage.dart' as _i16;
import '../praesentation/update_event/update_event.dart' as _i3;
import '../praesentation/verifyemail/verification_page.dart' as _i14;
import '../praesentation/welcome_screen/welcome_page.dart' as _i6;
import '../praesentation/welcome_screen/welcome_screen.dart' as _i8;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    InitFinderRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.InitFinder(),
      );
    },
    LoadingEventFinderRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingEventFinderRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoadingEventFinder(
          key: args.key,
          eventList: args.eventList,
        ),
      );
    },
    InitialEventUpdateRoute.name: (routeData) {
      final args = routeData.argsAs<InitialEventUpdateRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.InitialEventUpdate(
          key: args.key,
          event: args.event,
        ),
      );
    },
    CityPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.CityPage(),
      );
    },
    EventCreationPageRoute.name: (routeData) {
      final args = routeData.argsAs<EventCreationPageRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.EventCreationPage(
          key: args.key,
          event: args.event,
          position: args.position,
        ),
      );
    },
    WelcomeScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.WelcomeScreen(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    WelcomePageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.WelcomePage(),
      );
    },
    EventDetailRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.EventDetail(
          key: args.key,
          event: args.event,
        ),
      );
    },
    EventMessagesPageRoute.name: (routeData) {
      final args = routeData.argsAs<EventMessagesPageRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.EventMessagesPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    EventCreationFromWelcomeRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.EventCreationFromWelcome(),
      );
    },
    LoginSplashPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.LoginSplashPage(),
      );
    },
    PersonalEventPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.PersonalEventPage(),
        fullscreenDialog: true,
      );
    },
    VerificationPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.VerificationPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.RegisterPage(),
      );
    },
    StartPageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.StartPage(),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          InitFinderRoute.name,
          path: '/init-finder',
        ),
        _i17.RouteConfig(
          LoadingEventFinderRoute.name,
          path: '/loading-event-finder',
        ),
        _i17.RouteConfig(
          InitialEventUpdateRoute.name,
          path: '/initial-event-update',
        ),
        _i17.RouteConfig(
          CityPageRoute.name,
          path: '/city-page',
        ),
        _i17.RouteConfig(
          EventCreationPageRoute.name,
          path: '/event-creation-page',
        ),
        _i17.RouteConfig(
          WelcomeScreenRoute.name,
          path: '/welcome-screen',
        ),
        _i17.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i17.RouteConfig(
          WelcomePageRoute.name,
          path: '/welcome-page',
        ),
        _i17.RouteConfig(
          EventDetailRoute.name,
          path: '/event-detail',
        ),
        _i17.RouteConfig(
          EventMessagesPageRoute.name,
          path: '/event-messages-page',
        ),
        _i17.RouteConfig(
          EventCreationFromWelcomeRoute.name,
          path: '/event-creation-from-welcome',
        ),
        _i17.RouteConfig(
          LoginSplashPageRoute.name,
          path: '/',
        ),
        _i17.RouteConfig(
          PersonalEventPageRoute.name,
          path: '/personal-event-page',
        ),
        _i17.RouteConfig(
          VerificationPageRoute.name,
          path: '/verification-page',
        ),
        _i17.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i17.RouteConfig(
          StartPageRoute.name,
          path: '/start-page',
        ),
        _i17.RouteConfig(
          EventCreationFromWelcomeRoute.name,
          path: '/event-creation-from-welcome',
        ),
      ];
}

/// generated route for
/// [_i1.InitFinder]
class InitFinderRoute extends _i17.PageRouteInfo<void> {
  const InitFinderRoute()
      : super(
          InitFinderRoute.name,
          path: '/init-finder',
        );

  static const String name = 'InitFinderRoute';
}

/// generated route for
/// [_i2.LoadingEventFinder]
class LoadingEventFinderRoute
    extends _i17.PageRouteInfo<LoadingEventFinderRouteArgs> {
  LoadingEventFinderRoute({
    _i18.Key? key,
    required List<_i19.Event> eventList,
  }) : super(
          LoadingEventFinderRoute.name,
          path: '/loading-event-finder',
          args: LoadingEventFinderRouteArgs(
            key: key,
            eventList: eventList,
          ),
        );

  static const String name = 'LoadingEventFinderRoute';
}

class LoadingEventFinderRouteArgs {
  const LoadingEventFinderRouteArgs({
    this.key,
    required this.eventList,
  });

  final _i18.Key? key;

  final List<_i19.Event> eventList;

  @override
  String toString() {
    return 'LoadingEventFinderRouteArgs{key: $key, eventList: $eventList}';
  }
}

/// generated route for
/// [_i3.InitialEventUpdate]
class InitialEventUpdateRoute
    extends _i17.PageRouteInfo<InitialEventUpdateRouteArgs> {
  InitialEventUpdateRoute({
    _i18.Key? key,
    required _i19.Event event,
  }) : super(
          InitialEventUpdateRoute.name,
          path: '/initial-event-update',
          args: InitialEventUpdateRouteArgs(
            key: key,
            event: event,
          ),
        );

  static const String name = 'InitialEventUpdateRoute';
}

class InitialEventUpdateRouteArgs {
  const InitialEventUpdateRouteArgs({
    this.key,
    required this.event,
  });

  final _i18.Key? key;

  final _i19.Event event;

  @override
  String toString() {
    return 'InitialEventUpdateRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [_i4.CityPage]
class CityPageRoute extends _i17.PageRouteInfo<void> {
  const CityPageRoute()
      : super(
          CityPageRoute.name,
          path: '/city-page',
        );

  static const String name = 'CityPageRoute';
}

/// generated route for
/// [_i5.EventCreationPage]
class EventCreationPageRoute
    extends _i17.PageRouteInfo<EventCreationPageRouteArgs> {
  EventCreationPageRoute({
    _i18.Key? key,
    required _i19.Event? event,
    required _i20.LatLng position,
  }) : super(
          EventCreationPageRoute.name,
          path: '/event-creation-page',
          args: EventCreationPageRouteArgs(
            key: key,
            event: event,
            position: position,
          ),
        );

  static const String name = 'EventCreationPageRoute';
}

class EventCreationPageRouteArgs {
  const EventCreationPageRouteArgs({
    this.key,
    required this.event,
    required this.position,
  });

  final _i18.Key? key;

  final _i19.Event? event;

  final _i20.LatLng position;

  @override
  String toString() {
    return 'EventCreationPageRouteArgs{key: $key, event: $event, position: $position}';
  }
}

/// generated route for
/// [_i6.WelcomeScreen]
class WelcomeScreenRoute extends _i17.PageRouteInfo<void> {
  const WelcomeScreenRoute()
      : super(
          WelcomeScreenRoute.name,
          path: '/welcome-screen',
        );

  static const String name = 'WelcomeScreenRoute';
}

/// generated route for
/// [_i7.LoginPage]
class LoginPageRoute extends _i17.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i8.WelcomePage]
class WelcomePageRoute extends _i17.PageRouteInfo<void> {
  const WelcomePageRoute()
      : super(
          WelcomePageRoute.name,
          path: '/welcome-page',
        );

  static const String name = 'WelcomePageRoute';
}

/// generated route for
/// [_i9.EventDetail]
class EventDetailRoute extends _i17.PageRouteInfo<EventDetailRouteArgs> {
  EventDetailRoute({
    _i18.Key? key,
    required _i19.Event? event,
  }) : super(
          EventDetailRoute.name,
          path: '/event-detail',
          args: EventDetailRouteArgs(
            key: key,
            event: event,
          ),
        );

  static const String name = 'EventDetailRoute';
}

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    this.key,
    required this.event,
  });

  final _i18.Key? key;

  final _i19.Event? event;

  @override
  String toString() {
    return 'EventDetailRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [_i10.EventMessagesPage]
class EventMessagesPageRoute
    extends _i17.PageRouteInfo<EventMessagesPageRouteArgs> {
  EventMessagesPageRoute({
    _i18.Key? key,
    required String id,
  }) : super(
          EventMessagesPageRoute.name,
          path: '/event-messages-page',
          args: EventMessagesPageRouteArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'EventMessagesPageRoute';
}

class EventMessagesPageRouteArgs {
  const EventMessagesPageRouteArgs({
    this.key,
    required this.id,
  });

  final _i18.Key? key;

  final String id;

  @override
  String toString() {
    return 'EventMessagesPageRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i11.EventCreationFromWelcome]
class EventCreationFromWelcomeRoute extends _i17.PageRouteInfo<void> {
  const EventCreationFromWelcomeRoute()
      : super(
          EventCreationFromWelcomeRoute.name,
          path: '/event-creation-from-welcome',
        );

  static const String name = 'EventCreationFromWelcomeRoute';
}

/// generated route for
/// [_i12.LoginSplashPage]
class LoginSplashPageRoute extends _i17.PageRouteInfo<void> {
  const LoginSplashPageRoute()
      : super(
          LoginSplashPageRoute.name,
          path: '/',
        );

  static const String name = 'LoginSplashPageRoute';
}

/// generated route for
/// [_i13.PersonalEventPage]
class PersonalEventPageRoute extends _i17.PageRouteInfo<void> {
  const PersonalEventPageRoute()
      : super(
          PersonalEventPageRoute.name,
          path: '/personal-event-page',
        );

  static const String name = 'PersonalEventPageRoute';
}

/// generated route for
/// [_i14.VerificationPage]
class VerificationPageRoute extends _i17.PageRouteInfo<void> {
  const VerificationPageRoute()
      : super(
          VerificationPageRoute.name,
          path: '/verification-page',
        );

  static const String name = 'VerificationPageRoute';
}

/// generated route for
/// [_i15.RegisterPage]
class RegisterPageRoute extends _i17.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i16.StartPage]
class StartPageRoute extends _i17.PageRouteInfo<void> {
  const StartPageRoute()
      : super(
          StartPageRoute.name,
          path: '/start-page',
        );

  static const String name = 'StartPageRoute';
}
