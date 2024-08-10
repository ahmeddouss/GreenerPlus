import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'qr_scanned_dialog_model.dart';
export 'qr_scanned_dialog_model.dart';

class QrScannedDialogWidget extends StatefulWidget {
  const QrScannedDialogWidget({
    super.key,
    required this.plantRef,
  });

  final DocumentReference? plantRef;

  @override
  State<QrScannedDialogWidget> createState() => _QrScannedDialogWidgetState();
}

class _QrScannedDialogWidgetState extends State<QrScannedDialogWidget>
    with TickerProviderStateMixin {
  late QrScannedDialogModel _model;

  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QrScannedDialogModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    animationsMap.addAll({
      'progressBarOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.4, 0.4),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 970.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'progressBarOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.4, 0.4),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
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

                  final containerPlantsRecord = snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (containerPlantsRecord.espRef != null)
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional(0, 1),
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        containerPlantsRecord.image,
                                        width: double.infinity,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-0.36, -0.01),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 10),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 2,
                                                sigmaY: 2,
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 1),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              CircularPercentIndicator(
                                                            percent: 0.45,
                                                            radius: 40,
                                                            lineWidth: 8,
                                                            animation: true,
                                                            animateFromLastPercent:
                                                                true,
                                                            progressColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            center: Text(
                                                              'Fill Routine\nin 5 Days\n+25',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize: 9,
                                                                    letterSpacing:
                                                                        0,
                                                                  ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'progressBarOnPageLoadAnimation1']!),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    containerPlantsRecord
                                                                        .name,
                                                                    'None',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontSize:
                                                                            20,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            StreamBuilder<
                                                                List<
                                                                    DataSensorsRecord>>(
                                                              stream:
                                                                  queryDataSensorsRecord(
                                                                parent:
                                                                    containerPlantsRecord
                                                                        .espRef,
                                                                queryBuilder: (dataSensorsRecord) =>
                                                                    dataSensorsRecord.orderBy(
                                                                        'time',
                                                                        descending:
                                                                            true),
                                                                singleRecord:
                                                                    true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<DataSensorsRecord>
                                                                    rowDataSensorsRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                // Return an empty Container when the item does not exist.
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final rowDataSensorsRecord =
                                                                    rowDataSensorsRecordList
                                                                            .isNotEmpty
                                                                        ? rowDataSensorsRecordList
                                                                            .first
                                                                        : null;

                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          FFIcons
                                                                              .kthermometer,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              '${containerPlantsRecord.temperature.toString()}°C',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              'Temperature',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    fontSize: 8,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 4)),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          FFIcons
                                                                              .ktest,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              '${containerPlantsRecord.humidity.toString()}%',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Montserrat',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              'Humidity',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    fontSize: 8,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 4)),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          FFIcons
                                                                              .kbrightness,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          size:
                                                                              17,
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: '${containerPlantsRecord.light.toString()}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          fontSize: 18,
                                                                                          letterSpacing: 0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: 'LDR',
                                                                                    style: TextStyle(
                                                                                      fontSize: 7,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Light',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    fontSize: 8,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 4)),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              10)),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1, -1),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 250),
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
                                Padding(
                                  padding: EdgeInsets.all(18),
                                  child: StreamBuilder<List<DataSensorsRecord>>(
                                    stream: queryDataSensorsRecord(
                                      parent: containerPlantsRecord.espRef,
                                      queryBuilder: (dataSensorsRecord) =>
                                          dataSensorsRecord.orderBy('time',
                                              descending: true),
                                      limit: 7,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<DataSensorsRecord>
                                          rowDataSensorsRecordList =
                                          snapshot.data!;

                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            rowDataSensorsRecordList.length,
                                            (rowIndex) {
                                          final rowDataSensorsRecord =
                                              rowDataSensorsRecordList[
                                                  rowIndex];
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional(0, 1),
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 10,
                                                    height: () {
                                                      if (_model
                                                              .choiceChipsValue ==
                                                          'Temp') {
                                                        return rowDataSensorsRecord
                                                            .temperature
                                                            .toDouble();
                                                      } else if (_model
                                                              .choiceChipsValue ==
                                                          'Hum') {
                                                        return rowDataSensorsRecord
                                                            .humidity
                                                            .toDouble();
                                                      } else if (_model
                                                              .choiceChipsValue ==
                                                          'Ligh') {
                                                        return rowDataSensorsRecord
                                                            .light
                                                            .toDouble();
                                                      } else {
                                                        return 0.0;
                                                      }
                                                    }(),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4
                                                        ],
                                                        stops: [0, 1],
                                                        begin:
                                                            AlignmentDirectional(
                                                                0, 1),
                                                        end:
                                                            AlignmentDirectional(
                                                                0, -1),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      "E",
                                                      rowDataSensorsRecord
                                                          .time),
                                                  '0',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ],
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        '12°-58°',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              fontSize: 12,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x22000000),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: FlutterFlowChoiceChips(
                                          options: [
                                            ChipData('Temp'),
                                            ChipData('Hum'),
                                            ChipData('Ligh')
                                          ],
                                          onChanged: (val) => setState(() =>
                                              _model.choiceChipsValue =
                                                  val?.firstOrNull),
                                          selectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 10,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            iconSize: 18,
                                            elevation: 1,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          unselectedChipStyle: ChipStyle(
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 10,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            iconSize: 18,
                                            elevation: 0,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          chipSpacing: 5,
                                          rowSpacing: 12,
                                          multiselect: false,
                                          alignment: WrapAlignment.start,
                                          controller: _model
                                                  .choiceChipsValueController ??=
                                              FormFieldController<List<String>>(
                                            [],
                                          ),
                                          wrapped: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        if (containerPlantsRecord.espRef == null)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 15, 15, 0),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 1),
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          containerPlantsRecord.image,
                                          width: double.infinity,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.36, -0.01),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 10),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 1),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 1),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: StreamBuilder<
                                                                List<
                                                                    WaterRoutineRecord>>(
                                                              stream:
                                                                  queryWaterRoutineRecord(
                                                                parent:
                                                                    containerPlantsRecord
                                                                        .reference,
                                                                queryBuilder: (waterRoutineRecord) =>
                                                                    waterRoutineRecord.orderBy(
                                                                        'date',
                                                                        descending:
                                                                            true),
                                                                singleRecord:
                                                                    true,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<WaterRoutineRecord>
                                                                    progressBarWaterRoutineRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                // Return an empty Container when the item does not exist.
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final progressBarWaterRoutineRecord =
                                                                    progressBarWaterRoutineRecordList
                                                                            .isNotEmpty
                                                                        ? progressBarWaterRoutineRecordList
                                                                            .first
                                                                        : null;

                                                                return CircularPercentIndicator(
                                                                  percent: (valueOrDefault<
                                                                                  double>(
                                                                                (valueOrDefault<int>(
                                                                                          containerPlantsRecord.interval,
                                                                                          0,
                                                                                        ) -
                                                                                        valueOrDefault<int>(
                                                                                          functions.diffrenceDate(progressBarWaterRoutineRecord!.date!, getCurrentTimestamp),
                                                                                          0,
                                                                                        )) /
                                                                                    valueOrDefault<int>(
                                                                                      containerPlantsRecord.interval,
                                                                                      0,
                                                                                    ),
                                                                                0.0,
                                                                              ) <=
                                                                              1.0) &&
                                                                          (valueOrDefault<
                                                                                  double>(
                                                                                (containerPlantsRecord.interval -
                                                                                        valueOrDefault<int>(
                                                                                          functions.diffrenceDate(progressBarWaterRoutineRecord!.date!, getCurrentTimestamp),
                                                                                          0,
                                                                                        )) /
                                                                                    containerPlantsRecord.interval,
                                                                                0.0,
                                                                              ) >=
                                                                              0.0)
                                                                      ? valueOrDefault<
                                                                          double>(
                                                                          (containerPlantsRecord.interval -
                                                                                  valueOrDefault<int>(
                                                                                    functions.diffrenceDate(progressBarWaterRoutineRecord!.date!, getCurrentTimestamp),
                                                                                    0,
                                                                                  )) /
                                                                              containerPlantsRecord.interval,
                                                                          0.0,
                                                                        )
                                                                      : 0.0,
                                                                  radius: 40,
                                                                  lineWidth: 8,
                                                                  animation:
                                                                      true,
                                                                  animateFromLastPercent:
                                                                      true,
                                                                  progressColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  center: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      'Fill Routine in ${valueOrDefault<String>(
                                                                        functions
                                                                            .diffrenceDate(progressBarWaterRoutineRecord!.date!,
                                                                                getCurrentTimestamp)
                                                                            .toString(),
                                                                        '0',
                                                                      )} Days +${progressBarWaterRoutineRecord?.score?.toString()}',
                                                                      '0',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontSize:
                                                                              10,
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'progressBarOnPageLoadAnimation2']!);
                                                              },
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'containerOnPageLoadAnimation']!),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerPlantsRecord
                                                                          .name,
                                                                      'None',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontSize:
                                                                              20,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              FutureBuilder<
                                                                  ApiCallResponse>(
                                                                future:
                                                                    WeatherCall
                                                                        .call(
                                                                  lat: functions
                                                                      .getLat(
                                                                          currentUserLocationValue),
                                                                  lon: functions
                                                                      .getLong(
                                                                          currentUserLocationValue),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final rowWeatherResponse =
                                                                      snapshot
                                                                          .data!;

                                                                  return Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            FFIcons.kthermometer,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                17,
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                '${valueOrDefault<String>(
                                                                                  ((((WeatherCall.temp(
                                                                                                        rowWeatherResponse.jsonBody,
                                                                                                      )!) -
                                                                                                      273.15) *
                                                                                                  100)
                                                                                              .round() /
                                                                                          100)
                                                                                      .toString(),
                                                                                  '0',
                                                                                )}°C',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                'Temperature',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 8,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ].divide(SizedBox(height: 4)),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            FFIcons.ktest,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                17,
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                '${WeatherCall.humidity(
                                                                                  rowWeatherResponse.jsonBody,
                                                                                )?.toString()}%',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                'Humidity',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 8,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ].divide(SizedBox(height: 4)),
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Icon(
                                                                            FFIcons.krain,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                17,
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${WeatherCall.cloud(
                                                                                        rowWeatherResponse.jsonBody,
                                                                                      )?.toString()}',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 15,
                                                                                            letterSpacing: 0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: '%',
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 18,
                                                                                        letterSpacing: 0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Cloud',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      fontSize: 8,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ].divide(SizedBox(height: 4)),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            10)),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 10)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(1, -1),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20, 250),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20,
                                            buttonSize: 30,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            icon: Icon(
                                              FFIcons.kdelete,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                ),
                                Container(
                                  width: 300,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  7, 0, 12, 0),
                                          child: Text(
                                            'No Esp Card Provided to Track Sensor Data',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x22000000),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
