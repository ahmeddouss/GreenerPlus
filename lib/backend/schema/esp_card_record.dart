import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EspCardRecord extends FirestoreRecord {
  EspCardRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "wifi" field.
  String? _wifi;
  String get wifi => _wifi ?? '';
  bool hasWifi() => _wifi != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "plant_name" field.
  String? _plantName;
  String get plantName => _plantName ?? '';
  bool hasPlantName() => _plantName != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _wifi = snapshotData['wifi'] as String?;
    _password = snapshotData['password'] as String?;
    _plantName = snapshotData['plant_name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('espCard');

  static Stream<EspCardRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EspCardRecord.fromSnapshot(s));

  static Future<EspCardRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EspCardRecord.fromSnapshot(s));

  static EspCardRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EspCardRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EspCardRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EspCardRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EspCardRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EspCardRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEspCardRecordData({
  String? name,
  String? wifi,
  String? password,
  String? plantName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'wifi': wifi,
      'password': password,
      'plant_name': plantName,
    }.withoutNulls,
  );

  return firestoreData;
}

class EspCardRecordDocumentEquality implements Equality<EspCardRecord> {
  const EspCardRecordDocumentEquality();

  @override
  bool equals(EspCardRecord? e1, EspCardRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.wifi == e2?.wifi &&
        e1?.password == e2?.password &&
        e1?.plantName == e2?.plantName;
  }

  @override
  int hash(EspCardRecord? e) =>
      const ListEquality().hash([e?.name, e?.wifi, e?.password, e?.plantName]);

  @override
  bool isValidKey(Object? o) => o is EspCardRecord;
}
