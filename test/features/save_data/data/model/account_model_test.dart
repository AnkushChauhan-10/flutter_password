// import 'package:flutter_test/flutter_test.dart';
// import 'package:password/core/utiles/typedef.dart';
// import 'package:password/features/save_data/data/model/account_model.dart';
// import 'package:password/features/save_data/domain/entities/account.dart';
//
// void main() {
//   late AccountModel model;
//   setUpAll(() => model = const AccountModel.empty());
//
//   test('should be sub class of Account', () async {
//     expect(model, isA<Account>());
//   });
//
//   group('toMap', () {
//     test('should return DataMap', () async {
//       final map = model.toMap();
//       expect(map, isA<DataMap>());
//     });
//
//     const dataMap = {
//       'siteName': "",
//       'id': "",
//       'userName': "",
//       'password': "",
//       'lastUpdate': "",
//     };
//     test('should return valid DataMap', () async {
//       final map = model.toMap();
//       expect(map, equals(dataMap));
//     });
//   });
//
//   group('copyWith', () {
//     test('should return AccountModel', () async {
//       final result = model.copyWith();
//       expect(result, isA<AccountModel>());
//     });
//
//     const copyWithModel = AccountModel(
//       siteName: "",
//       id: "id",
//       userName: "",
//       password: "pass",
//       lastUpdate: "2",
//       isUpdate: false,
//     );
//     test('should return valid AccountModel', () async {
//       final result = model.copyWith(id: 'id',password: 'pass');
//       expect(result, equals(copyWithModel));
//     });
//   });
// }
