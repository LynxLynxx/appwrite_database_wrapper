# Appwrite Database Wrapper

A Dart package that provides a simple interface for interacting with Appwrite databases. It includes models and abstractions for facilitated integration and manipulation of Appwrite collections.

This package was inspired by this [Appwrite Video](https://www.youtube.com/watch?v=1ip2aljprvg&t=361s)

This package is designed to be used with the [Appwrite Flutter SDK](https://github.com/appwrite/sdk-for-flutter) and is compatible with Flutter projects.

This package is still in development and may have some bugs. Please report any issues you encounter.



## Features

- **AppwriteDatabaseModel**: Represents an entity stored in an Appwrite database.
- **AppwriteDatabaseWrapper**: Abstract class providing the foundation for database operations.
- **CollectionHandler**: Manages interactions with Appwrite database collections using CRUD methods.

## Installation

To use this package, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  appwrite_database_wrapper: <latest_version>
```

## Usage
Initializing the Appwrite Client
Before using the database wrappers, initialize the Appwrite client as shown:

```dart
await dotenv.load(fileName: ".env");
final client = Client();
client
    .setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
    .setProject(dotenv.env['APPWRITE_PROJECT_ID']!)
    .setSelfSigned(status: true);

final database = Databases(client);
//Creating a Database Wrapper
//Define your own database handler that extends AppwriteDatabaseWrapper and configure your collections:

class DB extends AppwriteDatabaseWrapper {
  late final CollectionHandler users;
  // Define other collections...

  DB(super.databaseId, super.database) {
    users = CollectionHandler(
      databaseId: databaseId,
      collectionId: dotenv.env['APPWRITE_COLLECTION_USERS_ID']!,
      database: database,
    );
    // Initialize other collections...
  }
}

```
## Example Application
Here's a minimal example of how to integrate and use these with a Flutter application:

```dart
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
```


## Getting Started
Load environment variables if necessary, and initialize the Appwrite client.

Extend AppwriteDatabaseWrapper to implement your database logic.

Use CollectionHandler to manage collections within your database.

## Contributing
Contributions are welcome! Please submit a pull request or raise issues if you find bugs.

## License
MIT License

## Authors
Ryszard Schossler (LynxLynxx)