// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserChatStruct extends FFFirebaseStruct {
  UserChatStruct({
    String? userText,
    String? userImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userText = userText,
        _userImage = userImage,
        super(firestoreUtilData);

  // "userText" field.
  String? _userText;
  String get userText => _userText ?? '';
  set userText(String? val) => _userText = val;

  bool hasUserText() => _userText != null;

  // "userImage" field.
  String? _userImage;
  String get userImage => _userImage ?? '';
  set userImage(String? val) => _userImage = val;

  bool hasUserImage() => _userImage != null;

  static UserChatStruct fromMap(Map<String, dynamic> data) => UserChatStruct(
        userText: data['userText'] as String?,
        userImage: data['userImage'] as String?,
      );

  static UserChatStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserChatStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userText': _userText,
        'userImage': _userImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userText': serializeParam(
          _userText,
          ParamType.String,
        ),
        'userImage': serializeParam(
          _userImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserChatStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserChatStruct(
        userText: deserializeParam(
          data['userText'],
          ParamType.String,
          false,
        ),
        userImage: deserializeParam(
          data['userImage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserChatStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserChatStruct &&
        userText == other.userText &&
        userImage == other.userImage;
  }

  @override
  int get hashCode => const ListEquality().hash([userText, userImage]);
}

UserChatStruct createUserChatStruct({
  String? userText,
  String? userImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserChatStruct(
      userText: userText,
      userImage: userImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserChatStruct? updateUserChatStruct(
  UserChatStruct? userChat, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userChat
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserChatStructData(
  Map<String, dynamic> firestoreData,
  UserChatStruct? userChat,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userChat == null) {
    return;
  }
  if (userChat.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userChat.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userChatData = getUserChatFirestoreData(userChat, forFieldValue);
  final nestedData = userChatData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userChat.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserChatFirestoreData(
  UserChatStruct? userChat, [
  bool forFieldValue = false,
]) {
  if (userChat == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userChat.toMap());

  // Add any Firestore field values
  userChat.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserChatListFirestoreData(
  List<UserChatStruct>? userChats,
) =>
    userChats?.map((e) => getUserChatFirestoreData(e, true)).toList() ?? [];
