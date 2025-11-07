import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Configuration {
  String get getBaseUrl;
}

@LazySingleton(as: Configuration, env: [Environment.dev])
class DevConfiguration extends Configuration {
  @override
  String get getBaseUrl => dotenv.env['DEV_BASE_URL'] ?? '';
}

@LazySingleton(as: Configuration, env: [Environment.test])
class StagingConfiguration extends Configuration {
  @override
  String get getBaseUrl => dotenv.env['STAGING_BASE_URL'] ?? '';
}

@LazySingleton(as: Configuration, env: [Environment.prod])
class ProductionConfiguration extends Configuration {
  @override
  String get getBaseUrl => dotenv.env['PROD_BASE_URL'] ?? '';
}
