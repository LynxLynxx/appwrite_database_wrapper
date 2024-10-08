import 'package:appwrite/appwrite.dart';

/// An abstract class providing a base for interacting with an Appwrite database.
///
/// The [AppwriteDatabaseWrapper] class serves as a foundation for more specific
/// database handling classes, allowing interaction with the Appwrite database
/// using a provided [database] client and a specific [databaseId].
///
/// The class must be extended to define specific behaviors.
///
/// ```dart
/// class MyDatabase extends AppwriteDatabaseWrapper {
///   MyDatabase(String id, Databases db) : super(id, db);
///   // Additional methods and properties.
/// }
/// ```
///
/// [database]: An instance of [Databases] used to interact with the Appwrite database.
/// [databaseId]: The ID of the specific database being accessed.
abstract class AppwriteDatabaseWrapper {
  final Databases database;
  final String databaseId;

  AppwriteDatabaseWrapper(this.databaseId, this.database);
}
