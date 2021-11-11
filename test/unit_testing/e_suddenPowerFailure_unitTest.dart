import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Electricity sudden power failure should be recorded.', () async {
    final instance = MockFirestoreInstance();
    await instance
        .collection("electricity_sudden_powercut")
        .document('xjtZPHcYBVWbKGcTkpALlfGkWoM2')
        .updateData({
      'account_number': 1600000002,
      'date_time': '24 September 2021 at 11:30:00 UTC+5:30',
      'user': 'ACyIbs3EpzQc7YLnmJZDBWfFydB2',
      'status': 'pending',
      'description': 'reported by customers',
      'createdAt': DateTime.now()
    });

    final snapshot =
        await instance.collection('electricity_sudden_powercut').getDocuments();

    expect(snapshot.documents.length, 1);
    expect(snapshot.documents.first['account_number'], "1600000002");

    instance.dump();
  });
}
