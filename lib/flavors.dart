enum Flavor {
  prod,
  staging,
  dev,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'Weather Map';
      case Flavor.staging:
        return 'Weather Map staging';
      case Flavor.dev:
        return 'Weather Map dev';
    }
  }

}
