// * Server
enum Environment { local, dev, prod }

extension EnvironmentExtension on Environment {
  String get title {
    switch (this) {
      case Environment.local:
        return "local";
      case Environment.dev:
        return "dev";
      case Environment.prod:
        return "prod";
      default:
        throw Exception("Environment not found");
    }
  }
}

// * Http
enum RequestMethod { get, post, put, delete, postFile, patch }
