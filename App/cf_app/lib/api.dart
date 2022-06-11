import 'package:cf_app/http.dart';

import 'http.dart';

abstract class Api {
  final HttpDataSource dataSource;
  final String token;

  Api(this.dataSource, this.token);
}
