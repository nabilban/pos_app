// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      diskon10: json['diskon10'] as bool? ?? false,
      cashback50: json['cashback50'] as bool? ?? false,
      gratisMinuman: json['gratisMinuman'] as bool? ?? false,
      cetakStruk: json['cetakStruk'] as bool? ?? true,
      cetakKasir: json['cetakKasir'] as bool? ?? false,
      cetakWaktu: json['cetakWaktu'] as bool? ?? true,
      storeInfo: json['storeInfo'] == null
          ? const StoreInfo(
              name: 'FIESTO POS',
              address: 'Jl. Sudirman No. 123, Surabaya',
              phone: '0812-3456-7890',
              cashierName: 'Ahmad',
            )
          : StoreInfo.fromJson(json['storeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'diskon10': instance.diskon10,
      'cashback50': instance.cashback50,
      'gratisMinuman': instance.gratisMinuman,
      'cetakStruk': instance.cetakStruk,
      'cetakKasir': instance.cetakKasir,
      'cetakWaktu': instance.cetakWaktu,
      'storeInfo': instance.storeInfo,
    };
