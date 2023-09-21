import 'package:password/core/response/response.dart';
import 'package:password/features/delete/domain/use_case/delete.dart';

class DeleteProvider{
  const DeleteProvider({required Delete delete}):_delete = delete;
  final Delete _delete;

  Future<void> delete(Function? onDone,String name) async {
    final result = await _delete(name);
    if(result is SuccessResponse){
      onDone?.call();
    }else{
      print(result.data);
    }
  }
}