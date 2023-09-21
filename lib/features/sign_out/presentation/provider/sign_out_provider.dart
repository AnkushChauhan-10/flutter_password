import 'package:password/core/response/response.dart';
import 'package:password/features/sign_out/domain/use_case/sign_out.dart';

class SignOutProvider {
  const SignOutProvider({required SignOut signOut}) : _signOut = signOut;
  final SignOut _signOut;

  Future<void> signOut(Function? onDone) async {
    final result = await _signOut();
    if (result is SuccessResponse) {
      onDone?.call();
    } else {
      print(result.data);
    }
  }
}
