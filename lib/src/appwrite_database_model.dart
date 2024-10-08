/// A model representing an entity stored in an Appwrite database.
///
/// The [AppwriteDatabaseModel] class contains information about the database
/// entity, including its [name] and [collection].
///
///
/// Example usage:
/// ```dart
/// const model = AppwriteDatabaseModel(name: 'User', collection: 'users');
/// ```
///
/// [name]: The unique name representing the database entity.
/// [collection]: The collection or table within which the entity is stored.
class AppwriteDatabaseModel {
  final String name;
  final String collection;

  const AppwriteDatabaseModel({required this.name, required this.collection});
}
