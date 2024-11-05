import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

import '../JSON/users.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'login_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, usrName TEXT, usrPassword TEXT)',
          );
        },
        version: 1,
      );
    } catch (e) {
      developer.log('Error initializing database: $e', name: 'DatabaseHelper');
      rethrow;
    }
  }

  Future<int> createUser(Users user) async {
    final db = await initDatabase();
    try {
      return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      developer.log('Error creating user: $e', name: 'DatabaseHelper');
      rethrow;
    }
  }

  //Authentication with parameterized query to prevent SQL injection
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDatabase();
    try {
      var result = await db.query(
        'users',
        where: 'email = ? AND usrPassword = ?',
        whereArgs: [usr.email, usr.password], // Use parameterized queries
      );
      return result.isNotEmpty;
    } catch (e) {
      developer.log('Error during authentication: $e', name: 'DatabaseHelper');
      rethrow;
    }
  }

  Future<Users?> getEmail(String email) async {
    final db = await initDatabase();
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      if (result.isNotEmpty) {
        return Users.fromMap(result.first);
      } else {
        return null;
      }
    } catch (e) {
      developer.log('Error getting email: $e', name: 'DatabaseHelper');
      rethrow;
    }
  }

  Future<String?> getUserNameByEmail(String email) async {
    final Database db = await initDatabase();
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        columns: ['usrName'], // Only select the username column
        where: 'email = ?',
        whereArgs: [email],
      );
      if (result.isNotEmpty) {
        return result.first['usrName'] as String;
      } else {
        return null; // Return null if no match is found
      }
    } catch (e) {
      developer.log('Error getting username by email: $e',
          name: 'DatabaseHelper');
      rethrow;
    }
  }

  Future<bool> doesUserNameExist(String usrName) async {
    final db = await initDatabase();
    try {
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'usrName = ?',
        whereArgs: [usrName],
      );
      return result.isNotEmpty;
    } catch (e) {
      developer.log('Error checking username existence: $e',
          name: 'DatabaseHelper');
      rethrow;
    }
  }

  Future<void> clearAllData() async {
    final db = await initDatabase();
    try {
      // Only delete data from tables that are defined
      await db.delete('users');
      // Add more tables as needed if they are created in the database
    } catch (e) {
      developer.log('Error clearing data: $e', name: 'DatabaseHelper');
      rethrow;
    }
  }
}
