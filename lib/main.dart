import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/gestures.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pref_dessert/pref_dessert.dart';
import 'package:rxdart/subjects.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:can_i_go_out/after_layout.dart';
import 'package:can_i_go_out/localization/localizations.dart';
import 'package:can_i_go_out/constant/Constant.dart';
import 'package:can_i_go_out/constant/dimensions.dart';
import 'package:can_i_go_out/globals/main.dart';
import 'package:can_i_go_out/model/profile.dart';
import 'package:can_i_go_out/flutter_restart.dart';
import 'package:can_i_go_out/helpers/main.dart';
import 'package:can_i_go_out/page/home/main.dart';
import 'package:can_i_go_out/page/setProfile/main.dart';
import 'package:can_i_go_out/back_button.dart';

//void main() => runApp(new RunwayClient());

void main() async {
//  downloadPath = (await getApplicationDocumentsDirectory()).path;
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();

  globalNotificationAppLaunchDetails =
  await globalFlutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('can_i_go_out');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        globalDidReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await globalFlutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        globalSelectNotificationSubject.add(payload);
      });

  var restartWidgetKey = GlobalKey();

  var repo = new FuturePreferencesRepository<ProfileModel>(new ProfileModelDesSer());
  globalProfileModel = await repo.findOne(0);


  runApp(RestartWidget(
    key: restartWidgetKey,
    child: new CanIGoOut(
      restartWidgetKey: restartWidgetKey,
    ),
//            child: new FireBaseAdMobTest(),
  ));
}

class CanIGoOut extends StatefulWidget {
  final restartWidgetKey;

  CanIGoOut({
    Key key,
    this.restartWidgetKey,
  }) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    print('setLocale()');
    _CanIGoOutState state = context.findAncestorStateOfType();

    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  _CanIGoOutState createState() => new _CanIGoOutState();
}

class _CanIGoOutState extends State<CanIGoOut> {
  Locale locale;
  bool localeLoaded = false;

  @override
  void initState() {
    super.initState();
    globalRestartWidgetKey = widget.restartWidgetKey;
    this._requestIOSPermissions();
    _fetchLocale().then((locale) {
      setState(() {
        this.localeLoaded = true;
        this.locale = locale;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
  }


  void _requestIOSPermissions() {
    globalFlutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (this.localeLoaded == false) {
      return CircularProgressIndicator();
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      return new MaterialApp(
        title: 'Sokağa Çıkabilir Miyim?',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          const SpecificLocalizationDelegate(Locale('kp', '')),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de', ''), // German
          const Locale('en', ''), // English
          const Locale('es', ''), // Spanish
          const Locale('fr', ''), // French
          const Locale('hi', ''), // Hindi
          const Locale('it', ''), // Italian
          const Locale('kp', ''), // Korean
          const Locale('tr', ''), // Turkish
        ],
        locale: locale,
//        home: new SignInDemo(),
//        home: new LoginPage(),
//        home: new RunwayClientHome(title: 'RunwayClient app'),
        home: new Scaffold(
          body: DoubleBackToCloseApp(
            child: globalProfileModel != null
                ? new CanIGoOutHome(
              key: globalCanIGoOutKey,
              title: 'Sokağa Çıkabilir Miyim?',
              restartWidgetKey: widget.restartWidgetKey,
            )
                : new SetProfilePage(
              restartWidgetKey: widget.restartWidgetKey,
            ),
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
          ),
        ),
      );
    }
  }
}

requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  if (await Permission.storage.isDenied) {
    SystemNavigator.pop(animated: false);
  }
}

_fetchLocale() async {
  var prefs = await SharedPreferences.getInstance();

  if (prefs.getString('languageCode') == null) {
    return null;
  }

  print('_fetchLocale():' +
      (prefs.getString('languageCode') + ':' + prefs.getString('countryCode')));

  return Locale(
      prefs.getString('languageCode'), prefs.getString('countryCode'));
}

class CanIGoOutHome extends StatefulWidget {
  final String title;
  final restartWidgetKey;

  CanIGoOutHome({
    Key key,
    this.title,
    this.restartWidgetKey,
  }) : super(key: key);

  @override
  CanIGoOutHomeState createState() => new CanIGoOutHomeState();
}

class CanIGoOutHomeState extends State<CanIGoOutHome>
    with AfterLayoutMixin<CanIGoOutHome> {
  static CanIGoOutHomeState of(BuildContext context) =>
      context.findAncestorStateOfType();

//  static RunwayClientHomeState of(BuildContext context) =>
//      context.ancestorStateOfType(const TypeMatcher<RunwayClientHomeState>());
  final math.Random rng = new math.Random();

  final _nativeAdController = NativeAdmobController();
  bool isDialogAdVisible = false;

  StreamSubscription _sub;
  UniLinksType _type = UniLinksType.string;

  Locale locale;
  bool localeLoaded = false;

  WidgetsBinding binding = WidgetsBinding.instance;

  LifecycleEventHandler lifeCycleEventHandler =
      new LifecycleEventHandler(resumeCallBack: () {
    print("resuming app");
    return;
  }, suspendingCallBack: () {
        //todo: Rework suspending callback
    return;
  });

  BuildContext buildContext;

  @override
  void initState() {
    super.initState();

    deviceConnected = false;
    BackButtonInterceptor.add(myInterceptor);
    binding.addObserver(lifeCycleEventHandler);

    _fetchLocale().then((locale) {
      setState(() {
        this.localeLoaded = true;
        this.locale = locale;
      });
    });
    initPlatformState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    BackButtonInterceptor.remove(myInterceptor);
    print("called on termination");
    binding.removeObserver(lifeCycleEventHandler);
    if (_sub != null) _sub.cancel();
    super.dispose();
  }

//  setAd(bool isVisible) {
//    print("CALLED SET AD");
//    this.isDialogAdVisible = isVisible;
//    if(isVisible) {
//      if(rng.nextInt(3) == 0) {
//        print("FORCE RELOAD");
//        _nativeAdController.reloadAd(
//            forceRefresh: true,
//            numberAds: rng.nextInt(10)
//        );
//      }
//    }
//    if (mounted) {
//      setState(() {});
//    }
//  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  /// An implementation using a [String] link
  initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      globalLatestLink = link ?? 'Unknown';
      globalLatestUri = null;
      try {
        if (link != null) globalLatestUri = Uri.parse(link);
      } on FormatException {}
      checkGlobalLatestUri();

    }, onError: (err) {
      if (!mounted) return;
      globalLatestLink = 'Failed to get latest link: $err.';
      globalLatestUri = null;
    });

    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);

      globalLatestUri = initialUri;
      globalLatestLink = initialLink;

      checkGlobalLatestUri();

    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    print("STRING LINKS NOT WORKS?");
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    globalLatestLink = initialLink;
    globalLatestUri = initialUri;

  }

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      globalLatestUri = uri;
      globalLatestLink = uri?.toString() ?? 'Unknown';

      checkGlobalLatestUri();
    }, onError: (err) {
      if (!mounted) return;
      globalLatestUri = null;
      globalLatestLink = 'Failed to get latest link: $err.';
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();

      globalLatestUri = initialUri;
      globalLatestLink = initialLink;

      checkGlobalLatestUri();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    globalLatestUri = initialUri;
    globalLatestLink = initialLink;

  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    buildContext = context;
    globalContext = context;

    if (this.localeLoaded == false) {
      return CircularProgressIndicator();
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xff707070)));
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return new Scaffold(
          body: new Container(
            height: screenSize.height,
              width: screenSize.width,
              child: HomePage(
                restartWidgetKey: widget.restartWidgetKey,
              )
          ),
          backgroundColor: Colors.black
      );
    }
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({this.resumeCallBack, this.suspendingCallBack});

  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
//      case AppLifecycleState.suspending:
//        {
//          if (deviceConnected) {
//            await suspendingCallBack();
//          }
//          print("suspending");
//        }
//        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
