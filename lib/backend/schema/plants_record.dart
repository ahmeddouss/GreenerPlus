import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantsRecord extends FirestoreRecord {
  PlantsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "score" field.
  int? _score;
  int get score => _score ?? 0;
  bool hasScore() => _score != null;

  // "creation_date" field.
  DateTime? _creationDate;
  DateTime? get creationDate => _creationDate;
  bool hasCreationDate() => _creationDate != null;

  // "interval" field.
  int? _interval;
  int get interval => _interval ?? 0;
  bool hasInterval() => _interval != null;

  // "water" field.
  String? _water;
  String get water => _water ?? '';
  bool hasWater() => _water != null;

  // "light" field.
  int? _light;
  int get light => _light ?? 0;
  bool hasLight() => _light != null;

  // "humidity" field.
  int? _humidity;
  int get humidity => _humidity ?? 0;
  bool hasHumidity() => _humidity != null;

  // "temperature" field.
  int? _temperature;
  int get temperature => _temperature ?? 0;
  bool hasTemperature() => _temperature != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "esp_ref" field.
  DocumentReference? _espRef;
  DocumentReference? get espRef => _espRef;
  bool hasEspRef() => _espRef != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _score = castToType<int>(snapshotData['score']);
    _creationDate = snapshotData['creation_date'] as DateTime?;
    _interval = castToType<int>(snapshotData['interval']);
    _water = snapshotData['water'] as String?;
    _light = castToType<int>(snapshotData['light']);
    _humidity = castToType<int>(snapshotData['humidity']);
    _temperature = castToType<int>(snapshotData['temperature']);
    _image = snapshotData['image'] as String?;
    _code = snapshotData['code'] as String?;
    _espRef = snapshotData['esp_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plants');

  static Stream<PlantsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlantsRecord.fromSnapshot(s));

  static Future<PlantsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlantsRecord.fromSnapshot(s));

  static PlantsRecord fromSnapshot(DocumentSnapshot snapshot) => PlantsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlantsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlantsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlantsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlantsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlantsRecordData({
  String? name,
  String? description,
  int? score,
  DateTime? creationDate,
  int? interval,
  String? water,
  int? light,
  int? humidity,
  int? temperature,
  String? image,
  String? code,
  DocumentReference? espRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'score': score,
      'creation_date': creationDate,
      'interval': interval,
      'water': water,
      'light': light,
      'humidity': humidity,
      'temperature': temperature,
      'image': image,
      'code': code,
      'esp_ref': espRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlantsRecordDocumentEquality implements Equality<PlantsRecord> {
  const PlantsRecordDocumentEquality();

  @override
  bool equals(PlantsRecord? e1, PlantsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.score == e2?.score &&
        e1?.creationDate == e2?.creationDate &&
        e1?.interval == e2?.interval &&
        e1?.water == e2?.water &&
        e1?.light == e2?.light &&
        e1?.humidity == e2?.humidity &&
        e1?.temperature == e2?.temperature &&
        e1?.image == e2?.image &&
        e1?.code == e2?.code &&
        e1?.espRef == e2?.espRef;
  }

  @override
  int hash(PlantsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.score,
        e?.creationDate,
        e?.interval,
        e?.water,
        e?.light,
        e?.humidity,
        e?.temperature,
        e?.image,
        e?.code,
        e?.espRef
      ]);

  @override
  bool isValidKey(Object? o) => o is PlantsRecord;
}
