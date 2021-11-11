import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transport complaint:', () {
    test('Transport complain should be recorded.', () async {
      final instance = MockFirestoreInstance();
      await instance
          .collection("transportComplaint")
          .document('xjtZPHcYBVWbKGcTkpALlfGkWoM2')
          .updateData({
            'medium': 'Train',
            'bus_number': '759',
            'route_origin': 'Colombo',
            'route_destination': 'Ambalangoda',
            'complaint_date': '2021-09-27T12:00:00+06:00',
            'get_off_time': '2021-10-03T16:00:00+06:00',
            'get_off_place': 'Ambalangoda',
            'vehicle_details': 'express',
            'complaint': 'miss-behavior of conductor',
            'reference_no': '1633190985965',
            'last_name': 'vishvajith',
            'email': 'maduka.18@cse.mrt.ac.lk',
            'phone_number': '0774722315',
            'nic': '970173811V',
            'status': 'pending',
      });

      final snapshot =
          await instance.collection('transportComplaint').getDocuments();

      expect(snapshot.documents.length, 1);
      expect(snapshot.documents.first['reference_no'], "1633190985965");

      instance.dump();
    });
  });
}
