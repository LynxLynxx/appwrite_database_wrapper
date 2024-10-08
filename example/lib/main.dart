import 'package:appwrite/appwrite.dart';
import 'package:appwrite_database_wrapper/appwrite_database_wrapper.dart';
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

void main() async {
  await dotenv.load(fileName: ".env");
  final client = Client();
  client
      .setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
      .setProject(dotenv.env['APPWRITE_PROJECT_ID']!)
      .setSelfSigned(status: true);

  final database = Databases(client);
  final db = DB(dotenv.env['APPWRITE_DATABASE_ID']!, database);

  runApp(MainApp(db: db));
}

class MainApp extends StatefulWidget {
  final DB db;
  const MainApp({super.key, required this.db});

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
    final result =
        await widget.db.users.listDocuments(queries: [Query.limit(1)]);
    return result.documents
        .map((doc) => User(
            name: doc.data['name'],
            email: doc.data['email'],
            password: doc.data['password']))
        .toList();
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
