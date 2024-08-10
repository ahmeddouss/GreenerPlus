import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/widgets/event_details_dialog/event_details_dialog_widget.dart';
import '/widgets/join_event_dialog/join_event_dialog_widget.dart';
import '/widgets/plant_details_dialog/plant_details_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'reminders_page_model.dart';
export 'reminders_page_model.dart';

class RemindersPageWidget extends StatefulWidget {
  const RemindersPageWidget({super.key});

  @override
  State<RemindersPageWidget> createState() => _RemindersPageWidgetState();
}

class _RemindersPageWidgetState extends State<RemindersPageWidget> {
  late RemindersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RemindersPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedDate = getCurrentTimestamp;
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                StickyHeader(
                  overlapHeaders: false,
                  header: Padding(
                    padding: EdgeInsets.all(15),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 850),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 80,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF78CA92), Color(0xFF3B6448)],
                          stops: [0, 1],
                          begin: AlignmentDirectional(1, 0.87),
                          end: AlignmentDirectional(-1, -0.87),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30,
                                24,
                                30,
                                valueOrDefault<double>(
                                  _model.appBarShow ? 0.0 : 24.0,
                                  0.0,
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Calendar',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            lineHeight: 1,
                                          ),
                                    ),
                                    Text(
                                      'Reminders',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 20,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                            lineHeight: 1,
                                          ),
                                    ),
                                  ],
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: 35,
                                  fillColor: Color(0x5FF9F0F0),
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFF57636C),
                                    size: 15,
                                  ),
                                  onPressed: () async {
                                    _model.appBarShow = !_model.appBarShow;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (_model.appBarShow)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                              child: FlutterFlowCalendar(
                                color: FlutterFlowTheme.of(context).primary,
                                iconColor: Colors.white,
                                weekFormat: false,
                                weekStartsMonday: false,
                                initialDate: getCurrentTimestamp,
                                rowHeight: 45,
                                onChange:
                                    (DateTimeRange? newSelectedDate) async {
                                  if (_model.calendarSelectedDay ==
                                      newSelectedDate) {
                                    return;
                                  }
                                  _model.calendarSelectedDay = newSelectedDate;
                                  _model.eventList =
                                      await queryEventsRecordOnce(
                                    queryBuilder: (eventsRecord) =>
                                        eventsRecord.where(
                                      'date',
                                      isEqualTo:
                                          _model.calendarSelectedDay?.start,
                                    ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  _model.selectedDate =
                                      _model.calendarSelectedDay?.start;
                                  setState(() {});
                                  setState(() {});
                                },
                                titleStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: FlutterFlowTheme.of(context).info,
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                dayOfWeekStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Color(0xFFCDFDA8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                    ),
                                dateStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context).info,
                                      fontSize: 15,
                                      letterSpacing: 0,
                                    ),
                                selectedDateStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0,
                                    ),
                                inactiveDateStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFFDDDBDB),
                                      letterSpacing: 0,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  content: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Events',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: FlutterFlowChoiceChips(
                            options: [
                              ChipData('Burned'),
                              ChipData('Pollution'),
                              ChipData('Planting')
                            ],
                            onChanged: (val) => setState(() =>
                                _model.choiceChipsValue = val?.firstOrNull),
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              iconColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              iconSize: 18,
                              elevation: 1,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              iconColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              iconSize: 18,
                              elevation: 0,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            chipSpacing: 12,
                            rowSpacing: 12,
                            multiselect: false,
                            alignment: WrapAlignment.start,
                            controller: _model.choiceChipsValueController ??=
                                FormFieldController<List<String>>(
                              [],
                            ),
                            wrapped: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                          child: StreamBuilder<List<EventsRecord>>(
                            stream: queryEventsRecord(
                              queryBuilder: (eventsRecord) =>
                                  eventsRecord.where(
                                'type',
                                isEqualTo: _model.choiceChipsValue,
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              List<EventsRecord> columnEventsRecordList =
                                  snapshot.data!;

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(columnEventsRecordList.length,
                                        (columnIndex) {
                                  final columnEventsRecord =
                                      columnEventsRecordList[columnIndex];
                                  return Visibility(
                                    visible: functions.compareDates(
                                        columnEventsRecord.date!,
                                        _model.selectedDate!),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 15),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 1, 0, 0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(1, 0, 1, 0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    columnEventsRecord.image,
                                                    width: double.infinity,
                                                    height: 108,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 20,
                                                    sigmaY: 20,
                                                  ),
                                                  child: Builder(
                                                    builder: (context) =>
                                                        InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showDialog(
                                                          barrierColor:
                                                              Color(0x33000000),
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              alignment: AlignmentDirectional(
                                                                      0, 0)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () => _model
                                                                        .unfocusNode
                                                                        .canRequestFocus
                                                                    ? FocusScope.of(
                                                                            context)
                                                                        .requestFocus(_model
                                                                            .unfocusNode)
                                                                    : FocusScope.of(
                                                                            context)
                                                                        .unfocus(),
                                                                child:
                                                                    Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      EventDetailsDialogWidget(
                                                                    eventRef:
                                                                        columnEventsRecord
                                                                            .reference,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            setState(() {}));
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 110,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate
                                                            ],
                                                            stops: [0, 1],
                                                            begin:
                                                                AlignmentDirectional(
                                                                    1, 0.87),
                                                            end:
                                                                AlignmentDirectional(
                                                                    -1, -0.87),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            9),
                                                                child: Image
                                                                    .network(
                                                                  columnEventsRecord
                                                                      .image,
                                                                  width: 83,
                                                                  height: 86,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children:
                                                                                [
                                                                              AutoSizeText(
                                                                                columnEventsRecord.name,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0x8EFFFFFF),
                                                                                  borderRadius: BorderRadius.circular(24),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                                                                                  child: Text(
                                                                                    columnEventsRecord.type,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          color: Color(0x9714181B),
                                                                                          fontSize: 8,
                                                                                          letterSpacing: 0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4)),
                                                                          ),
                                                                          Builder(
                                                                            builder: (context) =>
                                                                                AuthUserStreamWidget(
                                                                              builder: (context) => FlutterFlowIconButton(
                                                                                borderColor: Colors.transparent,
                                                                                borderRadius: 35,
                                                                                buttonSize: 35,
                                                                                fillColor: FlutterFlowTheme.of(context).primary,
                                                                                disabledColor: FlutterFlowTheme.of(context).alternate,
                                                                                disabledIconColor: FlutterFlowTheme.of(context).primaryText,
                                                                                icon: Icon(
                                                                                  Icons.notifications_active_outlined,
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  size: 15,
                                                                                ),
                                                                                onPressed: ((currentUserDocument?.events?.toList() ?? []).where((e) => e.id == columnEventsRecord.reference.id).toList().isNotEmpty)
                                                                                    ? null
                                                                                    : () async {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (dialogContext) {
                                                                                            return Dialog(
                                                                                              elevation: 0,
                                                                                              insetPadding: EdgeInsets.zero,
                                                                                              backgroundColor: Colors.transparent,
                                                                                              alignment: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                                              child: GestureDetector(
                                                                                                onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                                child: JoinEventDialogWidget(
                                                                                                  eventRef: columnEventsRecord.reference,
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => setState(() {}));
                                                                                      },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Icon(
                                                                              Icons.people_alt,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 12,
                                                                            ),
                                                                            Text(
                                                                              'Participants Number: ${columnEventsRecord.participants.length.toString()}',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 4)),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Icon(
                                                                              Icons.location_on,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 12,
                                                                            ),
                                                                            Text(
                                                                              columnEventsRecord.location,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 4)),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Icon(
                                                                              FFIcons.kcircle,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 12,
                                                                            ),
                                                                            Text(
                                                                              dateTimeFormat('M/d h:mm a', columnEventsRecord.date!),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                            ),
                                                                          ].divide(SizedBox(width: 4)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 15)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Plants',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                          child: AuthUserStreamWidget(
                            builder: (context) => Builder(
                              builder: (context) {
                                final plantsList =
                                    (currentUserDocument?.plants?.toList() ??
                                            [])
                                        .toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(plantsList.length,
                                      (plantsListIndex) {
                                    final plantsListItem =
                                        plantsList[plantsListIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 15),
                                      child: StreamBuilder<PlantsRecord>(
                                        stream: PlantsRecord.getDocument(
                                            plantsListItem),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Container();
                                          }

                                          final columnPlantsRecord =
                                              snapshot.data!;

                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              StreamBuilder<
                                                  List<WaterRoutineRecord>>(
                                                stream: queryWaterRoutineRecord(
                                                  parent: columnPlantsRecord
                                                      .reference,
                                                  // singleRecord: true,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Container(); // Show an empty container while loading
                                                  }

                                                  List<WaterRoutineRecord>
                                                      containerWaterRoutineRecordList =
                                                      snapshot.data!;

                                                  // Filter records based on the selected date
                                                  List<WaterRoutineRecord>
                                                      matchingRecords =
                                                      containerWaterRoutineRecordList
                                                          .where((record) =>
                                                              functions.compareDates(
                                                                  record.date!,
                                                                  _model
                                                                      .selectedDate!))
                                                          .toList();

                                                  // Check if there are any matching records
                                                  if (matchingRecords.isEmpty) {
                                                    return Container(); // Return an empty container if no matching records
                                                  }

                                                  // If there are matching records, use the first one or handle as needed
                                                  final containerWaterRoutineRecord =
                                                      matchingRecords.first;

                                                  return Container(
                                                    decoration: BoxDecoration(),
                                                    child: Visibility(
                                                      visible:
                                                          containerWaterRoutineRecord !=
                                                              null,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 1, 0, 0),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          1,
                                                                          0,
                                                                          1,
                                                                          0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image
                                                                    .network(
                                                                  columnPlantsRecord
                                                                      .image,
                                                                  width: double
                                                                      .infinity,
                                                                  height: 108,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 20,
                                                                  sigmaY: 20,
                                                                ),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showDialog(
                                                                        barrierColor:
                                                                            Color(0x33000000),
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                              child: PlantDetailsDialogWidget(
                                                                                plantRef: columnPlantsRecord.reference,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          setState(
                                                                              () {}));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          110,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            FlutterFlowTheme.of(context).alternate,
                                                                            FlutterFlowTheme.of(context).alternate
                                                                          ],
                                                                          stops: [
                                                                            0,
                                                                            1
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              1,
                                                                              0.87),
                                                                          end: AlignmentDirectional(
                                                                              -1,
                                                                              -0.87),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(16),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(9),
                                                                              child: Image.network(
                                                                                columnPlantsRecord.image,
                                                                                width: 83,
                                                                                height: 86,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      columnPlantsRecord.name,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 20,
                                                                                            letterSpacing: 0,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                    ),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0x8EFFFFFF),
                                                                                        borderRadius: BorderRadius.circular(24),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            containerWaterRoutineRecord?.status?.toString(),
                                                                                            'Not Yet',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                color: Color(0x9714181B),
                                                                                                fontSize: 8,
                                                                                                letterSpacing: 0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 4)),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Icon(
                                                                                          FFIcons.kimageSaturation,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 12,
                                                                                        ),
                                                                                        Text(
                                                                                          columnPlantsRecord.water,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0,
                                                                                              ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 4)),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.sports_score_sharp,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 12,
                                                                                        ),
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            containerWaterRoutineRecord?.score?.toString(),
                                                                                            '0',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Roboto',
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0,
                                                                                              ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 4)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ].divide(SizedBox(width: 20)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
