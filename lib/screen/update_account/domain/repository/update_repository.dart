import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/update_account/domain/entities/update_account.dart';

abstract class UpdateRepository{
  const UpdateRepository();

  FutureResponse update(UpdateAccount account);
}