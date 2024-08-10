import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/widgets/coupon_code_dialog/coupon_code_dialog_widget.dart';
import 'dart:math';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'wallet_page_model.dart';
export 'wallet_page_model.dart';

class WalletPageWidget extends StatefulWidget {
  const WalletPageWidget({super.key});

  @override
  State<WalletPageWidget> createState() => _WalletPageWidgetState();
}

class _WalletPageWidgetState extends State<WalletPageWidget>
    with TickerProviderStateMixin {
  late WalletPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WalletPageModel());

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
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
                    child: Container(
                      width: double.infinity,
                      height: _model.showAppBar ? 250.0 : 80.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF78CA92), Color(0xFF3B6448)],
                          stops: [0, 1],
                          begin: AlignmentDirectional(1, 0.87),
                          end: AlignmentDirectional(-1, -0.87),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional(1, 1),
                        children: [
                          if (_model.showAppBar)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/Group_2671.png',
                                width: 220,
                                height: 158,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    30, 24, 30, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Points',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                lineHeight: 1,
                                              ),
                                        ),
                                        Text(
                                          'Rewards',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                        FFIcons.ksubscriptionCashflow,
                                        color: Color(0xFF57636C),
                                        size: 15,
                                      ),
                                      onPressed: () async {
                                        _model.showAppBar = !_model.showAppBar;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (_model.showAppBar)
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'You currently have in your wallet :',
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                '\$ ${formatNumber(
                                                  valueOrDefault(
                                                          currentUserDocument
                                                              ?.wallet,
                                                          0) /
                                                      50,
                                                  formatType:
                                                      FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.automatic,
                                                )}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 45,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              '50 points become \$1 >',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xA4F9F0F0),
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Number of Availble Coupon:',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                (currentUserDocument?.coupons
                                                            ?.toList() ??
                                                        [])
                                                    .length
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 15)),
                                        ),
                                      ].divide(SizedBox(height: 15)),
                                    ).animateOnPageLoad(animationsMap[
                                        'columnOnPageLoadAnimation']!),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  content: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Coupons',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 22,
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                              FlutterFlowRadioButton(
                                options: ['Bought'].toList(),
                                onChanged: (val) => setState(() {}),
                                controller:
                                    _model.radioButtonValueController ??=
                                        FormFieldController<String>(null),
                                optionHeight: 32,
                                textStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                selectedTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                buttonPosition: RadioButtonPosition.right,
                                direction: Axis.vertical,
                                radioButtonColor:
                                    FlutterFlowTheme.of(context).primary,
                                inactiveRadioButtonColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                toggleable: true,
                                horizontalAlignment: WrapAlignment.start,
                                verticalAlignment: WrapCrossAlignment.start,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: FlutterFlowChoiceChips(
                                options: [
                                  ChipData('Plants'),
                                  ChipData('Equipment'),
                                  ChipData('Fertilizer')
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
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  iconSize: 18,
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                chipSpacing: 12,
                                rowSpacing: 12,
                                multiselect: false,
                                alignment: WrapAlignment.start,
                                controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                  [],
                                ),
                                wrapped: false,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_model.radioButtonValue != 'Bought')
                              StreamBuilder<List<CouponsRecord>>(
                                stream: queryCouponsRecord(
                                  queryBuilder: (couponsRecord) => couponsRecord
                                      .where(
                                        'type',
                                        isEqualTo: _model.choiceChipsValue,
                                      )
                                      .where(
                                        'expire_date',
                                        isGreaterThan: getCurrentTimestamp,
                                      ),
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
                                  List<CouponsRecord>
                                      listViewCouponsRecordList =
                                      snapshot.data!;

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewCouponsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewCouponsRecord =
                                          listViewCouponsRecordList[
                                              listViewIndex];
                                      return Visibility(
                                        visible: !(listViewCouponsRecord.owner
                                            .where((e) =>
                                                e.id ==
                                                currentUserReference?.id)
                                            .toList()
                                            .isNotEmpty),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 15),
                                          child: Container(
                                            width: 100,
                                            height: 107,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0x49A58F8F),
                                                  Color(0x373F3737)
                                                ],
                                                stops: [0, 1],
                                                begin:
                                                    AlignmentDirectional(-1, 0),
                                                end: AlignmentDirectional(1, 0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 118,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Left: ${listViewCouponsRecord.owner.length.toString()}/${listViewCouponsRecord.quantity.toString()}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        13,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            Text(
                                                              '\$ ${formatNumber(
                                                                listViewCouponsRecord
                                                                        .value /
                                                                    50,
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .automatic,
                                                              )}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Color(
                                                                        0xFF88C278),
                                                                    fontSize:
                                                                        17,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            AuthUserStreamWidget(
                                                              builder: (context) =>
                                                                  FFButtonWidget(
                                                                onPressed: ((listViewCouponsRecord.owner.length ==
                                                                            listViewCouponsRecord
                                                                                .quantity) ||
                                                                        (valueOrDefault(currentUserDocument?.wallet,
                                                                                0) <
                                                                            listViewCouponsRecord.value))
                                                                    ? null
                                                                    : () async {
                                                                        await currentUserReference!
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'wallet': FieldValue.increment(-(listViewCouponsRecord.value)),
                                                                              'coupons': FieldValue.arrayUnion([
                                                                                listViewCouponsRecord.reference
                                                                              ]),
                                                                            },
                                                                          ),
                                                                        });

                                                                        await listViewCouponsRecord
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'owner': FieldValue.arrayUnion([
                                                                                currentUserReference
                                                                              ]),
                                                                            },
                                                                          ),
                                                                        });
                                                                      },
                                                                text: 'Get',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: 56,
                                                                  height: 27,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  iconPadding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontSize:
                                                                            14,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                  elevation: 1,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24),
                                                                  disabledColor:
                                                                      Color(
                                                                          0x13737070),
                                                                  disabledTextColor:
                                                                      Color(
                                                                          0x4D000000),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 4)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 100,
                                                        child:
                                                            StyledVerticalDivider(
                                                          thickness: 1,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                          lineStyle:
                                                              DividerLineStyle
                                                                  .dashed,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(14),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  listViewCouponsRecord
                                                                      .companyName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x8EFFFFFF),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            2,
                                                                            8,
                                                                            2),
                                                                    child: Text(
                                                                      listViewCouponsRecord
                                                                          .type,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                Color(0x9714181B),
                                                                            fontSize:
                                                                                10,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10)),
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
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size: 12,
                                                                    ),
                                                                    Text(
                                                                      'Expire:${dateTimeFormat('yMd', listViewCouponsRecord.expireDate)}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                13,
                                                                            letterSpacing:
                                                                                0,
                                                                          ),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              4)),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size: 12,
                                                                    ),
                                                                    Text(
                                                                      listViewCouponsRecord
                                                                          .location,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                13,
                                                                            letterSpacing:
                                                                                0,
                                                                          ),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              4)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.32, 1.26),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.32, -1.29),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            if (_model.radioButtonValue == 'Bought')
                              AuthUserStreamWidget(
                                builder: (context) => Builder(
                                  builder: (context) {
                                    final couponsList = (currentUserDocument
                                                ?.coupons
                                                ?.toList() ??
                                            [])
                                        .toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: couponsList.length,
                                      itemBuilder: (context, couponsListIndex) {
                                        final couponsListItem =
                                            couponsList[couponsListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 15),
                                          child: StreamBuilder<CouponsRecord>(
                                            stream: CouponsRecord.getDocument(
                                                couponsListItem),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
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

                                              final containerCouponsRecord =
                                                  snapshot.data!;

                                              return Container(
                                                width: 100,
                                                height: 107,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0x49A58F8F),
                                                      Color(0x373F3737)
                                                    ],
                                                    stops: [0, 1],
                                                    begin: AlignmentDirectional(
                                                        -1, 0),
                                                    end: AlignmentDirectional(
                                                        1, 0),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 118,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Left: ${containerCouponsRecord.owner.length.toString()}/${containerCouponsRecord.quantity.toString()}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            13,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  '\$ ${formatNumber(
                                                                    containerCouponsRecord
                                                                        .value,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .periodDecimal,
                                                                  )}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        fontSize:
                                                                            17,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      if (containerCouponsRecord
                                                                              .expireDate! >=
                                                                          getCurrentTimestamp) {
                                                                        showDialog(
                                                                          barrierColor:
                                                                              Color(0x31000000),
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (dialogContext) {
                                                                            return Dialog(
                                                                              elevation: 0,
                                                                              insetPadding: EdgeInsets.zero,
                                                                              backgroundColor: Colors.transparent,
                                                                              alignment: AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                              child: GestureDetector(
                                                                                onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                child: CouponCodeDialogWidget(
                                                                                  code: containerCouponsRecord.code,
                                                                                  name: containerCouponsRecord.companyName,
                                                                                  type: containerCouponsRecord.type,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            setState(() {}));

                                                                        await currentUserReference!
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'coupons': FieldValue.arrayRemove([
                                                                                containerCouponsRecord.reference
                                                                              ]),
                                                                            },
                                                                          ),
                                                                        });
                                                                      } else {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'This Coupon is Expired',
                                                                              style: GoogleFonts.getFont(
                                                                                'Roboto',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 15,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                          ),
                                                                        );

                                                                        await currentUserReference!
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'coupons': FieldValue.arrayRemove([
                                                                                containerCouponsRecord.reference
                                                                              ]),
                                                                            },
                                                                          ),
                                                                        });
                                                                      }
                                                                    },
                                                                    text: 'Use',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          27,
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              13,
                                                                              0,
                                                                              13,
                                                                              0),
                                                                      iconPadding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                      elevation:
                                                                          1,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 4)),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 100,
                                                            child:
                                                                StyledVerticalDivider(
                                                              thickness: 1,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                              lineStyle:
                                                                  DividerLineStyle
                                                                      .dashed,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    14),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        containerCouponsRecord
                                                                            .companyName,
                                                                        'Greener',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            fontSize:
                                                                                15,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0x8EFFFFFF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(24),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            8,
                                                                            2,
                                                                            8,
                                                                            2),
                                                                        child:
                                                                            Text(
                                                                          containerCouponsRecord
                                                                              .type,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: Color(0x9714181B),
                                                                                fontSize: 10,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              10)),
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          Icons
                                                                              .calendar_today,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        Text(
                                                                          'Expire:${dateTimeFormat('yMd', containerCouponsRecord.expireDate)}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 13,
                                                                                letterSpacing: 0,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        Text(
                                                                          containerCouponsRecord
                                                                              .location,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 13,
                                                                                letterSpacing: 0,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 4)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -0.32, 1.26),
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -0.32, -1.29),
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ].divide(SizedBox(height: 0)),
                        ),
                      ].divide(SizedBox(height: 17)),
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
