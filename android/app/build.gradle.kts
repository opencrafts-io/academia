import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "io.opencrafts.academia"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        // Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true
        // Sets Java compatibility to Java 11
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "io.opencrafts.academia"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 28
        targetSdk = 36
        versionCode = 5
        versionName = "2025.10.14+0"
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
        create("staging") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }

    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            // Specifies the location of the R8/ProGuard rules file
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            if (signingConfigs.findByName("staging") != null) {
                signingConfig = signingConfigs.getByName("staging")
            } else if (signingConfigs.findByName("release") != null) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }

    flavorDimensions += "environment"

    productFlavors {
        create("development") {
            dimension = "environment"
            applicationIdSuffix = ".dev" // Appears as io.opencrafts.academia.dev
            versionNameSuffix = "-dev"   // Appears as 1.0.0-dev
            // You can add buildConfigField or resValue here for specific configurations
            // buildConfigField "String", "API_BASE_URL", "\"https://dev.api.example.com\""
        }
        create("production") {
            dimension = "environment"
            // No suffix needed if this is your primary application ID
            // buildConfigField "String", "API_BASE_URL", "\"https://prod.api.example.com\""
        }
        // You can add more flavors, e.g., a "staging" flavor

        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".stg"
            versionNameSuffix = "-stg"
            // buildConfigField "String", "API_BASE_URL", "\"https://stg.api.example.com\""
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring for modern Java APIs compatibility
    // Required for flutter_local_notifications and other dependencies
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
}
