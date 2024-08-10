import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/gemini/gemini.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'chat_bot_page_widget.dart' show ChatBotPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatBotPageModel extends FlutterFlowModel<ChatBotPageWidget> {
  ///  Local state fields for this page.

  List<UserAndGeminiStruct> chatHistory = [];
  void addToChatHistory(UserAndGeminiStruct item) => chatHistory.add(item);
  void removeFromChatHistory(UserAndGeminiStruct item) =>
      chatHistory.remove(item);
  void removeAtIndexFromChatHistory(int index) => chatHistory.removeAt(index);
  void insertAtIndexInChatHistory(int index, UserAndGeminiStruct item) =>
      chatHistory.insert(index, item);
  void updateChatHistoryAtIndex(
          int index, Function(UserAndGeminiStruct) updateFn) =>
      chatHistory[index] = updateFn(chatHistory[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Gemini - Text From Image] action in IconButton widget.
  String? geminiResponse;
  // Stores action output result for [Gemini - Generate Text] action in IconButton widget.
  String? geminiResponseText;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    listViewController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
