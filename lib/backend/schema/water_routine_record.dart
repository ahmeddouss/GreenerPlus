import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WaterRoutineRecord extends FirestoreRecord {
  WaterRoutineRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  bool hasStatus() => _status != null;

  // "score" field.
  double? _score;
  double get score => _score ?? 0.0;
  bool hasScore() => _score != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _status = snapshotData['status'] as bool?;
    _score = castToType<double>(snapshotData['score']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('water_routine')
          : FirebaseFirestore.instance.collectionGroup('water_routine');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('water_routine').doc(id);

  static Stream<WaterRoutineRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WaterRoutineRecord.fromSnapshot(s));

  static Future<WaterRoutineRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WaterRoutineRecord.fromSnapshot(s));

  static WaterRoutineRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WaterRoutineRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WaterRoutineRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WaterRoutineRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WaterRoutineRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WaterRoutineRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWaterRoutineRecordData({
  DateTime? date,
  bool? status,
  double? score,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'status': status,
      'score': score,
    }.withoutNulls,
  );

  return firestoreData;
}

class WaterRoutineRecordDocumentEquality
    implements Equality<WaterRoutineRecord> {
  const WaterRoutineRecordDocumentEquality();

  @override
  bool equals(WaterRoutineRecord? e1, WaterRoutineRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.status == e2?.status &&
        e1?.score == e2?.score;
  }

  @override
  int hash(WaterRoutineRecord? e) =>
      const ListEquality().hash([e?.date, e?.status, e?.score]);

  @override
  bool isValidKey(Object? o) => o is WaterRoutineRecord;
}
