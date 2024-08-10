import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CouponsRecord extends FirestoreRecord {
  CouponsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "expire_date" field.
  DateTime? _expireDate;
  DateTime? get expireDate => _expireDate;
  bool hasExpireDate() => _expireDate != null;

  // "value" field.
  int? _value;
  int get value => _value ?? 0;
  bool hasValue() => _value != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  bool hasCode() => _code != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "owner" field.
  List<DocumentReference>? _owner;
  List<DocumentReference> get owner => _owner ?? const [];
  bool hasOwner() => _owner != null;

  void _initializeFields() {
    _companyName = snapshotData['company_name'] as String?;
    _expireDate = snapshotData['expire_date'] as DateTime?;
    _value = castToType<int>(snapshotData['value']);
    _code = snapshotData['code'] as String?;
    _location = snapshotData['location'] as String?;
    _type = snapshotData['type'] as String?;
    _quantity = castToType<int>(snapshotData['quantity']);
    _owner = getDataList(snapshotData['owner']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('coupons');

  static Stream<CouponsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CouponsRecord.fromSnapshot(s));

  static Future<CouponsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CouponsRecord.fromSnapshot(s));

  static CouponsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CouponsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CouponsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CouponsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CouponsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CouponsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCouponsRecordData({
  String? companyName,
  DateTime? expireDate,
  int? value,
  String? code,
  String? location,
  String? type,
  int? quantity,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'company_name': companyName,
      'expire_date': expireDate,
      'value': value,
      'code': code,
      'location': location,
      'type': type,
      'quantity': quantity,
    }.withoutNulls,
  );

  return firestoreData;
}

class CouponsRecordDocumentEquality implements Equality<CouponsRecord> {
  const CouponsRecordDocumentEquality();

  @override
  bool equals(CouponsRecord? e1, CouponsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.companyName == e2?.companyName &&
        e1?.expireDate == e2?.expireDate &&
        e1?.value == e2?.value &&
        e1?.code == e2?.code &&
        e1?.location == e2?.location &&
        e1?.type == e2?.type &&
        e1?.quantity == e2?.quantity &&
        listEquality.equals(e1?.owner, e2?.owner);
  }

  @override
  int hash(CouponsRecord? e) => const ListEquality().hash([
        e?.companyName,
        e?.expireDate,
        e?.value,
        e?.code,
        e?.location,
        e?.type,
        e?.quantity,
        e?.owner
      ]);

  @override
  bool isValidKey(Object? o) => o is CouponsRecord;
}
