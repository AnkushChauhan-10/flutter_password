import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';

abstract class SaveRepository {
  const SaveRepository();

  FutureResponse saveData({required Account account});
}
