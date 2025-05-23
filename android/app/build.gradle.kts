plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.projectmark.weather_map"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    flavorDimensions("app")

    productFlavors {
        create("prod") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map")
        }
        create("staging") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map staging")
        }
        create("dev") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map dev")
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.projectmark.weather_map"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Import the BoM for the Firebase platform
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))

    // Add the dependencies for the Crashlytics and Analytics libraries
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation("com.google.firebase:firebase-crashlytics")
    implementation("com.google.firebase:firebase-analytics")

    // Add the dependencies for the Crashlytics NDK and Analytics libraries
    // When using the BoM, you don't specify versions in Firebase library dependencies
    // implementation('com.google.firebase:firebase-crashlytics-ndk')
    // implementation('com.google.firebase:firebase-analytics-ktx')

    // Update Kotlin version to 1.8.22 for compatibility
    // implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.22")
}
