# Keep Flutter embedding and engine classes from being stripped/obfuscated
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep specific JNI native methods that the stack trace complained about
-keep class io.flutter.embedding.engine.FlutterJNI {
    native <methods>;
    *** performNativeAttach(...);
    *** attachToNative(...);
}

# Keep the underlying Dart VM entry points stable
-keep class class_containing_a_native_method { native <methods>; }

# Flutter Deferred Components / Play Store Split rules
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Tell R8 to allow optimization even if some reference targets are missing
-ignorewarnings
