import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("app")

    productFlavors {
        create("prod") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode.toInteger()
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map")
        }
        create("staging") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode.toInteger()
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map staging")
        }
        create("dev") {
            dimension = "app"
            applicationId = "com.projectmark.weather_map"
            versionCode = flutter.versionCode.toInteger()
            versionName = flutter.versionName
            resValue(type = "string", name = "app_name", value = "Weather Map dev")
        }
    }
}