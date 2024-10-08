import 'package:appwrite_database_wrapper/src/appwrite_database_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppwriteDatabaseModel', () {
    test('should correctly assign name and collection properties', () {
      const model = AppwriteDatabaseModel(name: 'User', collection: 'users');

      expect(model.name, 'User');
      expect(model.collection, 'users');
    });

    test('should be a const instance', () {
      const model1 = AppwriteDatabaseModel(name: 'User1', collection: 'users1');
      const model2 = AppwriteDatabaseModel(name: 'User1', collection: 'users1');

      expect(identical(model1, model2), isTrue);
    });
  });
}
