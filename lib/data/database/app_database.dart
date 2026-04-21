import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../entity/token_entity.dart';
import '../entity/user_entity.dart';
import '../entity/role_entity.dart';
import '../entity/outlet_entity.dart';
import '../entity/attendance_entity.dart';
import '../entity/shift_entity.dart';
import '../entity/pos_entities.dart';
import '../entity/sale_entities.dart';
import '../entity/shift_history_entity.dart';
import '../entity/attendance_history_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Tokens,
  Users,
  Roles,
  Outlets,
  Attendances,
  Shifts,
  Categories,
  Brands,
  Units,
  Products,
  ProductVariants,
  VariantOptions,
  PaymentMethods,
  PriceCategories,
  Promos,
  PriceCategoryProducts,
  Sales,
  SaleItems,
  SaleItemVariants,
  ShiftHistories,
  AttendanceHistories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
  );

  // --- TOKEN OPERATIONS ---

  Future<String?> getActiveToken() async {
    final t = await (select(tokens)..limit(1)).getSingleOrNull();
    return t?.token;
  }

  Future<void> saveToken(String newToken) async {
    transaction(() async {
      await delete(tokens).go();
      await into(tokens).insert(TokensCompanion.insert(token: newToken));
    });
  }

  Future<void> clearToken() async {
    await delete(tokens).go();
  }

  // --- USER OPERATIONS ---

  Future<void> saveUserContext({
    required UsersCompanion user,
    required RolesCompanion role,
    OutletsCompanion? outlet,
  }) async {
    transaction(() async {
      await delete(users).go();
      await delete(roles).go();
      await delete(outlets).go();

      await into(users).insert(user);
      await into(roles).insert(role);
      if (outlet != null) {
        await into(outlets).insert(outlet);
      }
    });
  }

  Future<User?> getActiveUser() async {
    return await (select(users)..limit(1)).getSingleOrNull();
  }

  Future<Role?> getActiveRole() async {
    return await (select(roles)..limit(1)).getSingleOrNull();
  }

  Future<Outlet?> getActiveOutlet() async {
    return await (select(outlets)..limit(1)).getSingleOrNull();
  }

  Future<void> clearUserContext() async {
    transaction(() async {
      await delete(users).go();
      await delete(roles).go();
      await delete(outlets).go();
      await delete(attendances).go();
      await delete(shifts).go();
    });
  }

  // --- ATTENDANCE OPERATIONS ---

  Future<Attendance?> getTodayAttendance(int userId) async {
    return await (select(attendances)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.checkIn.isNotNull()) // Simplified for today check if using Strings
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveAttendance(AttendancesCompanion entry) async {
    return await into(attendances).insertOnConflictUpdate(entry);
  }

  Future<int> saveAttendanceHistory(AttendanceHistoriesCompanion entry) async {
    return await into(attendanceHistories).insertOnConflictUpdate(entry);
  }

  Future<void> updateAttendance(int id, AttendancesCompanion entry) async {
    await (update(attendances)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<List<AttendanceHistory>> getAttendanceHistory() async {
    return await (select(attendanceHistories)
          ..orderBy([(t) => OrderingTerm.desc(t.checkIn)]))
        .get();
  }

  // --- SHIFT OPERATIONS ---

  Future<Shift?> getActiveShift(int userId) async {
    return await (select(shifts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equals('open'))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveShift(ShiftsCompanion entry) async {
    return await into(shifts).insertOnConflictUpdate(entry);
  }

  Future<int> saveShiftHistory(ShiftHistoriesCompanion entry) async {
    return await into(shiftHistories).insertOnConflictUpdate(entry);
  }

  Future<void> updateShift(int id, ShiftsCompanion entry) async {
    await (update(shifts)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<void> deleteShift(int id) async {
    await (delete(shifts)..where((t) => t.id.equals(id))).go();
  }

  Future<void> clearActiveShifts(int userId) async {
    await (delete(shifts)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.status.equals('open')))
        .go();
  }

  Future<List<ShiftHistory>> getShiftHistory() async {
    return await (select(shiftHistories)
          ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
        .get();
  }

  // --- POS OPERATIONS ---

  Future<void> saveCategories(List<CategoriesCompanion> entries) async {
    transaction(() async {
      await delete(categories).go();
      for (final entry in entries) {
        await into(categories).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<CategoryEntity>> getAllCategories() async {
    return await select(categories).get();
  }

  Future<void> saveBrands(List<BrandsCompanion> entries) async {
    transaction(() async {
      await delete(brands).go();
      for (final entry in entries) {
        await into(brands).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<BrandEntity>> getAllBrands() async {
    return await select(brands).get();
  }

  Future<void> saveProducts(List<ProductsCompanion> entries) async {
    transaction(() async {
      await delete(products).go();
      for (final entry in entries) {
        await into(products).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<ProductEntity>> getAllProducts() async {
    return await select(products).get();
  }

  Future<void> saveProductVariants(List<ProductVariantsCompanion> entries) async {
    for (final entry in entries) {
      await into(productVariants).insertOnConflictUpdate(entry);
    }
  }

  Future<void> saveVariantOptions(List<VariantOptionsCompanion> entries) async {
    for (final entry in entries) {
      await into(variantOptions).insertOnConflictUpdate(entry);
    }
  }

  Future<void> savePaymentMethods(List<PaymentMethodsCompanion> entries) async {
    transaction(() async {
      await delete(paymentMethods).go();
      for (final entry in entries) {
        await into(paymentMethods).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<PaymentMethodEntity>> getAllPaymentMethods() async {
    return await select(paymentMethods).get();
  }

  Future<void> savePromos(List<PromosCompanion> entries) async {
    transaction(() async {
      await delete(promos).go();
      for (final entry in entries) {
        await into(promos).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<PromoEntity>> getAllPromos() async {
    return await select(promos).get();
  }

  Future<void> savePriceCategories(List<PriceCategoriesCompanion> entries) async {
    transaction(() async {
      await delete(priceCategories).go();
      for (final entry in entries) {
        await into(priceCategories).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<PriceCategoryEntity>> getAllPriceCategories() async {
    return await select(priceCategories).get();
  }

  Future<void> savePriceCategoryProducts(int priceCategoryId, List<PriceCategoryProductsCompanion> entries) async {
    transaction(() async {
      // Clear existing mapping for this category
      await (delete(priceCategoryProducts)..where((t) => t.priceCategoryId.equals(priceCategoryId))).go();
      for (final entry in entries) {
        await into(priceCategoryProducts).insertOnConflictUpdate(entry);
      }
    });
  }

  Future<List<PriceCategoryProductEntity>> getPriceCategoryProducts(int priceCategoryId) async {
    return await (select(priceCategoryProducts)..where((t) => t.priceCategoryId.equals(priceCategoryId))).get();
  }

  // --- SALE HISTORY OPERATIONS ---

  Future<void> saveSalesHistory(List<SalesCompanion> salesList) async {
    transaction(() async {
      await delete(sales).go();
      for (final s in salesList) {
        await into(sales).insertOnConflictUpdate(s);
      }
    });
  }

  Future<void> saveSaleItems(List<SaleItemsCompanion> itemList) async {
    for (final item in itemList) {
      await into(saleItems).insertOnConflictUpdate(item);
    }
  }

  Future<void> saveSaleItemVariants(List<SaleItemVariantsCompanion> variantList) async {
    for (final v in variantList) {
      await into(saleItemVariants).insertOnConflictUpdate(v);
    }
  }

  Future<List<SaleEntity>> getAllSales() async {
    return await select(sales).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick up the native library and cache directory properly
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
