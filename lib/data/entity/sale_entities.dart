import 'package:drift/drift.dart';
import 'pos_entities.dart';

@DataClassName('SaleEntity')
class Sales extends Table {
  @JsonKey('ID')
  IntColumn get id => integer()();
  @JsonKey('CreatedAt')
  TextColumn get createdAt => text()();
  @JsonKey('invoice_number')
  TextColumn get invoiceNumber => text()();
  @JsonKey('customer_name')
  TextColumn get customerName => text().withDefault(const Constant(''))();
  @JsonKey('payment_method_id')
  IntColumn get paymentMethodId => integer().references(PaymentMethods, #paymentMethodId)();
  RealColumn get subtotal => real().withDefault(const Constant(0.0))();
  @JsonKey('discount_total')
  RealColumn get discountTotal => real().withDefault(const Constant(0.0))();
  @JsonKey('manual_discount')
  RealColumn get manualDiscount => real().withDefault(const Constant(0.0))();
  @JsonKey('additional_fee')
  RealColumn get additionalFee => real().withDefault(const Constant(0.0))();
  @JsonKey('grand_total')
  RealColumn get grandTotal => real().withDefault(const Constant(0.0))();
  TextColumn get source => text().withDefault(const Constant('pos'))();
  @JsonKey('user_name')
  TextColumn get userName => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SaleItemEntity')
class SaleItems extends Table {
  @JsonKey('ID')
  IntColumn get id => integer()();
  IntColumn get saleId => integer().references(Sales, #id)();
  @JsonKey('product_id')
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  @JsonKey('base_price')
  RealColumn get basePrice => real().withDefault(const Constant(0.0))();
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  RealColumn get subtotal => real().withDefault(const Constant(0.0))();
  @JsonKey('product_name')
  TextColumn get productName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SaleItemVariantEntity')
class SaleItemVariants extends Table {
  @JsonKey('ID')
  IntColumn get id => integer()();
  IntColumn get saleItemId => integer().references(SaleItems, #id)();
  @JsonKey('additional_price')
  RealColumn get additionalPrice => real().withDefault(const Constant(0.0))();
  @JsonKey('variant_option_id')
  IntColumn get variantOptionId => integer().nullable().references(VariantOptions, #id)();
  @JsonKey('variant_option_name')
  TextColumn get variantOptionName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
