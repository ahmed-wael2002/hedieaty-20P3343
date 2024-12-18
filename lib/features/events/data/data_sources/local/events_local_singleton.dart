import '../../../../../common/local/sqflite_singleton.dart';

class EventLocalDatabase extends BaseLocalDatabase {
  // Singleton instance
  static final EventLocalDatabase instance = EventLocalDatabase._privateConstructor();
  EventLocalDatabase._privateConstructor();

  final String _tableName = 'events';

  /// Add an event
  Future<int> addEvent(Map<String, dynamic> eventData) async {
    final db = await database;
    return await db.insert(_tableName, eventData);
  }

  /// Fetch all events for a specific userId
  Future<List<Map<String, dynamic>>> getAllEventsByUserId(String userId) async {
    final db = await database;
    return await db.query(
      _tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  /// Fetch an event by its ID
  Future<Map<String, dynamic>?> getEventById(String id) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// Update an event
  Future<int> updateEvent(String id, Map<String, dynamic> updatedData) async {
    final db = await database;
    return await db.update(
      _tableName,
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete an event by its ID
  Future<int> deleteEvent(String id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
