import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Lost something:', () {
    test('Transport lost something should be recorded.', () async {
      final instance = MockFirestoreInstance();
      await instance
          .collection("transportLost")
          .document('xjtZPHcYBVWbKGcTkpALlfGkWoM2')
          .updateData({
            'medium': 'Train',
            'route_origin': 'Colombo',
            'route_destination': 'Ambalangoda',
            'lost_items': ['laptop'],
            'lost_item_details': 'Asus laptop',
            'lost_date': '2021-10-02T12:00:00+06:00',
            'get_off_time': '2021-10-03T16:00:00+06:00',
            'get_off_place': 'Ambalangoda',
            'vehicle_details': 'express',
            'reference_no': '1633190985964',
            'last_name': 'vishvajith',
            'email': 'maduka.18@cse.mrt.ac.lk',
            'phone_number': '0774722315',
            'nic': '970173811V',
            'status': 'pending'
      });

      final snapshot =
          await instance.collection('transportLost').getDocuments();

      expect(snapshot.documents.length, 1);
      expect(snapshot.documents.first['reference_no'], "1633190985964");

      instance.dump();
    });
  });
}
