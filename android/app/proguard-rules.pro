## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

-dontwarn

-ignorewarnings

-keep class * {
    public private *;
}

## flutter_local_notification plugin rules
-keep class com.dexterous.** { *; }
