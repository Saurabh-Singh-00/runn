import 'package:get_it/get_it.dart';
import 'package:runn/services/api_service.dart';
import 'package:runn/services/rest_api_service.dart';

GetIt injector = GetIt.instance;

extension Init on GetIt {
  void setup() {
    this.registerSingleton<APIService>(ReSTAPIService());
  }

  void tearDown() {
    this.unregister<APIService>();
  }
}