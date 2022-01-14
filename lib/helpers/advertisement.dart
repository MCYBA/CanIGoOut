import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);

String getAppId() {
  if (Platform.isIOS) {
    return "";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-3163388180447485~5160622915";
  }
  return null;
}

String getRewardAdUnitId() {
  if (Platform.isIOS) {
    return "";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-3163388180447485/994877255";
//    return "ca-app-pub-3940256099942544/5224354917"; // for test
  }
  return null;
}

String getNativeAdUnitId() {
  if (Platform.isIOS) {
    return "";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-3163388180447485/2100597342";
//    return "ca-app-pub-3940256099942544/2247696110"; // for test
  }
  return null;
}

String getInterstitialsAdUnitId() {
  if (Platform.isIOS) {
    return "";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-3163388180447485/8478079065";
//    return "ca-app-pub-3940256099942544/2247696110"; // for test
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return "";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-3163388180447485/4906801035";
//    return "ca-app-pub-3940256099942544/2247696110"; // for test
  }
  return null;
}

//RewardedVideoAd createRewardedVideoAd() {
//  return RewardedVideoAd(
//
//    adUnitId: getRewardAdUnitId(),
//    size: AdSize.banner,
//    targetingInfo: targetingInfo,
//    listener: (MobileAdEvent event) {
//      print("BannerAd event $event");
//    },
//  );
//}

NativeAd createNativeAd() {
  return NativeAd(
    adUnitId: getNativeAdUnitId(),
    factoryId: "can.i.go.out",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event $event");
    },
  );
}