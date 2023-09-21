import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/show_accounts_list/domain/repository/show_accounts_list_repository.dart';

class GetShowAccountsList extends UseCaseWithOutParams<FutureResponse> {
  GetShowAccountsList({required ShowAccountsListRepository showAccountsListRepository}) : _showAccountsListRepository = showAccountsListRepository;
  final ShowAccountsListRepository _showAccountsListRepository;

  @override
  FutureResponse call() async => await _showAccountsListRepository.getAccountsList();
}
