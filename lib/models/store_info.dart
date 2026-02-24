import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_info.freezed.dart';
part 'store_info.g.dart';

@freezed
class StoreInfo with _$StoreInfo {
  const factory StoreInfo({
    required String name,
    required String address,
    required String phone,
    required String cashierName,
  }) = _StoreInfo;

  factory StoreInfo.fromJson(Map<String, dynamic> json) =>
      _$StoreInfoFromJson(json);
}
