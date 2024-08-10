import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/gemini/gemini.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/widgets/qr_scanned_dialog/qr_scanned_dialog_widget.dart';
import '/widgets/scanned_disease_plant_dialog/scanned_disease_plant_dialog_widget.dart';
import '/widgets/scanned_plant_details_dialog/scanned_plant_details_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'scanning_page_widget.dart' show ScanningPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScanningPageModel extends FlutterFlowModel<ScanningPageWidget> {
  ///  Local state fields for this page.

  bool showButtons = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  PlantsRecord? outputCopy;
  // Stores action output result for [Gemini - Text From Image] action in IconButton widget.
  String? plantName;
  // Stores action output result for [Gemini - Generate Text] action in IconButton widget.
  String? geminiJson;
  // Stores action output result for [Gemini - Text From Image] action in IconButton widget.
  String? geminiAnswer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
