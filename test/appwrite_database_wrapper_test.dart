import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite_database_wrapper/appwrite_database_wrapper.dart';
import 'package:mockito/mockito.dart';

class MockAppwriteDatabaseWrapper extends Mock
    implements AppwriteDatabaseWrapper {}

class MockClient extends Mock implements Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final testUrl = "https://localhost/v1";

  group('AppwriteSingleton', () {
    test('should initialize singleton with provided parameters', () {
      final mockDatabaseWrapper = MockAppwriteDatabaseWrapper();

      AppwriteSingleton(
        appwriteDatabaseWrapper: mockDatabaseWrapper,
        enpointUrl: 'https://localhost/v1',
        projectId: '1234567890',
        selfSigned: true,
      );

      expect(AppwriteSingleton.instance, isNotNull);
      expect(AppwriteSingleton.instance.db, equals(mockDatabaseWrapper));
      expect(AppwriteSingleton.instance.client.endPoint, equals(testUrl));
    });
  });
}
