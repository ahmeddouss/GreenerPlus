import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataSensorsRecord extends FirestoreRecord {
  DataSensorsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "light" field.
  int? _light;
  int get light => _light ?? 0;
  bool hasLight() => _light != null;

  // "temperature" field.
  int? _temperature;
  int get temperature => _temperature ?? 0;
  bool hasTemperature() => _temperature != null;

  // "humidity" field.
  int? _humidity;
  int get humidity => _humidity ?? 0;
  bool hasHumidity() => _humidity != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _light = castToType<int>(snapshotData['light']);
    _temperature = castToType<int>(snapshotData['temperature']);
    _humidity = castToType<int>(snapshotData['humidity']);
    _time = snapshotData['time'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('dataSensors')
          : FirebaseFirestore.instance.collectionGroup('dataSensors');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('dataSensors').doc(id);

  static Stream<DataSensorsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DataSensorsRecord.fromSnapshot(s));

  static Future<DataSensorsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DataSensorsRecord.fromSnapshot(s));

  static DataSensorsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DataSensorsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DataSensorsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DataSensorsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DataSensorsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DataSensorsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDataSensorsRecordData({
  int? light,
  int? temperature,
  int? humidity,
  DateTime? time,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'light': light,
      'temperature': temperature,
      'humidity': humidity,
      'time': time,
    }.withoutNulls,
  );

  return firestoreData;
}

class DataSensorsRecordDocumentEquality implements Equality<DataSensorsRecord> {
  const DataSensorsRecordDocumentEquality();

  @override
  bool equals(DataSensorsRecord? e1, DataSensorsRecord? e2) {
    return e1?.light == e2?.light &&
        e1?.temperature == e2?.temperature &&
        e1?.humidity == e2?.humidity &&
        e1?.time == e2?.time;
  }

  @override
  int hash(DataSensorsRecord? e) => const ListEquality()
      .hash([e?.light, e?.temperature, e?.humidity, e?.time]);

  @override
  bool isValidKey(Object? o) => o is DataSensorsRecord;
}
