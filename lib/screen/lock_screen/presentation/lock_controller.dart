import 'package:get/get.dart';
import 'package:password/injection_container.dart';
import 'package:password/screen/lock_screen/data/lock_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockController extends GetxController{
  final LockRepository _lockRepository = sl<LockRepository>();

}