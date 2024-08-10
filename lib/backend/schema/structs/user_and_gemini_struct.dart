// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserAndGeminiStruct extends FFFirebaseStruct {
  UserAndGeminiStruct({
    String? geminiChat,
    UserChatStruct? userChat,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _geminiChat = geminiChat,
        _userChat = userChat,
        super(firestoreUtilData);

  // "geminiChat" field.
  String? _geminiChat;
  String get geminiChat => _geminiChat ?? '';
  set geminiChat(String? val) => _geminiChat = val;

  bool hasGeminiChat() => _geminiChat != null;

  // "userChat" field.
  UserChatStruct? _userChat;
  UserChatStruct get userChat => _userChat ?? UserChatStruct();
  set userChat(UserChatStruct? val) => _userChat = val;

  void updateUserChat(Function(UserChatStruct) updateFn) {
    updateFn(_userChat ??= UserChatStruct());
  }

  bool hasUserChat() => _userChat != null;

  static UserAndGeminiStruct fromMap(Map<String, dynamic> data) =>
      UserAndGeminiStruct(
        geminiChat: data['geminiChat'] as String?,
        userChat: UserChatStruct.maybeFromMap(data['userChat']),
      );

  static UserAndGeminiStruct? maybeFromMap(dynamic data) => data is Map
      ? UserAndGeminiStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'geminiChat': _geminiChat,
        'userChat': _userChat?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'geminiChat': serializeParam(
          _geminiChat,
          ParamType.String,
        ),
        'userChat': serializeParam(
          _userChat,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static UserAndGeminiStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserAndGeminiStruct(
        geminiChat: deserializeParam(
          data['geminiChat'],
          ParamType.String,
          false,
        ),
        userChat: deserializeStructParam(
          data['userChat'],
          ParamType.DataStruct,
          false,
          structBuilder: UserChatStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'UserAndGeminiStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserAndGeminiStruct &&
        geminiChat == other.geminiChat &&
        userChat == other.userChat;
  }

  @override
  int get hashCode => const ListEquality().hash([geminiChat, userChat]);
}

UserAndGeminiStruct createUserAndGeminiStruct({
  String? geminiChat,
  UserChatStruct? userChat,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserAndGeminiStruct(
      geminiChat: geminiChat,
      userChat: userChat ?? (clearUnsetFields ? UserChatStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserAndGeminiStruct? updateUserAndGeminiStruct(
  UserAndGeminiStruct? userAndGemini, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userAndGemini
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserAndGeminiStructData(
  Map<String, dynamic> firestoreData,
  UserAndGeminiStruct? userAndGemini,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userAndGemini == null) {
    return;
  }
  if (userAndGemini.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userAndGemini.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userAndGeminiData =
      getUserAndGeminiFirestoreData(userAndGemini, forFieldValue);
  final nestedData =
      userAndGeminiData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userAndGemini.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserAndGeminiFirestoreData(
  UserAndGeminiStruct? userAndGemini, [
  bool forFieldValue = false,
]) {
  if (userAndGemini == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userAndGemini.toMap());

  // Handle nested data for "userChat" field.
  addUserChatStructData(
    firestoreData,
    userAndGemini.hasUserChat() ? userAndGemini.userChat : null,
    'userChat',
    forFieldValue,
  );

  // Add any Firestore field values
  userAndGemini.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserAndGeminiListFirestoreData(
  List<UserAndGeminiStruct>? userAndGeminis,
) =>
    userAndGeminis
        ?.map((e) => getUserAndGeminiFirestoreData(e, true))
        .toList() ??
    [];
