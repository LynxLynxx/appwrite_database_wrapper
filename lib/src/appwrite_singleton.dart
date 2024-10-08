import 'package:appwrite/appwrite.dart';
import 'package:appwrite_database_wrapper/appwrite_database_wrapper.dart';
import 'package:flutter/foundation.dart';

/// A singleton class for managing the Appwrite SDK client and database wrapper.
///
/// The [AppwriteSingleton] manages a single instance of Appwrite's [Client] and
/// associated [Account] and [AppwriteDatabaseWrapper]. This allows centralized
/// management of Appwrite interactions in a Flutter application.
///
/// Ensure that you configure necessary parameters such as `enpointUrl` and `projectId`
/// before using the instance. Initialize it once in your app lifecycle and access
/// the instance using the `AppwriteSingleton.instance`.
///
/// Example usage:
/// ```dart
/// final singleton = AppwriteSingleton(
///   appwriteDatabaseWrapper: myDatabaseWrapper,
///   enpointUrl: 'https://localhost/v1',
///   projectId: 'YOUR_PROJECT_ID',
/// );
/// ```
///
/// Note: Set `selfSigned` to `true` only in development mode for self-signed
/// certificates.
class AppwriteSingleton {
  static AppwriteSingleton? _instance;

  late final Client client;
  late final Account account;
  late AppwriteDatabaseWrapper db;

  AppwriteSingleton._internal({
    required AppwriteDatabaseWrapper appwriteDatabaseWrapper,
    required String enpointUrl,
    required String projectId,
    bool selfSigned = kReleaseMode ? true : false,
  }) {
    client = Client();
    client
        .setEndpoint(enpointUrl)
        .setProject(projectId)
        .setSelfSigned(status: selfSigned);

    account = Account(client);
    db = appwriteDatabaseWrapper;
  }

  factory AppwriteSingleton({
    required AppwriteDatabaseWrapper appwriteDatabaseWrapper,
    required String enpointUrl,
    required String projectId,
    bool selfSigned = kReleaseMode ? true : false,
  }) {
    _instance ??= AppwriteSingleton._internal(
      appwriteDatabaseWrapper: appwriteDatabaseWrapper,
      enpointUrl: enpointUrl,
      projectId: projectId,
      selfSigned: selfSigned,
    );
    return _instance!;
  }

  static AppwriteSingleton get instance {
    if (_instance == null) {
      throw StateError(
          "AppwriteSingleton has not been initialized. Call AppwriteSingleton(customDbWrapper) first.");
    }
    return _instance!;
  }
}
