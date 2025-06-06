import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:dsfulfill_admin_app/config/global_inject.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/pay_success_event.dart';
import 'package:dsfulfill_admin_app/i10n/i10n.dart';
import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await GlobalInject.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  StreamSubscription? paySub;
  late bool isTeam = false;

  _MyAppState() {
    //监听事件

    final eventBus = EventBus(sync: true);
    ApplicationEvent.getInstance().event = eventBus;
  }

  @override
  void initState() {
    super.initState();
    initPayObserver();
    _locale = CommonStorage.getLanguage() ?? const Locale('en', 'US');
    // const Locale('zh', 'CN');
    if (CommonStorage.getToken() != '') {
      isTeam = Get.find<AppState>().team['company_id'] == 0 ? true : false;
    }
    initLoadingConfig();
  }

  initPayObserver() {
    paySub = uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;
      if (uri.query.isNotEmpty) {
        Map<String, String> query = {};
        uri.query.split('&').forEach((e) {
          query[e.split("=")[0]] = e.split("=")[1];
        });
        if (query['status'] != null) {
          ApplicationEvent.getInstance()
              .event
              .fire(PaySuccessEvent(status: query['status']));
          return;
        }
      }
      if (['pay'].contains(uri.host)) {
        ApplicationEvent.getInstance().event.fire(PaySuccessEvent());
      }
    }, onError: (err) {});
  }

  initLoadingConfig() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 816),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppStyles.primary,
            useMaterial3: true,
          ),
          translations: I10N(),
          locale: _locale,
          getPages: Routers.pages,
          initialRoute: CommonStorage.getGuide()
              ? Routers.guide
              : isTeam
                  ? Routers.newTeam
                  : Routers.home,
          builder: EasyLoading.init(builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
              ),
              child: child!,
            );
          }),
        );
      },
    );
  }
}
