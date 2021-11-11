import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TeleCommunication', () {
    test('Telecommunication complain should be recorded.', () async {
      final instance = MockFirestoreInstance();
      await instance
          .collection("telecomComplaint")
          .document('xjtZPHcYBVWbKGcTkpALlfGkWoM2')
          .updateData({
            'complaint': 'Recharged to a different account',
            'reference_number': '1633190985966',
            'phone_number': '0774722317',
            'date': DateTime.now(),
            'status': 'pending',
            'user_id': 'ACyIbs3EpzQc7YLnmJZDBWfFydB2',
      });

      final snapshot =
          await instance.collection('telecomComplaint').getDocuments();

      expect(snapshot.documents.length, 1);
      expect(snapshot.documents.first['reference_number'], "1633190985966");

      instance.dump();
    });
  });
}
