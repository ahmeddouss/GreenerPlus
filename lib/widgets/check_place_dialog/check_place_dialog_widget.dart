import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/gemini/gemini.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'check_place_dialog_model.dart';
export 'check_place_dialog_model.dart';

class CheckPlaceDialogWidget extends StatefulWidget {
  const CheckPlaceDialogWidget({super.key});

  @override
  State<CheckPlaceDialogWidget> createState() => _CheckPlaceDialogWidgetState();
}

class _CheckPlaceDialogWidgetState extends State<CheckPlaceDialogWidget>
    with TickerProviderStateMixin {
  late CheckPlaceDialogModel _model;

  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  void disconnectFromDevice() async {
    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    for (BluetoothDevice device in connectedDevices) {
      device.disconnect();
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        connectedDevice = device;
      });

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid.toString() == "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
          for (BluetoothCharacteristic c in service.characteristics) {
            if (c.uuid.toString() == "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
              characteristic = c;
              setState(() {
                connectedDevice = device;
              });
              print("Connected to characteristic");
              break;
            }
          }
        }
      }
    } catch (e) {
      print("Error connecting to device: $e");
      setState(() {
        connectedDevice = null;
      });
    }
  }

  Future<void> sendData(String ssid, String password, String uid, String plant,
      String esp) async {
    if (characteristic != null) {
      Map<String, String> wifiCredentials = {
        'ssid': ssid,
        'password': password,
        'plant_path': plant,
        'esp_path': esp,
        'user_path': uid
      };
      String json = jsonEncode(wifiCredentials);
      await characteristic!.write(utf8.encode(json));
      print("Data sent: $json");
    } else {
      print("Characteristic is null");
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan(timeout: Duration(seconds: 50));

    _model = createModel(context, () => CheckPlaceDialogModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 600.0.ms,
            duration: 1040.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 140.0.ms,
            duration: 1410.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 310.0.ms,
            duration: 1670.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 600.0.ms,
            duration: 1040.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 140.0.ms,
            duration: 1410.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation6': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 310.0.ms,
            duration: 1670.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    _model.textController1.text = "Noooooo";
    _model.textController2.text = "TOPNET_0660";
    _model.textController3.text = "w6i2b7m43z";

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
        padding: EdgeInsets.all(16),
        child: Container(
          height: 580,
          child: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
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
                                    'Check Place',
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
                                        fillColor: FlutterFlowTheme.of(context)
                                            .alternate,
                                        icon: Icon(
                                          FFIcons.kdelete,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 12,
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          disconnectFromDevice();
                                          await _model.esCardCreated!.reference
                                              .delete();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        PageView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: _model
                                                  .pageViewController ??=
                                              PageController(initialPage: 0),
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            StreamBuilder<List<ScanResult>>(
                                                stream: flutterBlue.scanResults,
                                                builder: (context, snapshot) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 25, 0, 0),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              children: [
                                                                Icon(
                                                                  FFIcons
                                                                      .kbrowser,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 25,
                                                                ),
                                                                Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x33FFFFFF),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'containerOnPageLoadAnimation1']!),
                                                                Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x33FFFFFF),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'containerOnPageLoadAnimation2']!),
                                                                AnimatedContainer(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          730),
                                                                  curve: Curves
                                                                      .elasticOut,
                                                                  width: 120,
                                                                  height: 120,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x33FFFFFF),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'containerOnPageLoadAnimation3']!),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            'Scanning Esp32 Sensors',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize: 17,
                                                                  letterSpacing:
                                                                      0,
                                                                ),
                                                          ),
                                                          Opacity(
                                                            opacity: 0.3,
                                                            child: Container(
                                                              width: 220,
                                                              height: 1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                          ),
                                                          if (snapshot.hasData)
                                                            ListView.builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  snapshot.data!
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  if (snapshot
                                                                          .data![
                                                                              index]
                                                                          .device
                                                                          .name ==
                                                                      "ESP32_Test")
                                                                    return InkWell(
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
                                                                        connectToDevice(snapshot
                                                                            .data![index]
                                                                            .device);

                                                                        await _model
                                                                            .pageViewController
                                                                            ?.nextPage(
                                                                          duration:
                                                                              Duration(milliseconds: 300),
                                                                          curve:
                                                                              Curves.ease,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        clipBehavior:
                                                                            Clip.antiAliasWithSaveLayer,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        elevation:
                                                                            4,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(12),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                FFIcons.kbrowser,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                size: 24,
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Esp32 Card Detected!',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          letterSpacing: 0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                  ),
                                                                                  Text(
                                                                                    'Press To Connect via Bluetooth',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: 12,
                                                                                          letterSpacing: 0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ].divide(SizedBox(width: 15)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                }
                                                              },
                                                            ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 91,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  'If you don\'t have any ESP devices, you can use the Weather API to maintain your plant\'s health.\n',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.showDetection =
                                                                        true;
                                                                    _model.espTrue =
                                                                        true;
                                                                    setState(
                                                                        () {});
                                                                    await _model
                                                                        .pageViewController
                                                                        ?.animateToPage(
                                                                      2,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  },
                                                                  text: 'Skip',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 37,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24,
                                                                            0,
                                                                            24,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15,
                                                                          letterSpacing:
                                                                              0,
                                                                        ),
                                                                    elevation:
                                                                        3,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 15)),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 50, 0, 0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController1,
                                                            focusNode: _model
                                                                .textFieldFocusNode1,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Sensor Name',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintText:
                                                                  'Sensor Name',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                              errorStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
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
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .sensors_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 17,
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            validator: _model
                                                                .textController1Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController2,
                                                            focusNode: _model
                                                                .textFieldFocusNode2,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Wifi Name',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintText:
                                                                  'Wifi Name',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                              errorStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
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
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              prefixIcon: Icon(
                                                                Icons.wifi,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 17,
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            validator: _model
                                                                .textController2Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController3,
                                                            focusNode: _model
                                                                .textFieldFocusNode3,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Wifi Password',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                              alignLabelWithHint:
                                                                  true,
                                                              hintText:
                                                                  'Wifi Password',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                              errorStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
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
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .wifi_password,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                size: 17,
                                                              ),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                            validator: _model
                                                                .textController3Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 80, 0, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          var espCardRecordReference =
                                                              EspCardRecord
                                                                  .collection
                                                                  .doc();
                                                          await espCardRecordReference
                                                              .set(
                                                                  createEspCardRecordData(
                                                            name: _model
                                                                .textController1
                                                                .text,
                                                            wifi: _model
                                                                .textController2
                                                                .text,
                                                            password: _model
                                                                .textController3
                                                                .text,
                                                          ));
                                                          _model.esCardCreated =
                                                              EspCardRecord
                                                                  .getDocumentFromData(
                                                                      createEspCardRecordData(
                                                                        name: _model
                                                                            .textController1
                                                                            .text,
                                                                        wifi: _model
                                                                            .textController2
                                                                            .text,
                                                                        password: _model
                                                                            .textController3
                                                                            .text,
                                                                      ),
                                                                      espCardRecordReference);
                                                          if (_model
                                                                  .esCardCreated
                                                                  ?.reference !=
                                                              null) {
                                                            _model.dataSensors =
                                                                await queryDataSensorsRecordOnce(
                                                              parent: _model
                                                                  .esCardCreated
                                                                  ?.reference,
                                                              queryBuilder: (dataSensorsRecord) =>
                                                                  dataSensorsRecord.orderBy(
                                                                      'time',
                                                                      descending:
                                                                          true),
                                                              singleRecord:
                                                                  true,
                                                            ).then((s) => s
                                                                    .firstOrNull);
                                                          }
                                                          await _model
                                                              .pageViewController
                                                              ?.nextPage(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            curve: Curves.ease,
                                                          );
                                                          await sendData(
                                                              _model
                                                                  .textController2
                                                                  .text,
                                                              _model
                                                                  .textController3
                                                                  .text,
                                                              "null",
                                                              "null",
                                                              _model
                                                                  .esCardCreated!
                                                                  .reference
                                                                  .toString());
                                                          //disconnectFromDevice();
                                                          setState(() {});
                                                        },
                                                        text: 'Send',
                                                        options:
                                                            FFButtonOptions(
                                                          height: 35,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(24,
                                                                      0, 24, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          elevation: 3,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 15)),
                                                ),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (_model.espTrue)
                                                    FutureBuilder<
                                                        ApiCallResponse>(
                                                      future: WeatherCall.call(
                                                        lat: functions.getLat(
                                                            currentUserLocationValue),
                                                        lon: functions.getLong(
                                                            currentUserLocationValue),
                                                      ),
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
                                                        final columnWeatherResponse =
                                                            snapshot.data!;

                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Opacity(
                                                                opacity: 0.6,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      FFIcons
                                                                          .kbrowser,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size: 27,
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Sensor Name Selected: ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'No Esp (Using Weather API)',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              20)),
                                                                ),
                                                              ),
                                                              Opacity(
                                                                opacity: 0.3,
                                                                child:
                                                                    Container(
                                                                  width: 220,
                                                                  height: 1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          'Depending on Weather Values',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 14,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children:
                                                                              [
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
                                                                                                              columnWeatherResponse.jsonBody,
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
                                                                                            fontSize: 18,
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
                                                                                        columnWeatherResponse.jsonBody,
                                                                                      )?.toString()}%',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Montserrat',
                                                                                            fontSize: 18,
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
                                                                                            text: valueOrDefault<String>(
                                                                                              '${WeatherCall.cloud(
                                                                                                columnWeatherResponse.jsonBody,
                                                                                              )?.toString()}%',
                                                                                              '0',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Montserrat',
                                                                                                  fontSize: 18,
                                                                                                  letterSpacing: 0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                ),
                                                                                          ),
                                                                                          TextSpan(
                                                                                            text: '',
                                                                                            style: TextStyle(
                                                                                              fontSize: 7,
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
                                                                          ].divide(SizedBox(width: 10)),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                child: Text(
                                                                  'Please , Chose the plant that you want to check area availability :',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    child: Form(
                                                                      key: _model
                                                                          .formKey1,
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .disabled,
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            8,
                                                                            0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _model.textController4,
                                                                          focusNode:
                                                                              _model.textFieldFocusNode4,
                                                                          autofocus:
                                                                              false,
                                                                          obscureText:
                                                                              false,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            isDense:
                                                                                true,
                                                                            labelText:
                                                                                'Plant Name',
                                                                            labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                            alignLabelWithHint:
                                                                                true,
                                                                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  letterSpacing: 0,
                                                                                ),
                                                                            errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  fontSize: 10,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Color(0x00000000),
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                            focusedErrorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                            prefixIcon:
                                                                                Icon(
                                                                              FFIcons.kaisearch,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 17,
                                                                            ),
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                          validator: _model
                                                                              .textController4Validator
                                                                              .asValidator(context),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color(0xFF5A956E),
                                                                            Color(0xFF6A8AFE)
                                                                          ],
                                                                          stops: [
                                                                            0,
                                                                            1
                                                                          ],
                                                                          begin: AlignmentDirectional(
                                                                              -1,
                                                                              0),
                                                                          end: AlignmentDirectional(
                                                                              1,
                                                                              0),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(24),
                                                                      ),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          if (_model.formKey1.currentState == null ||
                                                                              !_model.formKey1.currentState!.validate()) {
                                                                            return;
                                                                          }
                                                                          await geminiGenerateText(
                                                                            context,
                                                                            valueOrDefault<String>(
                                                                              'For${valueOrDefault<String>(
                                                                                _model.textController4.text,
                                                                                '0',
                                                                              )}plant does this values present a good envirement to live (temperature(°C):${valueOrDefault<String>(
                                                                                ((((WeatherCall.temp(
                                                                                                      columnWeatherResponse.jsonBody,
                                                                                                    )!) -
                                                                                                    273.15) *
                                                                                                100)
                                                                                            .round() /
                                                                                        100)
                                                                                    .toString(),
                                                                                '0',
                                                                              )},humidity(%):${WeatherCall.humidity(
                                                                                columnWeatherResponse.jsonBody,
                                                                              )?.toString()}clouds(%):${WeatherCall.cloud(
                                                                                columnWeatherResponse.jsonBody,
                                                                              )?.toString()}) return JSON format({\"answer\":\"true or false (bolean)\",\"description\":\"response answer text and raison (max 2 line)\"})',
                                                                              'None',
                                                                            ),
                                                                          ).then(
                                                                              (generatedText) {
                                                                            safeSetState(() =>
                                                                                _model.geminiAnswerNoEsp = generatedText);
                                                                          });

                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        text:
                                                                            'Check',
                                                                        icon:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kgemini,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).info,
                                                                          size:
                                                                              13,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          height:
                                                                              40,
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              15,
                                                                              0,
                                                                              15,
                                                                              0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          color:
                                                                              Color(0x00C96666),
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                fontFamily: 'Montserrat',
                                                                                color: Colors.white,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(24),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              if (_model.geminiAnswerNoEsp !=
                                                                      null &&
                                                                  _model.geminiAnswerNoEsp !=
                                                                      '')
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child: Stack(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1,
                                                                            1),
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                              valueOrDefault<Color>(
                                                                                (String var1) {
                                                                                  return (var1 == "true") ? Color(0xFF249689) : Color(0xFFFF5963);
                                                                                }(getJsonField(
                                                                                  functions.jsonConvert(_model.geminiAnswerNoEsp),
                                                                                  r'''$.answer''',
                                                                                ).toString()),
                                                                                FlutterFlowTheme.of(context).error,
                                                                              )
                                                                            ],
                                                                            stops: [
                                                                              0,
                                                                              1
                                                                            ],
                                                                            begin:
                                                                                AlignmentDirectional(0.87, -1),
                                                                            end:
                                                                                AlignmentDirectional(-0.87, 1),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(25),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(16),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Text(
                                                                                'Answer',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  getJsonField(
                                                                                    functions.jsonConvert(_model.geminiAnswerNoEsp),
                                                                                    r'''$.description''',
                                                                                  )?.toString(),
                                                                                  'none',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Roboto',
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 7)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1,
                                                                            1),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(0),
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/Vector_44.png',
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            alignment:
                                                                                Alignment(0, 0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                            ].divide(SizedBox(
                                                                height: 15)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  if (_model.esCardCreated
                                                          ?.reference !=
                                                      null)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 25, 0, 0),
                                                      child: StreamBuilder<
                                                          List<
                                                              DataSensorsRecord>>(
                                                        stream:
                                                            queryDataSensorsRecord(
                                                          parent: _model
                                                              .esCardCreated
                                                              ?.reference,
                                                          queryBuilder: (dataSensorsRecord) =>
                                                              dataSensorsRecord
                                                                  .orderBy(
                                                                      'time',
                                                                      descending:
                                                                          true),
                                                          singleRecord: true,
                                                        )..listen((snapshot) {
                                                                List<DataSensorsRecord>
                                                                    columnDataSensorsRecordList =
                                                                    snapshot;
                                                                final columnDataSensorsRecord =
                                                                    columnDataSensorsRecordList
                                                                            .isNotEmpty
                                                                        ? columnDataSensorsRecordList
                                                                            .first
                                                                        : null;
                                                                if (_model.columnPreviousSnapshot !=
                                                                        null &&
                                                                    !const ListEquality(
                                                                            DataSensorsRecordDocumentEquality())
                                                                        .equals(
                                                                            columnDataSensorsRecordList,
                                                                            _model.columnPreviousSnapshot)) {
                                                                  () async {
                                                                    _model.showDetection =
                                                                        false;
                                                                    setState(
                                                                        () {});

                                                                    setState(
                                                                        () {});
                                                                  }();
                                                                }
                                                                _model.columnPreviousSnapshot =
                                                                    snapshot;
                                                              }),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
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
                                                          List<DataSensorsRecord>
                                                              columnDataSensorsRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final columnDataSensorsRecord =
                                                              columnDataSensorsRecordList
                                                                      .isNotEmpty
                                                                  ? columnDataSensorsRecordList
                                                                      .first
                                                                  : null;

                                                          return SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                if (_model
                                                                        .esCardCreated
                                                                        ?.reference !=
                                                                    null)
                                                                  Opacity(
                                                                    opacity:
                                                                        0.6,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Icon(
                                                                          FFIcons
                                                                              .kbrowser,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          size:
                                                                              27,
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Sensor Name Selected: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                _model.esCardCreated?.name,
                                                                                'none',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 20)),
                                                                    ),
                                                                  ),
                                                                Opacity(
                                                                  opacity: 0.3,
                                                                  child:
                                                                      Container(
                                                                    width: 220,
                                                                    height: 1,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (!_model
                                                                    .showDetection)
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Text(
                                                                              'Depending on Detected Values',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                                                            columnDataSensorsRecord?.temperature?.toString(),
                                                                                            '0',
                                                                                          )}°C',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                fontSize: 18,
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
                                                                                          '${valueOrDefault<String>(
                                                                                            columnDataSensorsRecord?.humidity?.toString(),
                                                                                            '0',
                                                                                          )}%',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                fontSize: 18,
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
                                                                                                text: valueOrDefault<String>(
                                                                                                  '${columnDataSensorsRecord?.light?.toString()}',
                                                                                                  '0',
                                                                                                ),
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
                                                                                                  fontSize: 18,
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
                                                                            ),
                                                                          ].divide(SizedBox(height: 10)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Text(
                                                                    'Please , Chose the plant that you want to check area availability :',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          letterSpacing:
                                                                              0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Form(
                                                                        key: _model
                                                                            .formKey2,
                                                                        autovalidateMode:
                                                                            AutovalidateMode.disabled,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                _model.textController5,
                                                                            focusNode:
                                                                                _model.textFieldFocusNode5,
                                                                            autofocus:
                                                                                false,
                                                                            obscureText:
                                                                                false,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              isDense: true,
                                                                              labelText: 'Plant Name',
                                                                              labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                              alignLabelWithHint: true,
                                                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                              errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    fontSize: 10,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Color(0x00000000),
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(24),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(24),
                                                                              ),
                                                                              errorBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(24),
                                                                              ),
                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  width: 2,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(24),
                                                                              ),
                                                                              filled: true,
                                                                              fillColor: FlutterFlowTheme.of(context).alternate,
                                                                              prefixIcon: Icon(
                                                                                FFIcons.kaisearch,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                size: 17,
                                                                              ),
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                            validator:
                                                                                _model.textController5Validator.asValidator(context),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              Color(0xFF5A956E),
                                                                              Color(0xFF6A8AFE)
                                                                            ],
                                                                            stops: [
                                                                              0,
                                                                              1
                                                                            ],
                                                                            begin:
                                                                                AlignmentDirectional(-1, 0),
                                                                            end:
                                                                                AlignmentDirectional(1, 0),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(24),
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed: !(columnDataSensorsRecord != null)
                                                                              ? null
                                                                              : () async {
                                                                                  if (_model.formKey2.currentState == null || !_model.formKey2.currentState!.validate()) {
                                                                                    return;
                                                                                  }
                                                                                  if (_model.esCardCreated?.reference != null) {
                                                                                    _model.showDetection = false;
                                                                                    setState(() {});
                                                                                    await geminiGenerateText(
                                                                                      context,
                                                                                      valueOrDefault<String>(
                                                                                        'For${valueOrDefault<String>(
                                                                                          _model.textController5.text,
                                                                                          '0',
                                                                                        )}plant does this values present a good envirement to live (temperature(°C):${valueOrDefault<String>(
                                                                                          _model.dataSensors?.temperature?.toString(),
                                                                                          '0',
                                                                                        )},humidity(%):${valueOrDefault<String>(
                                                                                          _model.dataSensors?.humidity?.toString(),
                                                                                          '0',
                                                                                        )}light(LFD):${valueOrDefault<String>(
                                                                                          _model.dataSensors?.light?.toString(),
                                                                                          '0',
                                                                                        )}) return JSON format({\"answer\":\"true or false (bolean)\",\"description\":\"response answer text and raison (max 2 line)\"})',
                                                                                        'None',
                                                                                      ),
                                                                                    ).then((generatedText) {
                                                                                      safeSetState(() => _model.geminiAnswer = generatedText);
                                                                                    });
                                                                                  }

                                                                                  setState(() {});
                                                                                },
                                                                          text:
                                                                              'Check',
                                                                          icon:
                                                                              Icon(
                                                                            FFIcons.kgemini,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            size:
                                                                                13,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                15,
                                                                                0,
                                                                                15,
                                                                                0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            color:
                                                                                Color(0x00C96666),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  color: Colors.white,
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.transparent,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(24),
                                                                            disabledColor:
                                                                                Color(0x7A636262),
                                                                            disabledTextColor:
                                                                                Color(0x9CE3D8D8),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (_model.geminiAnswer !=
                                                                        null &&
                                                                    _model.geminiAnswer !=
                                                                        '')
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1,
                                                                              1),
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(
                                                                              colors: [
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                                valueOrDefault<Color>(
                                                                                  (String var1) {
                                                                                    return (var1 == "true") ? Color(0xFF249689) : Color(0xFFFF5963);
                                                                                  }(getJsonField(
                                                                                    functions.jsonConvert(_model.geminiAnswer),
                                                                                    r'''$.answer''',
                                                                                  ).toString()),
                                                                                  FlutterFlowTheme.of(context).error,
                                                                                )
                                                                              ],
                                                                              stops: [
                                                                                0,
                                                                                1
                                                                              ],
                                                                              begin: AlignmentDirectional(0.87, -1),
                                                                              end: AlignmentDirectional(-0.87, 1),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(16),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  'Answer',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        letterSpacing: 0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      functions.jsonConvert(_model.geminiAnswer),
                                                                                      r'''$.description''',
                                                                                    )?.toString(),
                                                                                    'none',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Roboto',
                                                                                        letterSpacing: 0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 7)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1,
                                                                              1),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/Vector_44.png',
                                                                              width: 15,
                                                                              height: 15,
                                                                              fit: BoxFit.fill,
                                                                              alignment: Alignment(0, 0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                              ].divide(SizedBox(
                                                                  height: 15)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.showDetection &&
                                                      !_model.espTrue)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 25, 0, 0),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                children: [
                                                                  Icon(
                                                                    FFIcons
                                                                        .kbrowser,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 25,
                                                                  ),
                                                                  Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x33FFFFFF),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'containerOnPageLoadAnimation4']!),
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x33FFFFFF),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'containerOnPageLoadAnimation5']!),
                                                                  AnimatedContainer(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            730),
                                                                    curve: Curves
                                                                        .elasticOut,
                                                                    width: 120,
                                                                    height: 120,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x33FFFFFF),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'containerOnPageLoadAnimation6']!),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                              'Waiting Sensors response',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        17,
                                                                    letterSpacing:
                                                                        0,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                              child: Text(
                                                                'This wil take few seconds to connect to the card and recieve sensors Data',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 25)),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 5),
                                            child: smooth_page_indicator
                                                .SmoothPageIndicator(
                                              controller:
                                                  _model.pageViewController ??=
                                                      PageController(
                                                          initialPage: 0),
                                              count: 3,
                                              axisDirection: Axis.horizontal,
                                              onDotClicked: (i) async {
                                                await _model.pageViewController!
                                                    .animateToPage(
                                                  i,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                                setState(() {});
                                              },
                                              effect: smooth_page_indicator
                                                  .ExpandingDotsEffect(
                                                expansionFactor: 3,
                                                spacing: 8,
                                                radius: 16,
                                                dotWidth: 10,
                                                dotHeight: 8,
                                                dotColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                activeDotColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                paintStyle: PaintingStyle.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 20)),
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
  }
}
