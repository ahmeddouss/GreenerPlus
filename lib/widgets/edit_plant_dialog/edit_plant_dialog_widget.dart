import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'edit_plant_dialog_model.dart';
export 'edit_plant_dialog_model.dart';

class EditPlantDialogWidget extends StatefulWidget {
  const EditPlantDialogWidget({
    super.key,
    required this.plantRef,
  });

  final DocumentReference? plantRef;

  @override
  State<EditPlantDialogWidget> createState() => _EditPlantDialogWidgetState();
}

class _EditPlantDialogWidgetState extends State<EditPlantDialogWidget> {
  late EditPlantDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPlantDialogModel());

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);

    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: StreamBuilder<PlantsRecord>(
                        stream: PlantsRecord.getDocument(widget!.plantRef!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }

                          final columnPlantsRecord = snapshot.data!;

                          return SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Edit Plant',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1, -1),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 2, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 20,
                                          buttonSize: 30,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          icon: Icon(
                                            FFIcons.kdelete,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 12,
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Opacity(
                                        opacity: 0.3,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FFIcons.kbrowser,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 27,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Sensor Name Selected: ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 15,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                columnPlantsRecord.espRef ==
                                                        null
                                                    ? Text(
                                                        'No Esp Connected',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                ),
                                                      )
                                                    : FutureBuilder<
                                                        EspCardRecord>(
                                                        future: EspCardRecord
                                                            .getDocumentOnce(
                                                                columnPlantsRecord
                                                                    .espRef!),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50,
                                                                height: 50,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }

                                                          final textEspCardRecord =
                                                              snapshot.data!;

                                                          return Text(
                                                            valueOrDefault<
                                                                String>(
                                                              textEspCardRecord
                                                                  .name,
                                                              'No Esp Connected',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                ),
                                                          );
                                                        },
                                                      )
                                              ],
                                            ),
                                          ].divide(SizedBox(width: 20)),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: 0.4,
                                        child: Container(
                                          width: 220,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                        child: TextFormField(
                                          controller: _model.textController1 ??=
                                              TextEditingController(
                                            text: columnPlantsRecord.name,
                                          ),
                                          focusNode: _model.textFieldFocusNode1,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Plant Name',
                                            labelStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            alignLabelWithHint: true,
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      letterSpacing: 0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            contentPadding: EdgeInsets.all(16),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                          validator: _model
                                              .textController1Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x83D4D1D0),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: Container(
                                              width: double.infinity,
                                              color: Color(0x00000000),
                                              child: ExpandableNotifier(
                                                controller: _model
                                                    .expandableExpandableController1,
                                                child: ExpandablePanel(
                                                  header: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Text(
                                                        'Select Photo',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .displaySmall
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  collapsed: Container(
                                                    width: 0,
                                                    height: 0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  ),
                                                  expanded: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 10),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                _model.uploadedFileUrl !=
                                                                            null &&
                                                                        _model.uploadedFileUrl !=
                                                                            ''
                                                                    ? _model
                                                                        .uploadedFileUrl
                                                                    : columnPlantsRecord
                                                                        .image,
                                                                width: 60,
                                                                height: 60,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        FlutterFlowIconButton(
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          borderRadius: 10,
                                                          borderWidth: 1,
                                                          buttonSize: 60,
                                                          fillColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24,
                                                          ),
                                                          showLoadingIndicator:
                                                              true,
                                                          onPressed: () async {
                                                            final selectedMedia =
                                                                await selectMediaWithSourceBottomSheet(
                                                              context: context,
                                                              allowPhoto: true,
                                                            );
                                                            if (selectedMedia !=
                                                                    null &&
                                                                selectedMedia.every((m) =>
                                                                    validateFileFormat(
                                                                        m.storagePath,
                                                                        context))) {
                                                              setState(() =>
                                                                  _model.isDataUploading =
                                                                      true);
                                                              var selectedUploadedFiles =
                                                                  <FFUploadedFile>[];

                                                              var downloadUrls =
                                                                  <String>[];
                                                              try {
                                                                selectedUploadedFiles =
                                                                    selectedMedia
                                                                        .map((m) =>
                                                                            FFUploadedFile(
                                                                              name: m.storagePath.split('/').last,
                                                                              bytes: m.bytes,
                                                                              height: m.dimensions?.height,
                                                                              width: m.dimensions?.width,
                                                                              blurHash: m.blurHash,
                                                                            ))
                                                                        .toList();

                                                                downloadUrls = (await Future
                                                                        .wait(
                                                                  selectedMedia
                                                                      .map(
                                                                    (m) async =>
                                                                        await uploadData(
                                                                            m.storagePath,
                                                                            m.bytes),
                                                                  ),
                                                                ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                              } finally {
                                                                _model.isDataUploading =
                                                                    false;
                                                              }
                                                              if (selectedUploadedFiles
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length &&
                                                                  downloadUrls
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length) {
                                                                setState(() {
                                                                  _model.uploadedLocalFile =
                                                                      selectedUploadedFiles
                                                                          .first;
                                                                  _model.uploadedFileUrl =
                                                                      downloadUrls
                                                                          .first;
                                                                });
                                                              } else {
                                                                setState(() {});
                                                                return;
                                                              }
                                                            }
                                                          },
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 10)),
                                                    ),
                                                  ),
                                                  theme: ExpandableThemeData(
                                                    tapHeaderToExpand: true,
                                                    tapBodyToExpand: false,
                                                    tapBodyToCollapse: false,
                                                    headerAlignment:
                                                        ExpandablePanelHeaderAlignment
                                                            .center,
                                                    hasIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x83D4D1D0),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: Container(
                                              width: double.infinity,
                                              color: Color(0x00000000),
                                              child: ExpandableNotifier(
                                                controller: _model
                                                    .expandableExpandableController2,
                                                child: ExpandablePanel(
                                                  header: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Text(
                                                        'Select threshold',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .displaySmall
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  collapsed: Container(
                                                    width: 0,
                                                    height: 0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  ),
                                                  expanded: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                FFIcons
                                                                    .kthermometer,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 17,
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 85,
                                                                    height: 37,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x8BF9F0F0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                    child:
                                                                        FlutterFlowCountController(
                                                                      decrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .minus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).secondaryText
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      incrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .plus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      countBuilder:
                                                                          (count) =>
                                                                              Text(
                                                                        count
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 18,
                                                                              letterSpacing: 0,
                                                                            ),
                                                                      ),
                                                                      count: _model
                                                                              .countControllerValue1 ??=
                                                                          columnPlantsRecord
                                                                              .temperature,
                                                                      updateCount:
                                                                          (count) =>
                                                                              setState(() => _model.countControllerValue1 = count),
                                                                      stepSize:
                                                                          1,
                                                                      contentPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Temperature',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              8,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        height:
                                                                            4)),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 4)),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                FFIcons.ktest,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 17,
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 85,
                                                                    height: 37,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x8BF9F0F0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                    child:
                                                                        FlutterFlowCountController(
                                                                      decrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .minus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).secondaryText
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      incrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .plus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      countBuilder:
                                                                          (count) =>
                                                                              Text(
                                                                        count
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 18,
                                                                              letterSpacing: 0,
                                                                            ),
                                                                      ),
                                                                      count: _model
                                                                              .countControllerValue2 ??=
                                                                          columnPlantsRecord
                                                                              .humidity,
                                                                      updateCount:
                                                                          (count) =>
                                                                              setState(() => _model.countControllerValue2 = count),
                                                                      stepSize:
                                                                          1,
                                                                      contentPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Humidity',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              8,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        height:
                                                                            4)),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 4)),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                FFIcons
                                                                    .kbrightness,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 17,
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 95,
                                                                    height: 37,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x8BF9F0F0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                    child:
                                                                        FlutterFlowCountController(
                                                                      decrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .minus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).secondaryText
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      incrementIconBuilder:
                                                                          (enabled) =>
                                                                              FaIcon(
                                                                        FontAwesomeIcons
                                                                            .plus,
                                                                        color: enabled
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).alternate,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      countBuilder:
                                                                          (count) =>
                                                                              Text(
                                                                        count
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleLarge
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 18,
                                                                              letterSpacing: 0,
                                                                            ),
                                                                      ),
                                                                      count: _model
                                                                              .countControllerValue3 ??=
                                                                          columnPlantsRecord
                                                                              .light,
                                                                      updateCount:
                                                                          (count) =>
                                                                              setState(() => _model.countControllerValue3 = count),
                                                                      stepSize:
                                                                          1,
                                                                      contentPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Light',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              8,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        height:
                                                                            4)),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 4)),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 3)),
                                                      ),
                                                    ),
                                                  ),
                                                  theme: ExpandableThemeData(
                                                    tapHeaderToExpand: true,
                                                    tapBodyToExpand: false,
                                                    tapBodyToCollapse: false,
                                                    headerAlignment:
                                                        ExpandablePanelHeaderAlignment
                                                            .center,
                                                    hasIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, -1),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x83D4D1D0),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: Container(
                                              width: double.infinity,
                                              color: Color(0x00000000),
                                              child: ExpandableNotifier(
                                                controller: _model
                                                    .expandableExpandableController3,
                                                child: ExpandablePanel(
                                                  header: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 0, 0),
                                                      child: Text(
                                                        'Select Watering Routine',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .displaySmall
                                                            .override(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  collapsed: Container(
                                                    width: 0,
                                                    height: 0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  ),
                                                  expanded: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              'Days Interval: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0x8BF9F0F0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child:
                                                                  FlutterFlowCountController(
                                                                decrementIconBuilder:
                                                                    (enabled) =>
                                                                        FaIcon(
                                                                  FontAwesomeIcons
                                                                      .minus,
                                                                  color: enabled
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  size: 15,
                                                                ),
                                                                incrementIconBuilder:
                                                                    (enabled) =>
                                                                        FaIcon(
                                                                  FontAwesomeIcons
                                                                      .plus,
                                                                  color: enabled
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  size: 15,
                                                                ),
                                                                countBuilder:
                                                                    (count) =>
                                                                        Text(
                                                                  count
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontSize:
                                                                            18,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                                count: _model
                                                                        .countControllerValue4 ??=
                                                                    columnPlantsRecord
                                                                        .interval,
                                                                updateCount: (count) =>
                                                                    setState(() =>
                                                                        _model.countControllerValue4 =
                                                                            count),
                                                                stepSize: 1,
                                                                contentPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 5)),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              'Watering quantity:',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                child:
                                                                    TextFormField(
                                                                  controller: _model
                                                                          .textController2 ??=
                                                                      TextEditingController(
                                                                    text: columnPlantsRecord
                                                                        .water,
                                                                  ),
                                                                  focusNode: _model
                                                                      .textFieldFocusNode2,
                                                                  autofocus:
                                                                      false,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              Color(0xFFF0E8E8),
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                    alignLabelWithHint:
                                                                        true,
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              Color(0xFFF0E8E8),
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                    errorStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          fontSize:
                                                                              10,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0x00000000),
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Color(
                                                                            0x45EDEDED),
                                                                    prefixIcon:
                                                                        Icon(
                                                                      FFIcons
                                                                          .kimageSaturation,
                                                                      color: Color(
                                                                          0xFFF0E8E8),
                                                                      size: 17,
                                                                    ),
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .info,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                  validator: _model
                                                                      .textController2Validator
                                                                      .asValidator(
                                                                          context),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 5)),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                  theme: ExpandableThemeData(
                                                    tapHeaderToExpand: true,
                                                    tapBodyToExpand: false,
                                                    tapBodyToCollapse: false,
                                                    headerAlignment:
                                                        ExpandablePanelHeaderAlignment
                                                            .center,
                                                    hasIcon: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await widget!.plantRef!
                                                .update(createPlantsRecordData(
                                              name: _model.textController1.text,
                                              interval:
                                                  _model.countControllerValue4,
                                              water:
                                                  _model.textController2.text,
                                              temperature:
                                                  _model.countControllerValue1,
                                              light:
                                                  _model.countControllerValue3,
                                              humidity:
                                                  _model.countControllerValue2,
                                              image: _model.uploadedFileUrl !=
                                                          null &&
                                                      _model.uploadedFileUrl !=
                                                          ''
                                                  ? _model.uploadedFileUrl
                                                  : columnPlantsRecord.image,
                                            ));
                                            Navigator.pop(context);

                                            setState(() {});
                                            setState(() {
                                              _model.isDataUploading = false;
                                              _model.uploadedLocalFile =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                              _model.uploadedFileUrl = '';
                                            });
                                          },
                                          text: 'Save',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.white,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 15)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 15)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
