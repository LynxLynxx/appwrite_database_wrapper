import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class CollectionHandler {
  final String databaseId;
  final String collectionId;
  final Databases database;

  CollectionHandler({
    required this.databaseId,
    required this.collectionId,
    required this.database,
  });

  Future<DocumentList> listDocuments({List<String>? queries}) async {
    return await database.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: queries,
    );
  }

  Future<Document> getDocument({required String documentId}) async {
    return await database.getDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );
  }

  Future<Document> createDocument({
    required String documentId,
    required Map<String, dynamic> data,
    List<String>? permissions,
  }) async {
    return await database.createDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      data: data,
      permissions: permissions,
    );
  }

  Future<Document> updateDocument({
    required String documentId,
    required Map<String, dynamic> data,
    List<String>? permissions,
  }) async {
    return await database.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
      data: data,
      permissions: permissions,
    );
  }

  Future<void> deleteDocument({required String documentId}) async {
    return await database.deleteDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: documentId,
    );
  }
}
