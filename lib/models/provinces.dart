import 'package:cloud_firestore/cloud_firestore.dart';

class e_proviences {
  final String name;
  final DateTime timestamp;
  final DocumentReference reference;

  e_proviences.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        timestamp = (map['timestamp'] as Timestamp)?.toDate();

  e_proviences.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return 'Messages{name: $name, timestamp: $timestamp,  reference: $reference}';
  }
}