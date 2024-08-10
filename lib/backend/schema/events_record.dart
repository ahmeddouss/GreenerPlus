import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "score" field.
  int? _score;
  int get score => _score ?? 0;
  bool hasScore() => _score != null;

  // "participants" field.
  List<DocumentReference>? _participants;
  List<DocumentReference> get participants => _participants ?? const [];
  bool hasParticipants() => _participants != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "creature" field.
  DocumentReference? _creature;
  DocumentReference? get creature => _creature;
  bool hasCreature() => _creature != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
    _score = castToType<int>(snapshotData['score']);
    _participants = getDataList(snapshotData['participants']);
    _location = snapshotData['location'] as String?;
    _creature = snapshotData['creature'] as DocumentReference?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? name,
  DateTime? date,
  String? description,
  String? image,
  int? score,
  String? location,
  DocumentReference? creature,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'date': date,
      'description': description,
      'image': image,
      'score': score,
      'location': location,
      'creature': creature,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.date == e2?.date &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image &&
        e1?.score == e2?.score &&
        listEquality.equals(e1?.participants, e2?.participants) &&
        e1?.location == e2?.location &&
        e1?.creature == e2?.creature &&
        e1?.type == e2?.type;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.date,
        e?.description,
        e?.image,
        e?.score,
        e?.participants,
        e?.location,
        e?.creature,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
