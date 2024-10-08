import 'package:appwrite/appwrite.dart';
import 'package:appwrite_database_wrapper/appwrite_database_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//User class
class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});
}

class DB extends AppwriteDatabaseWrapper {
  late final CollectionHandler users;
  late final CollectionHandler students;
  late final CollectionHandler receipts;
  late final CollectionHandler studentsReceipts;
  late final CollectionHandler school;
  DB(super.databaseId, super.database) {
    users = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_USERS_ID']!,
      database: database,
    );
    students = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_STUDENTS_ID']!,
      database: database,
    );

    receipts = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_RECEITS_ID']!,
      database: database,
    );

    studentsReceipts = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_STUDENTSRECEITS_ID']!,
      database: database,
    );

    school = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_SCHOOL_ID']!,
      database: database,
    );
  }
}

class AppwriteSingleton {
  static AppwriteSingleton? _instance;

  late final Client client;
  late final Account account;
  late DB _db;

  AppwriteSingleton._internal({
    required AppwriteDatabaseWrapper appwriteDatabaseWrapper,
    required String enpointUrl,
    required String projectId,
    bool selfSigned = kReleaseMode ? true : false,
  }) {
    client = Client();
    client
        .setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
        .setProject(dotenv.env['APPWRITE_PROJECT_ID']!)
        .setSelfSigned(status: selfSigned);

    account = Account(client);
    _db = DB(dotenv.env['APPWRITE_DATABASE_ID']!, Databases(client));
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

  static DB get db {
    return instance._db;
  }
}

Future<void> main(List<String> args) async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  initState() {
    super.initState();
    _getListsDocs();
  }

  Future<List<User>> _getListsDocs() async {
    final result = await AppwriteSingleton.db.users
        .listDocuments(queries: [Query.limit(1)]);
    return result.documents
        .map((doc) => User(
            name: doc.data['name'],
            email: doc.data['email'],
            password: doc.data['password']))
        .toList();

    /// You can use lib appwrite_error_handling to handle errors!
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
