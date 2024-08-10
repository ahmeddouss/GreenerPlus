import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/component/drop_down_component/drop_down_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/about_info_dialog/about_info_dialog_widget.dart';
import '/widgets/edit_profile_dialog/edit_profile_dialog_widget.dart';
import '/widgets/event_details_dialog/event_details_dialog_widget.dart';
import '/widgets/logout_dialog/logout_dialog_widget.dart';
import '/widgets/plant_details_dialog/plant_details_dialog_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  Local state fields for this page.

  bool appBarShow = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
