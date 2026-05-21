enum Flavor {

  dev,

  prod,
}

class FlavorConfig {

  final Flavor flavor;

  final String appName;

  final String apiBaseUrl;

  static FlavorConfig? instance;

  FlavorConfig({

    required this.flavor,

    required this.appName,

    required this.apiBaseUrl,
  });

  static void initialize(
      FlavorConfig config,
      ){

    instance = config;
  }

  static FlavorConfig get config {

    return instance!;
  }

  bool get isDev {

    return flavor == Flavor.dev;
  }

  bool get isProd {

    return flavor == Flavor.prod;
  }
}