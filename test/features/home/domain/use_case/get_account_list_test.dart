// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:password/core/response/response.dart';
// import 'package:password/screen/home/domain/entities/account_data.dart';
// import 'package:password/screen/home/domain/repository/home_repo.dart';
// import 'package:password/screen/home/domain/use_case/get_account_list.dart';
//
// class MockHomeRepo extends Mock implements HomeRepository {}
//
// void main(){
//   late HomeRepository homeRepository;
//   late GetAccountList getAccountList;
//   setUpAll((){
//     homeRepository = MockHomeRepo();
//     getAccountList = GetAccountList(homeRepository: homeRepository);
//   });
//
//   const accountList = [AccountData.empty(),AccountData.empty()];
//   test('should FutureResponse data = []', () async {
//     when(() => homeRepository.getAccountsList()).thenAnswer((_) async => const SuccessResponse(accountList));
//
//     final result = await getAccountList();
//
//     expect(result, equals(const SuccessResponse<dynamic>(accountList)));
//
//     verify(() => homeRepository.getAccountsList()).called(1);
//     verifyNoMoreInteractions(homeRepository);
//   });
//
// }