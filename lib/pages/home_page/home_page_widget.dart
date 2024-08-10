import 'package:greener_plus/services/firebase_api.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/widgets/add_plant_dialog/add_plant_dialog_widget.dart';
import '/widgets/check_place_dialog/check_place_dialog_widget.dart';
import '/widgets/find_plant_dialog/find_plant_dialog_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};
  Future<ApiCallResponse>? _weatherFuture;
  bool _showWeather = false;
  ApiCallResponse? _weatherResponse;
  String _geminiAdvice = 'Preparing Answer...';

  void _toggleWeather() async {
    setState(() {
      _showWeather = !_showWeather;
      if (_showWeather) {
        _weatherFuture = WeatherCall.call(
          lat: functions.getLat(currentUserLocationValue),
          lon: functions.getLong(currentUserLocationValue),
        );
        _weatherFuture!.then((response) async {
          if (response.succeeded) {
            _weatherResponse = response;
            final geminiResult = await GeminiCall.call(
              message:
                  'i am going to give you the current weather values and you give me small advice to trate my plants depending on that wathear (max 2 lines)Temperature (in kelvin):${valueOrDefault<String>(
                WeatherCall.temp(response.jsonBody)?.toString(),
                '0',
              )}Wind speed (km/h or m/s):${valueOrDefault<String>(
                WeatherCall.wind(response.jsonBody)?.toString(),
                '0',
              )}Cloud cover (%):${WeatherCall.cloud(response.jsonBody)?.toString()}Humidity (%):${valueOrDefault<String>(
                WeatherCall.humidity(response.jsonBody)?.toString(),
                '0',
              )}',
            );
            if (geminiResult.succeeded) {
              setState(() {
                _geminiAdvice =
                    GeminiCall.response(geminiResult.jsonBody) ?? 'No advice';
              });
            }
          } else {
            setState(() {
              _geminiAdvice = 'Failed to load weather data';
            });
          }
        });
      } else {
        _weatherFuture = null;
        _weatherResponse = null;
        _geminiAdvice = 'Preparing Answer...';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    FirebaseApi.instance.initFrontNotif(context);
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      String? token = await FirebaseApi.instance.getFcmToken();

      await currentUserReference!
          .update(createUsersRecordData(deviceUid: token));
      _model.plantView = (currentUserDocument?.plants?.toList() ?? []).first;
      setState(() {});
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 790.0.ms,
            color: FlutterFlowTheme.of(context).accent1,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).accent1,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).accent1,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).accent1,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
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
      'progressBarOnPageLoadAnimation': AnimationInfo(
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
    _model.dispose();

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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: RefreshIndicator(
            onRefresh: () async {
              _model.plantView =
                  (currentUserDocument?.plants?.toList() ?? []).first;
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  StickyHeader(
                    overlapHeaders: false,
                    header: Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 80),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                30,
                                24,
                                30,
                                _showWeather ? 0.0 : 25.0,
                              ),
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
                                        'Current',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              lineHeight: 1,
                                            ),
                                      ),
                                      Text(
                                        'Weather',
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
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0x5FF9F0F0),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: ToggleIcon(
                                        onPressed: _toggleWeather,
                                        value: _showWeather,
                                        onIcon: Icon(
                                          Icons.keyboard_arrow_up_outlined,
                                          color: Color(0xFF57636C),
                                          size: 20,
                                        ),
                                        offIcon: Icon(
                                          Icons.cloud_outlined,
                                          color: Color(0xFF57636C),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_showWeather)
                              FutureBuilder<ApiCallResponse>(
                                future: _weatherFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error loading weather data'),
                                    );
                                  } else if (snapshot.hasData) {
                                    final columnWeatherResponse =
                                        snapshot.data!;
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25, 0, 25, 0),
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
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons
                                                                .kthermometer,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            'Temperature: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 3)),
                                                      ),
                                                      Text(
                                                        '${valueOrDefault<String>(
                                                          ((((WeatherCall.temp(
                                                                                columnWeatherResponse.jsonBody,
                                                                              )!) -
                                                                              273.15) *
                                                                          100)
                                                                      .round() /
                                                                  100)
                                                              .toString(),
                                                          '0',
                                                        )}°C',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.kwind,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            'Wind: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 3)),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          WeatherCall.wind(
                                                            columnWeatherResponse
                                                                .jsonBody,
                                                          )?.toString(),
                                                          '0',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(SizedBox(height: 5)),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.ktest,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            'Humidity: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 3)),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          WeatherCall.humidity(
                                                            columnWeatherResponse
                                                                .jsonBody,
                                                          )?.toString(),
                                                          '0',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(
                                                            FFIcons.krain,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .info,
                                                            size: 17,
                                                          ),
                                                          Text(
                                                            'Cloud: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 3)),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          WeatherCall.cloud(
                                                            columnWeatherResponse
                                                                .jsonBody,
                                                          )?.toString(),
                                                          '0',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(SizedBox(height: 5)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 20),
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional(1, 1),
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1, 1),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Image.asset(
                                                      'assets/images/Vector_44.png',
                                                      width: 15,
                                                      height: 15,
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          Alignment(0, 0),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0x24FFFFFF),
                                                        Color(0x05FFFFFF)
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          AlignmentDirectional(
                                                              1, 0.87),
                                                      end: AlignmentDirectional(
                                                          -1, -0.87),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 10, 15, 10),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Gemini Advices: ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: _geminiAdvice,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  letterSpacing:
                                                                      0,
                                                                ),
                                                          ),
                                                        ],
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Roboto',
                                                              letterSpacing: 0,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'containerOnPageLoadAnimation1']!),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 17)),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('No data available'),
                                    );
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    content: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Features',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 22,
                                    letterSpacing: 0,
                                  ),
                            ),
                            Container(
                              height: 116,
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) => Padding(
                                            padding: EdgeInsets.all(10),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showDialog(
                                                  barrierColor:
                                                      Color(0x1E000000),
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0, 0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: GestureDetector(
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
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child:
                                                              AddPlantDialogWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          AlignmentDirectional(
                                                              1, 0.87),
                                                      end: AlignmentDirectional(
                                                          -1, -0.87),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(14),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        'assets/images/add-1--expand-cross-buttons-button-more-remove-plus-add-+-mathematics-math.png',
                                                        width: 14,
                                                        height: 34,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Add Plant',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed('ChatBotPage');
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                      Color(0xA4667AC9)
                                                    ],
                                                    stops: [0, 1],
                                                    begin: AlignmentDirectional(
                                                        1, 0.87),
                                                    end: AlignmentDirectional(
                                                        -1, -0.87),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(14),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.asset(
                                                      'assets/images/Group_2678.png',
                                                      width: 14,
                                                      height: 34,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'containerOnPageLoadAnimation2']!),
                                        ),
                                        Text(
                                          'Chat Bot',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) => Padding(
                                            padding: EdgeInsets.all(10),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0, 0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: GestureDetector(
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
                                                            CheckPlaceDialogWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                        Color(0xA4667AC9)
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          AlignmentDirectional(
                                                              1, 0.87),
                                                      end: AlignmentDirectional(
                                                          -1, -0.87),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(14),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        'assets/images/Group_2679.png',
                                                        width: 14,
                                                        height: 34,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation3']!),
                                          ),
                                        ),
                                        Text(
                                          'Check Place',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) => Padding(
                                            padding: EdgeInsets.all(10),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showDialog(
                                                  barrierColor:
                                                      Color(0x40000000),
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0, 0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: GestureDetector(
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
                                                            FindPlantDialogWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                        Color(0xA4667AC9)
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          AlignmentDirectional(
                                                              1, 0.87),
                                                      end: AlignmentDirectional(
                                                          -1, -0.87),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2, 0, 0, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.asset(
                                                          'assets/images/magnifying-glass--glass-search-magnifying.png',
                                                          width: 35,
                                                          height: 35,
                                                          fit: BoxFit.cover,
                                                          alignment:
                                                              Alignment(0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'containerOnPageLoadAnimation4']!),
                                          ),
                                        ),
                                        Text(
                                          'Search Plant',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 13,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 0)),
                                    ),
                                  ].divide(SizedBox(width: 0)),
                                ),
                              ),
                            ),
                            if (_model.plantView != null)
                              // Generated code for this Column Widget...
                              if (_model.plantView != null)
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Plants',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 22,
                                            letterSpacing: 0,
                                          ),
                                    ),
                                    AuthUserStreamWidget(
                                      builder: (context) => Builder(
                                        builder: (context) {
                                          final myPlants = (currentUserDocument
                                                      ?.plants
                                                      ?.toList() ??
                                                  [])
                                              .toList();
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children:
                                                  List.generate(myPlants.length,
                                                      (myPlantsIndex) {
                                                final myPlantsItem =
                                                    myPlants[myPlantsIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: StreamBuilder<
                                                      PlantsRecord>(
                                                    stream: PlantsRecord
                                                        .getDocument(
                                                            myPlantsItem),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      final containerPlantsRecord =
                                                          snapshot.data!;
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          _model.plantView =
                                                              containerPlantsRecord
                                                                  .reference;
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 35,
                                                          constraints:
                                                              BoxConstraints(
                                                            maxHeight: 35,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: containerPlantsRecord.reference ==
                                                                    _model
                                                                        .plantView
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15,
                                                                        0,
                                                                        15,
                                                                        0),
                                                            child: Text(
                                                              containerPlantsRecord
                                                                  .name,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: containerPlantsRecord.reference ==
                                                                            _model
                                                                                .plantView
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    fontSize:
                                                                        13,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                          animationsMap[
                                                              'containerOnPageLoadAnimation5']!);
                                                    },
                                                  ),
                                                );
                                              }).divide(SizedBox(width: 15)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 20),
                                      child: StreamBuilder<PlantsRecord>(
                                        stream: PlantsRecord.getDocument(
                                            _model.plantView!),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final containerPlantsRecord =
                                              snapshot.data!;
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (containerPlantsRecord
                                                        .espRef ==
                                                    null)
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 1),
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15,
                                                                        15,
                                                                        15,
                                                                        0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child:
                                                                  Image.network(
                                                                containerPlantsRecord
                                                                    .image,
                                                                width: double
                                                                    .infinity,
                                                                height: 300,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -0.36,
                                                                    -0.01),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          25,
                                                                          0,
                                                                          25,
                                                                          10),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  child:
                                                                      BackdropFilter(
                                                                    filter:
                                                                        ImageFilter
                                                                            .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY: 2,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              1),
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            120,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          borderRadius:
                                                                              BorderRadius.circular(0),
                                                                        ),
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            1),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: 100,
                                                                                height: 100,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                child: StreamBuilder<List<WaterRoutineRecord>>(
                                                                                  stream: queryWaterRoutineRecord(
                                                                                    parent: containerPlantsRecord.reference,
                                                                                    queryBuilder: (waterRoutineRecord) => waterRoutineRecord.orderBy('date', descending: true),
                                                                                    singleRecord: true,
                                                                                  ),
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
                                                                                    List<WaterRoutineRecord> progressBarWaterRoutineRecordList = snapshot.data!;
                                                                                    // Return an empty Container when the item does not exist.
                                                                                    if (snapshot.data!.isEmpty) {
                                                                                      return Container();
                                                                                    }
                                                                                    final progressBarWaterRoutineRecord = progressBarWaterRoutineRecordList.isNotEmpty ? progressBarWaterRoutineRecordList.first : null;
                                                                                    return CircularPercentIndicator(
                                                                                      percent: (valueOrDefault<double>(
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
                                                                                              (valueOrDefault<double>(
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
                                                                                                  ) >=
                                                                                                  0.0)
                                                                                          ? valueOrDefault<double>(
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
                                                                                            )
                                                                                          : 0.0,
                                                                                      radius: 50,
                                                                                      lineWidth: 8,
                                                                                      animation: true,
                                                                                      animateFromLastPercent: true,
                                                                                      progressColor: FlutterFlowTheme.of(context).primary,
                                                                                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                      center: Text(
                                                                                        valueOrDefault<String>(
                                                                                          'Fill Routine in ${valueOrDefault<String>(
                                                                                            functions.diffrenceDate(progressBarWaterRoutineRecord!.date!, getCurrentTimestamp).toString(),
                                                                                            '0',
                                                                                          )} Days +${progressBarWaterRoutineRecord?.score?.toString()}',
                                                                                          '0',
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                              fontFamily: 'Montserrat',
                                                                                              fontSize: 10,
                                                                                              letterSpacing: 0,
                                                                                            ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        valueOrDefault<String>(
                                                                                          containerPlantsRecord.name,
                                                                                          'None',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Montserrat',
                                                                                              fontSize: 20,
                                                                                              letterSpacing: 0,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  FutureBuilder<ApiCallResponse>(
                                                                                    future: WeatherCall.call(
                                                                                      lat: functions.getLat(currentUserLocationValue),
                                                                                      lon: functions.getLong(currentUserLocationValue),
                                                                                    ),
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
                                                                                      final rowWeatherResponse = snapshot.data!;
                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Icon(
                                                                                                FFIcons.kthermometer,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 17,
                                                                                              ),
                                                                                              Column(
                                                                                                mainAxisSize: MainAxisSize.max,
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
                                                                                                          color: (((((WeatherCall.temp(
                                                                                                                                        rowWeatherResponse.jsonBody,
                                                                                                                                      )!) -
                                                                                                                                      273.15) *
                                                                                                                                  100)
                                                                                                                              .round() /
                                                                                                                          100)! >
                                                                                                                      (containerPlantsRecord.temperature + 30).toDouble()) ||
                                                                                                                  (((((WeatherCall.temp(
                                                                                                                                        rowWeatherResponse.jsonBody,
                                                                                                                                      )!) -
                                                                                                                                      273.15) *
                                                                                                                                  100)
                                                                                                                              .round() /
                                                                                                                          100)! <
                                                                                                                      (containerPlantsRecord.temperature - 30).toDouble())
                                                                                                              ? FlutterFlowTheme.of(context).error
                                                                                                              : FlutterFlowTheme.of(context).primaryText,
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
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Icon(
                                                                                                FFIcons.ktest,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 17,
                                                                                              ),
                                                                                              Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    '${WeatherCall.humidity(
                                                                                                      rowWeatherResponse.jsonBody,
                                                                                                    )?.toString()}%',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Montserrat',
                                                                                                          color: (WeatherCall.humidity(
                                                                                                                        rowWeatherResponse.jsonBody,
                                                                                                                      )! >
                                                                                                                      (containerPlantsRecord.humidity + 30)) ||
                                                                                                                  (WeatherCall.humidity(
                                                                                                                        rowWeatherResponse.jsonBody,
                                                                                                                      )! <
                                                                                                                      (containerPlantsRecord.humidity - 30))
                                                                                                              ? FlutterFlowTheme.of(context).error
                                                                                                              : FlutterFlowTheme.of(context).primaryText,
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
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Icon(
                                                                                                FFIcons.krain,
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                size: 17,
                                                                                              ),
                                                                                              Column(
                                                                                                mainAxisSize: MainAxisSize.max,
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
                                                                                                            fontSize: 15,
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
                                                                                        ].divide(SizedBox(width: 10)),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ].divide(SizedBox(width: 10)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 300,
                                                        height: 27,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 10, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                child: Text(
                                                                  'No Esp Card Provided to Track Sensor Data',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x22000000),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 10)),
                                                  ),
                                                if (containerPlantsRecord
                                                        .espRef !=
                                                    null)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 15),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 1),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          15,
                                                                          15,
                                                                          15,
                                                                          0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                child: Image
                                                                    .network(
                                                                  containerPlantsRecord
                                                                      .image,
                                                                  width: double
                                                                      .infinity,
                                                                  height: 300,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -0.36,
                                                                      -0.01),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            25,
                                                                            0,
                                                                            25,
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    child:
                                                                        BackdropFilter(
                                                                      filter: ImageFilter
                                                                          .blur(
                                                                        sigmaX:
                                                                            2,
                                                                        sigmaY:
                                                                            2,
                                                                      ),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            1),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              120,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              1),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 100,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: StreamBuilder<List<WaterRoutineRecord>>(
                                                                                    stream: queryWaterRoutineRecord(
                                                                                      parent: containerPlantsRecord.reference,
                                                                                      queryBuilder: (waterRoutineRecord) => waterRoutineRecord.orderBy('date', descending: true),
                                                                                      singleRecord: true,
                                                                                    ),
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
                                                                                      List<WaterRoutineRecord> progressBarWaterRoutineRecordList = snapshot.data!;
                                                                                      // Return an empty Container when the item does not exist.
                                                                                      if (snapshot.data!.isEmpty) {
                                                                                        return Container();
                                                                                      }
                                                                                      final progressBarWaterRoutineRecord = progressBarWaterRoutineRecordList.isNotEmpty ? progressBarWaterRoutineRecordList.first : null;
                                                                                      return CircularPercentIndicator(
                                                                                        percent: (valueOrDefault<double>(
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
                                                                                                (valueOrDefault<double>(
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
                                                                                                    ) >=
                                                                                                    0.0)
                                                                                            ? valueOrDefault<double>(
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
                                                                                              )
                                                                                            : 0.0,
                                                                                        radius: 50,
                                                                                        lineWidth: 8,
                                                                                        animation: true,
                                                                                        animateFromLastPercent: true,
                                                                                        progressColor: FlutterFlowTheme.of(context).primary,
                                                                                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                        center: Text(
                                                                                          valueOrDefault<String>(
                                                                                            'Fill Routine in ${valueOrDefault<String>(
                                                                                              functions.diffrenceDate(progressBarWaterRoutineRecord!.date!, getCurrentTimestamp).toString(),
                                                                                              '0',
                                                                                            )} Days +${progressBarWaterRoutineRecord?.score?.toString()}',
                                                                                            '0',
                                                                                          ),
                                                                                          textAlign: TextAlign.center,
                                                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                fontSize: 10,
                                                                                                letterSpacing: 0,
                                                                                              ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            containerPlantsRecord.name,
                                                                                            'None',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                fontSize: 20,
                                                                                                letterSpacing: 0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    StreamBuilder<List<DataSensorsRecord>>(
                                                                                      stream: queryDataSensorsRecord(
                                                                                        parent: containerPlantsRecord.espRef,
                                                                                        queryBuilder: (dataSensorsRecord) => dataSensorsRecord.orderBy('time', descending: true),
                                                                                        singleRecord: true,
                                                                                      ),
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
                                                                                        List<DataSensorsRecord> rowDataSensorsRecordList = snapshot.data!;
                                                                                        // Return an empty Container when the item does not exist.
                                                                                        if (snapshot.data!.isEmpty) {
                                                                                          return Container();
                                                                                        }
                                                                                        final rowDataSensorsRecord = rowDataSensorsRecordList.isNotEmpty ? rowDataSensorsRecordList.first : null;
                                                                                        return Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  FFIcons.kthermometer,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 17,
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      '${rowDataSensorsRecord?.temperature?.toString()}°C',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Montserrat',
                                                                                                            color: ((rowDataSensorsRecord!.temperature > (containerPlantsRecord.temperature + 20)) || (rowDataSensorsRecord!.temperature < (containerPlantsRecord.temperature - 20))) && (rowDataSensorsRecord?.temperature != 0) ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).primaryText,
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
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  FFIcons.ktest,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 17,
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      '${rowDataSensorsRecord?.humidity?.toString()}%',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Montserrat',
                                                                                                            color: ((rowDataSensorsRecord!.humidity > (containerPlantsRecord.humidity + 30)) || (rowDataSensorsRecord!.humidity < (containerPlantsRecord.humidity - 30))) && (rowDataSensorsRecord?.humidity != 0) ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).primaryText,
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
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  FFIcons.kbrightness,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 17,
                                                                                                ),
                                                                                                Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    RichText(
                                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                                      text: TextSpan(
                                                                                                        children: [
                                                                                                          TextSpan(
                                                                                                            text: '${rowDataSensorsRecord?.light?.toString()}',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                  fontSize: 15,
                                                                                                                  letterSpacing: 0,
                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                  color: ((rowDataSensorsRecord!.light > (containerPlantsRecord.light + 300)) || (rowDataSensorsRecord!.light < (containerPlantsRecord.light - 300))) && (rowDataSensorsRecord?.light != 0) ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).primaryText,
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
                                                                                                              color: ((rowDataSensorsRecord!.light > (containerPlantsRecord.light + 300)) || (rowDataSensorsRecord!.light < (containerPlantsRecord.light - 300))) && (rowDataSensorsRecord?.light != 0) ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).primaryText,
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
                                                                                              ].divide(SizedBox(height: 4)),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 10)),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ].divide(SizedBox(width: 10)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  18),
                                                          child: StreamBuilder<
                                                              List<
                                                                  DataSensorsRecord>>(
                                                            stream:
                                                                queryDataSensorsRecord(
                                                              parent:
                                                                  containerPlantsRecord
                                                                      .espRef,
                                                              queryBuilder: (dataSensorsRecord) =>
                                                                  dataSensorsRecord
                                                                      .orderBy(
                                                                          'time'),
                                                              limit: 7,
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
                                                                    height: 50,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
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
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: List.generate(
                                                                    rowDataSensorsRecordList
                                                                        .length,
                                                                    (rowIndex) {
                                                                  final rowDataSensorsRecord =
                                                                      rowDataSensorsRecordList[
                                                                          rowIndex];
                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Stack(
                                                                        alignment: AlignmentDirectional(
                                                                            0,
                                                                            1),
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                10,
                                                                            height:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0x42CEB8B8),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                          ),
                                                                          AnimatedContainer(
                                                                            duration:
                                                                                Duration(milliseconds: 750),
                                                                            curve:
                                                                                Curves.easeIn,
                                                                            width:
                                                                                10,
                                                                            height:
                                                                                () {
                                                                              if (_model.choiceChipsValue == 'Temp') {
                                                                                return rowDataSensorsRecord.temperature.toDouble();
                                                                              } else if (_model.choiceChipsValue == 'Hum') {
                                                                                return rowDataSensorsRecord.humidity.toDouble();
                                                                              } else if (_model.choiceChipsValue == 'Ligh') {
                                                                                return ((rowDataSensorsRecord.light * 100) / 1030);
                                                                              } else {
                                                                                return 0.0;
                                                                              }
                                                                            }(),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              gradient: LinearGradient(
                                                                                colors: [
                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                  FlutterFlowTheme.of(context).error
                                                                                ],
                                                                                stops: [
                                                                                  0,
                                                                                  1
                                                                                ],
                                                                                begin: AlignmentDirectional(0, 1),
                                                                                end: AlignmentDirectional(0, -1),
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          dateTimeFormat(
                                                                              'E',
                                                                              rowDataSensorsRecord.time),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Roboto',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            5)),
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              height: 27,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                child: Text(
                                                                  () {
                                                                    if (_model
                                                                            .choiceChipsValue ==
                                                                        'Temp') {
                                                                      return '0-100 (°C)';
                                                                    } else if (_model
                                                                            .choiceChipsValue ==
                                                                        'Hum') {
                                                                      return '0-100 (%)';
                                                                    } else if (_model
                                                                            .choiceChipsValue ==
                                                                        'Ligh') {
                                                                      return '0-1030 (LFD)';
                                                                    } else {
                                                                      return '0';
                                                                    }
                                                                  }(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            12,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0x22000000),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4),
                                                                child:
                                                                    FlutterFlowChoiceChips(
                                                                  options: [
                                                                    ChipData(
                                                                        'Temp'),
                                                                    ChipData(
                                                                        'Hum'),
                                                                    ChipData(
                                                                        'Ligh')
                                                                  ],
                                                                  onChanged: (val) =>
                                                                      setState(() =>
                                                                          _model.choiceChipsValue =
                                                                              val?.firstOrNull),
                                                                  selectedChipStyle:
                                                                      ChipStyle(
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          fontSize:
                                                                              10,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                    iconColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    iconSize:
                                                                        18,
                                                                    elevation:
                                                                        1,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  unselectedChipStyle:
                                                                      ChipStyle(
                                                                    backgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              10,
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                    iconColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    iconSize:
                                                                        18,
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  chipSpacing:
                                                                      5,
                                                                  rowSpacing:
                                                                      12,
                                                                  multiselect:
                                                                      false,
                                                                  initialized:
                                                                      _model.choiceChipsValue !=
                                                                          null,
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .start,
                                                                  controller: _model
                                                                          .choiceChipsValueController ??=
                                                                      FormFieldController<
                                                                          List<
                                                                              String>>(
                                                                    ['Temp'],
                                                                  ),
                                                                  wrapped:
                                                                      false,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 10)),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 15)),
                                )
                          ].divide(SizedBox(height: 15)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
