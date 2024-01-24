import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';

abstract class EditRepository {
  const EditRepository();

  FutureResponse editData({required Account account});
}
