import 'package:lecture_code/common/constants/local/local_database_constants.dart';
import 'package:lecture_code/common/local/sqflite_singleton.dart';

class GiftLocalDatabase extends BaseLocalDatabase {
  static final GiftLocalDatabase instance = GiftLocalDatabase._privateConstructor();
  GiftLocalDatabase._privateConstructor();

  final String _databaseName = databaseName;
  final String _tableName = 'gifts';

  Future<int> addGift(Map<String, dynamic> giftData) async {
    final db = await database;
    return await db.insert(_tableName, giftData);
  }

  Future<List<Map<String, dynamic>>> getAllGiftsByUserId(String userId) async {
    final db = await database;
    return await db.query(
      _tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllGiftsByEventId(String eventId) async {
    final db = await database;
    return await db.query(
      _tableName,
      where: 'eventId = ?',
      whereArgs: [eventId],
    );
  }

  Future<Map<String, dynamic>?> getGiftById(String id) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> updateGift(Map<String, dynamic> giftData) async {
    final db = await database;
    await db.update(
      _tableName,
      giftData,
      where: 'id = ?',
      whereArgs: [giftData['id']],
    );
  }

  Future<void> deleteGift(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllGifts() async {
    final db = await database;
    await db.delete(_tableName);
  }
}