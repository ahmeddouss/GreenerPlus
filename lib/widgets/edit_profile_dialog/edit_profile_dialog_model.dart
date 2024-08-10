import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'edit_profile_dialog_widget.dart' show EditProfileDialogWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileDialogModel extends FlutterFlowModel<EditProfileDialogWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for projectURL widget.
  FocusNode? projectURLFocusNode1;
  TextEditingController? projectURLTextController1;
  String? Function(BuildContext, String?)? projectURLTextController1Validator;
  String? _projectURLTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Username is required';
    }

    if (val.length < 5) {
      return 'check Username';
    }
    if (val.length > 17) {
      return 'check Username';
    }
    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'check Username';
    }
    return null;
  }

  // State field(s) for projectURL widget.
  FocusNode? projectURLFocusNode2;
  TextEditingController? projectURLTextController2;
  String? Function(BuildContext, String?)? projectURLTextController2Validator;
  String? _projectURLTextController2Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Check Phone Number';
    }

    if (val.length < 5) {
      return 'Requires at least 5 characters.';
    }
    if (val.length > 15) {
      return 'Maximum 15 characters allowed, currently ${val.length}.';
    }
    if (!RegExp(
            '^\\+?([0-9]{1,4})?\\s?([0-9]{1,4})\\s?([0-9]{1,4})\\s?([0-9]{1,9})\$')
        .hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // State field(s) for clonableURL widget.
  FocusNode? clonableURLFocusNode;
  TextEditingController? clonableURLTextController;
  String? Function(BuildContext, String?)? clonableURLTextControllerValidator;
  String? _clonableURLTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Check Email';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Check Email';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    projectURLTextController1Validator = _projectURLTextController1Validator;
    projectURLTextController2Validator = _projectURLTextController2Validator;
    clonableURLTextControllerValidator = _clonableURLTextControllerValidator;
  }

  @override
  void dispose() {
    projectURLFocusNode1?.dispose();
    projectURLTextController1?.dispose();

    projectURLFocusNode2?.dispose();
    projectURLTextController2?.dispose();

    clonableURLFocusNode?.dispose();
    clonableURLTextController?.dispose();
  }
}
