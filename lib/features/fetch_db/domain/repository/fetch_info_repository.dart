import 'dart:async';

import 'package:password/core/utiles/typedef.dart';

abstract class FetchInfoRepository {
  const FetchInfoRepository();

  FutureResponse fetchInfo();
}
