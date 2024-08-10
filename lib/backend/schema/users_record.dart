import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "score" field.
  int? _score;
  int get score => _score ?? 0;
  bool hasScore() => _score != null;

  // "plants" field.
  List<DocumentReference>? _plants;
  List<DocumentReference> get plants => _plants ?? const [];
  bool hasPlants() => _plants != null;

  // "wallet" field.
  int? _wallet;
  int get wallet => _wallet ?? 0;
  bool hasWallet() => _wallet != null;

  // "events" field.
  List<DocumentReference>? _events;
  List<DocumentReference> get events => _events ?? const [];
  bool hasEvents() => _events != null;

  // "esp_cards" field.
  List<DocumentReference>? _espCards;
  List<DocumentReference> get espCards => _espCards ?? const [];
  bool hasEspCards() => _espCards != null;

  // "coupons" field.
  List<DocumentReference>? _coupons;
  List<DocumentReference> get coupons => _coupons ?? const [];
  bool hasCoupons() => _coupons != null;

  // "device_uid" field.
  String? _deviceUid;
  String get deviceUid => _deviceUid ?? '';
  bool hasDeviceUid() => _deviceUid != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _score = castToType<int>(snapshotData['score']);
    _plants = getDataList(snapshotData['plants']);
    _wallet = castToType<int>(snapshotData['wallet']);
    _events = getDataList(snapshotData['events']);
    _espCards = getDataList(snapshotData['esp_cards']);
    _coupons = getDataList(snapshotData['coupons']);
    _deviceUid = snapshotData['device_uid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? score,
  int? wallet,
  String? deviceUid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'score': score,
      'wallet': wallet,
      'device_uid': deviceUid,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.score == e2?.score &&
        listEquality.equals(e1?.plants, e2?.plants) &&
        e1?.wallet == e2?.wallet &&
        listEquality.equals(e1?.events, e2?.events) &&
        listEquality.equals(e1?.espCards, e2?.espCards) &&
        listEquality.equals(e1?.coupons, e2?.coupons) &&
        e1?.deviceUid == e2?.deviceUid;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.score,
        e?.plants,
        e?.wallet,
        e?.events,
        e?.espCards,
        e?.coupons,
        e?.deviceUid
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
