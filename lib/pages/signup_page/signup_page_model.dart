import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'signup_page_widget.dart' show SignupPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPageModel extends FlutterFlowModel<SignupPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? passwordTextController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? passwordTextController1Validator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // State field(s) for emo widget.
  FocusNode? emoFocusNode;
  TextEditingController? emoTextController;
  String? Function(BuildContext, String?)? emoTextControllerValidator;
  String? _emoTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 5) {
      return 'Check phone number';
    }
    if (val.length > 10) {
      return 'Check phone number';
    }
    if (!RegExp(
            '^\\+?([0-9]{1,4})?\\s?([0-9]{1,4})\\s?([0-9]{1,4})\\s?([0-9]{1,9})\$')
        .hasMatch(val)) {
      return 'Check phone number';
    }
    return null;
  }

  // State field(s) for emi widget.
  FocusNode? emiFocusNode;
  TextEditingController? emiTextController;
  String? Function(BuildContext, String?)? emiTextControllerValidator;
  String? _emiTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Verify your email';
    }
    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? passwordTextController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? passwordTextController2Validator;
  String? _passwordTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(
            '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&-])[A-Za-z\\d@\$!%*?&-]{8,}\$')
        .hasMatch(val)) {
      return 'Low Password';
    }
    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? confirmPasswordTextController0;
  late bool passwordVisibility3;
  String? Function(BuildContext, String?)?
      confirmPasswordTextController0Validator;
  String? _confirmPasswordTextController0Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    passwordVisibility1 = false;
    textController1Validator = _textController1Validator;
    emoTextControllerValidator = _emoTextControllerValidator;
    emiTextControllerValidator = _emiTextControllerValidator;
    passwordVisibility2 = false;
    passwordTextController2Validator = _passwordTextController2Validator;
    passwordVisibility3 = false;
    confirmPasswordTextController0Validator =
        _confirmPasswordTextController0Validator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode1?.dispose();
    emailTextController1?.dispose();

    textFieldFocusNode2?.dispose();
    passwordTextController1?.dispose();

    textFieldFocusNode3?.dispose();
    textController1?.dispose();

    emoFocusNode?.dispose();
    emoTextController?.dispose();

    emiFocusNode?.dispose();
    emiTextController?.dispose();

    textFieldFocusNode4?.dispose();
    passwordTextController2?.dispose();

    textFieldFocusNode5?.dispose();
    confirmPasswordTextController0?.dispose();
  }
}
