# app_blocker consumer ProGuard/R8 rules
# These rules are merged into the consuming app's shrinker configuration.

# Gson uses generic type information (via TypeToken) to deserialize JSON into
# typed collections (List<ScheduleData>, List<ProfileData>). R8 strips generic
# signatures by default, which causes a runtime crash:
#   "TypeToken must be created with a type argument"
# Keep signatures on TypeToken subclasses so Gson can read them at runtime.
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# Keep the data classes that Gson serialises/deserialises so R8 does not
# rename or remove their fields.
-keep class com.khanhtq.app_blocker.scheduling.ScheduleData { *; }
-keep class com.khanhtq.app_blocker.scheduling.ProfileData { *; }

# Preserve generic signatures on all classes in the plugin package so that
# any future Gson usage is covered without requiring rule updates.
-keepattributes Signature
-keepattributes *Annotation*
