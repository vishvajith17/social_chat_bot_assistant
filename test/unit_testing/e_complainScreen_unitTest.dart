import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Electricity complain should be recorded.', () async {
    final instance = MockFirestoreInstance();
    await instance
        .collection("electricity_complaint")
        .document('xjtZPHcYBVWbKGcTkpALlfGkWoM2')
        .updateData({
      'account_number': 1600000002,
      'complain_type': 'break-down',
      'complaint': 'one phase out',
      'user': 'ACyIbs3EpzQc7YLnmJZDBWfFydB2',
      'status': 'pending',
      'description': 'Complaint is received',
      'createdAt': DateTime.now()
    });

    final snapshot =
        await instance.collection('electricity_complaint').getDocuments();

    expect(snapshot.documents.length, 1);
    expect(snapshot.documents.first['account_number'], "1600000002");

    instance.dump();
  });
}
