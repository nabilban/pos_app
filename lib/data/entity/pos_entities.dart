import 'package:drift/drift.dart';

@DataClassName('CategoryEntity')
class Categories extends Table {
  IntColumn get id => integer()();
  @JsonKey('CreatedAt')
  TextColumn get createdAt => text()();
  @JsonKey('UpdatedAt')
  TextColumn get updatedAt => text()();
  @JsonKey('DeletedAt')
  TextColumn get deletedAt => text().nullable()();
  TextColumn get name => text()();
  TextColumn get status => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BrandEntity')
class Brands extends Table {
  IntColumn get id => integer()();
  @JsonKey('CreatedAt')
  TextColumn get createdAt => text()();
  @JsonKey('UpdatedAt')
  TextColumn get updatedAt => text()();
  @JsonKey('DeletedAt')
  TextColumn get deletedAt => text().nullable()();
  @JsonKey('name')
  TextColumn get name => text()();
  TextColumn get image => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UnitEntity')
class Units extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProductEntity')
class Products extends Table {
  IntColumn get id => integer()();
  @JsonKey('CreatedAt')
  TextColumn get createdAt => text()();
  @JsonKey('UpdatedAt')
  TextColumn get updatedAt => text()();
  @JsonKey('DeletedAt')
  TextColumn get deletedAt => text().nullable()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  IntColumn get stock => integer()();
  TextColumn get image => text().nullable()();
  TextColumn get status => text().withDefault(const Constant("active"))();
  @JsonKey('category_id')
  IntColumn get categoryId => integer().nullable().references(Categories, #id)();
  @JsonKey('brand_id')
  IntColumn get brandId => integer().nullable().references(Brands, #id)();
  @JsonKey('unit_id')
  IntColumn get unitId => integer().nullable().references(Units, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProductVariantEntity')
class ProductVariants extends Table {
  IntColumn get id => integer()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VariantOptionEntity')
class VariantOptions extends Table {
  IntColumn get id => integer()();
  IntColumn get variantId => integer().references(ProductVariants, #id)();
  TextColumn get name => text()();
  RealColumn get additionalPrice => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PaymentMethodEntity')
class PaymentMethods extends Table {
  @JsonKey('ID')
  IntColumn get paymentMethodId => integer()();
  TextColumn get name => text()();
  @JsonKey('show_in_sale')
  BoolColumn get showInSale => boolean()();
  @JsonKey('show_in_purchase')
  BoolColumn get showInPurchase => boolean()();
  @JsonKey('outlet_id')
  IntColumn get outletId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {paymentMethodId};
}

@DataClassName('PriceCategoryEntity')
class PriceCategories extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PromoEntity')
class Promos extends Table {
  @JsonKey('ID')
  IntColumn get promoId => integer()();
  TextColumn get name => text()();
  @JsonKey('promo_type')
  TextColumn get promoType => text()();
  @JsonKey('applies_to')
  TextColumn get appliesTo => text()();
  TextColumn get condition => text()();
  @JsonKey('min_qty')
  IntColumn get minQty => integer()();
  @JsonKey('min_total')
  RealColumn get minTotal => real()();
  @JsonKey('discount_pct')
  RealColumn get discountPct => real()();
  @JsonKey('max_discount')
  RealColumn get maxDiscount => real()();
  @JsonKey('cut_price')
  RealColumn get cutPrice => real()();
  @JsonKey('voucher_type')
  TextColumn get voucherType => text().nullable()();
  @JsonKey('voucher_code')
  TextColumn get voucherCode => text().nullable()();
  TextColumn get status => text().nullable()();

  @override
  Set<Column> get primaryKey => {promoId};
}

@DataClassName('PriceCategoryProductEntity')
class PriceCategoryProducts extends Table {
  IntColumn get id => integer()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get priceCategoryId => integer().references(PriceCategories, #id)();
  RealColumn get price => real()();

  @override
  Set<Column> get primaryKey => {id};
}
