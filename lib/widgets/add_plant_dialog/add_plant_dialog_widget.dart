import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/gemini/gemini.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
//import 'package:get/get.dart';

import 'add_plant_dialog_model.dart';
export 'add_plant_dialog_model.dart';

class AddPlantDialogWidget extends StatefulWidget {
  const AddPlantDialogWidget({super.key});

  @override
  State<AddPlantDialogWidget> createState() => _AddPlantDialogWidgetState();
}

class _AddPlantDialogWidgetState extends State<AddPlantDialogWidget>
    with TickerProviderStateMixin {
  late AddPlantDialogModel _model;

  final animationsMap = <String, AnimationInfo>{};
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  void disconnectFromDevice() async {
    try {
      if (connectedDevice != null) {
        await connectedDevice!.disconnect();
        setState(() {
          connectedDevice = null;
          characteristic = null;
        });
        print("Disconnected from device");
      } else {
        print("No device is currently connected");
      }
    } catch (e) {
      print("Error disconnecting from device: $e");
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

  String extractPathFromReference(String reference) {
    final RegExp regExp = RegExp(r'\(([^)]+)\)');
    final match = regExp.firstMatch(reference);
    return match?.group(1) ?? '';
  }

  Future<void> sendData(String ssid, String password, String uid, String plant,
      String esp) async {
    if (characteristic != null) {
      Map<String, String> wifiCredentials = {
        'ssid': ssid,
        'password': password,
        'plant_path': extractPathFromReference(plant),
        'esp_path': extractPathFromReference(esp),
        'user_path': extractPathFromReference(uid)
      };
      String json = jsonEncode(wifiCredentials);
      print("Data sent: $json");
      await characteristic!.write(utf8.encode(json));
      print("Data sent: $json");
    } else {
      print("Characteristic is null");
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddPlantDialogModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
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
            delay: 280.0.ms,
            duration: 1670.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    flutterBlue.startScan(timeout: Duration(seconds: 50));
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
            padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 50),
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add New Plant',
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
                                        FlutterFlowTheme.of(context).alternate,
                                    icon: Icon(
                                      FFIcons.kdelete,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 12,
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _model.espCardCreated!.reference
                                          .delete();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Stack(
                                children: [
                                  PageView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    controller: _model.pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      StreamBuilder<List<ScanResult>>(
                                          stream: flutterBlue.scanResults,
                                          builder: (context, snapshot) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 25, 0, 0),
                                              child: SingleChildScrollView(
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
                                                            FFIcons.kbrowser,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                                  Border.all(
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
                                                                  Border.all(
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
                                                                  Border.all(
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
                                                            letterSpacing: 0,
                                                          ),
                                                    ),
                                                    Opacity(
                                                      opacity: 0.3,
                                                      child: Container(
                                                        width: 220,
                                                        height: 1,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                    ),
                                                    // if (snapshot.hasData)
                                                    ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          snapshot.data!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot
                                                                  .data![index]
                                                                  .device
                                                                  .name ==
                                                              "ESP32_Test")
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                connectToDevice(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .device);

                                                                await _model
                                                                    .pageViewController
                                                                    ?.nextPage(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              },
                                                              child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                elevation: 4,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        FFIcons
                                                                            .kbrowser,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
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
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            15)),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                        }
                                                      },
                                                    ),
                                                    // Generated code for this Column Widget...
                                                    Container(
                                                      height: 220,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            'If you don\'t have any ESP devices, you can use the Weather API to maintain your plant\'s health.\n\nNote: Adding an ESP device helps you track real-time environmental data and automatically manage your watering routine, which improves your score limitlessly.\nWithout this feature, you can\'t ensure that the plant is being watered correctly.',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0,
                                                                ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.espTrue =
                                                                  true;
                                                              setState(() {});
                                                              await _model
                                                                  .pageViewController
                                                                  ?.animateToPage(
                                                                2,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        500),
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                            },
                                                            text: 'Skip',
                                                            options:
                                                                FFButtonOptions(
                                                              height: 37,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24,
                                                                          0,
                                                                          24,
                                                                          0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0,
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
                                                                      .circular(
                                                                          24),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ].divide(
                                                      SizedBox(height: 15)),
                                                ),
                                              ),
                                            );
                                          }),
                                      Form(
                                        key: _model.formKey2,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 50, 0, 0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                            Icons.sensors_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 17,
                                                          ),
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                          alignLabelWithHint:
                                                              true,
                                                          hintText: 'Wifi Name',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 17,
                                                          ),
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    fontSize:
                                                                        10,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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
                                                            Icons.wifi_password,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 17,
                                                          ),
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 80, 0, 0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      if (_model.formKey2
                                                                  .currentState ==
                                                              null ||
                                                          !_model.formKey2
                                                              .currentState!
                                                              .validate()) {
                                                        return;
                                                      }

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
                                                      _model.espCardCreated = EspCardRecord
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

                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'esp_cards':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              _model
                                                                  .espCardCreated
                                                                  ?.reference
                                                            ]),
                                                          },
                                                        ),
                                                      });
                                                      await _model
                                                          .pageViewController
                                                          ?.nextPage(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        curve: Curves.ease,
                                                      );

                                                      setState(() {});
                                                    },
                                                    text: 'Send',
                                                    options: FFButtonOptions(
                                                      height: 35,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24, 0, 24, 0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 15)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 24, 10, 0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Opacity(
                                                  opacity: 0.6,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FFIcons.kbrowser,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 27,
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Sensor Name Selected: ',
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
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              _model
                                                                  .textController1
                                                                  .text,
                                                              'No ESP (Using Weather Api)',
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
                                                          ),
                                                        ],
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 20)),
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.3,
                                                  child: Container(
                                                    width: 220,
                                                    height: 1,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 10, 0),
                                                  child: Text(
                                                    'Gemini can assist to help you find the correct info about your plant:',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Form(
                                                        key: _model.formKey1,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .disabled,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 8, 0),
                                                          child: TextFormField(
                                                            controller: _model
                                                                .textController4,
                                                            focusNode: _model
                                                                .textFieldFocusNode4,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Plant Name',
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
                                                                FFIcons
                                                                    .kaisearch,
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
                                                                .textController4Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFF5A956E),
                                                            Color(0xFF6A8AFE)
                                                          ],
                                                          stops: [0, 1],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  -1, 0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  1, 0),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24),
                                                      ),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          if (_model.formKey1
                                                                      .currentState ==
                                                                  null ||
                                                              !_model.formKey1
                                                                  .currentState!
                                                                  .validate()) {
                                                            return;
                                                          }
                                                          await geminiGenerateText(
                                                            context,
                                                            valueOrDefault<
                                                                String>(
                                                              'What are the maximum values that the plant${_model.textController4.text}can withstand without being in danger? Provide the response in JSON format:{ \"humidity\": \"valeur moyen%(intiger)\", \"temperature\": \"valeur moyen°C(intiger)\", \"light\": \"valeur moyen LDR (from 0 to 1023)(intiger)\", \"description\": \"short description about the plant (max 2 lines)\", \"interval\":\"number of days between each watering(integer)\", \"water\":\"water quantity(text(max 4 word))\", \"score\": \"integer (between 20-150, depending on the difficulty and rarity of the plant)\" }',
                                                              'None',
                                                            ),
                                                          ).then(
                                                              (generatedText) {
                                                            safeSetState(() =>
                                                                _model.geminiResponse =
                                                                    generatedText);
                                                          });
                                                          await Future.wait([
                                                            Future(() async {
                                                              setState(() {
                                                                _model.countControllerValue1 =
                                                                    getJsonField(
                                                                  functions
                                                                      .jsonConvert(
                                                                          _model
                                                                              .geminiResponse),
                                                                  r'''$.temperature''',
                                                                );
                                                              });
                                                            }),
                                                            Future(() async {
                                                              setState(() {
                                                                _model.countControllerValue2 =
                                                                    getJsonField(
                                                                  functions
                                                                      .jsonConvert(
                                                                          _model
                                                                              .geminiResponse),
                                                                  r'''$.humidity''',
                                                                );
                                                              });
                                                            }),
                                                            Future(() async {
                                                              setState(() {
                                                                _model.countControllerValue3 =
                                                                    getJsonField(
                                                                  functions
                                                                      .jsonConvert(
                                                                          _model
                                                                              .geminiResponse),
                                                                  r'''$.light''',
                                                                );
                                                              });
                                                            }),
                                                            Future(() async {
                                                              setState(() {
                                                                _model.textController5
                                                                        ?.text =
                                                                    getJsonField(
                                                                  functions
                                                                      .jsonConvert(
                                                                          _model
                                                                              .geminiResponse),
                                                                  r'''$.water''',
                                                                ).toString();
                                                                _model.textController5
                                                                        ?.selection =
                                                                    TextSelection.collapsed(
                                                                        offset: _model
                                                                            .textController5!
                                                                            .text
                                                                            .length);
                                                              });
                                                            }),
                                                            Future(() async {
                                                              setState(() {
                                                                _model.countControllerValue4 =
                                                                    getJsonField(
                                                                  functions
                                                                      .jsonConvert(
                                                                          _model
                                                                              .geminiResponse),
                                                                  r'''$.interval''',
                                                                );
                                                              });
                                                            }),
                                                          ]);
                                                          setState(() {});
                                                        },
                                                        text: 'Find',
                                                        icon: Icon(
                                                          FFIcons.kgemini,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .info,
                                                          size: 13,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(15,
                                                                      0, 15, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color:
                                                              Color(0x00C96666),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x83D4D1D0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Container(
                                                        width: double.infinity,
                                                        color:
                                                            Color(0x00000000),
                                                        child:
                                                            ExpandableNotifier(
                                                          controller: _model
                                                              .expandableExpandableController1,
                                                          child:
                                                              ExpandablePanel(
                                                            header: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'Select Photo',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            collapsed:
                                                                Container(
                                                              width: 0,
                                                              height: 0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            expanded: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (_model.uploadedFileUrl !=
                                                                              null &&
                                                                          _model.uploadedFileUrl !=
                                                                              '')
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 500),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 500),
                                                                            imageUrl:
                                                                                valueOrDefault<String>(
                                                                              _model.uploadedFileUrl != null && _model.uploadedFileUrl != '' ? _model.uploadedFileUrl : 'https://picsum.photos/seed/356/600',
                                                                              'https://picsum.photos/seed/356/600',
                                                                            ),
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorWidget: (context, error, stackTrace) =>
                                                                                Image.asset(
                                                                              'assets/images/error_image.png',
                                                                              width: 60,
                                                                              height: 60,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    borderRadius:
                                                                        10,
                                                                    borderWidth:
                                                                        1,
                                                                    buttonSize:
                                                                        60,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size: 24,
                                                                    ),
                                                                    showLoadingIndicator:
                                                                        true,
                                                                    onPressed:
                                                                        () async {
                                                                      final selectedMedia =
                                                                          await selectMediaWithSourceBottomSheet(
                                                                        context:
                                                                            context,
                                                                        allowPhoto:
                                                                            true,
                                                                      );
                                                                      if (selectedMedia !=
                                                                              null &&
                                                                          selectedMedia.every((m) => validateFileFormat(
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
                                                                          selectedUploadedFiles = selectedMedia
                                                                              .map((m) => FFUploadedFile(
                                                                                    name: m.storagePath.split('/').last,
                                                                                    bytes: m.bytes,
                                                                                    height: m.dimensions?.height,
                                                                                    width: m.dimensions?.width,
                                                                                    blurHash: m.blurHash,
                                                                                  ))
                                                                              .toList();
                                                                          downloadUrls = (await Future.wait(
                                                                            selectedMedia.map(
                                                                              (m) async => await uploadData(m.storagePath, m.bytes),
                                                                            ),
                                                                          ))
                                                                              .where((u) => u != null)
                                                                              .map((u) => u!)
                                                                              .toList();
                                                                        } finally {
                                                                          _model.isDataUploading =
                                                                              false;
                                                                        }
                                                                        if (selectedUploadedFiles.length == selectedMedia.length &&
                                                                            downloadUrls.length ==
                                                                                selectedMedia.length) {
                                                                          setState(
                                                                              () {
                                                                            _model.uploadedLocalFile =
                                                                                selectedUploadedFiles.first;
                                                                            _model.uploadedFileUrl =
                                                                                downloadUrls.first;
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {});
                                                                          return;
                                                                        }
                                                                      }
                                                                    },
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        width:
                                                                            10)),
                                                              ),
                                                            ),
                                                            theme:
                                                                ExpandableThemeData(
                                                              tapHeaderToExpand:
                                                                  true,
                                                              tapBodyToExpand:
                                                                  false,
                                                              tapBodyToCollapse:
                                                                  false,
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
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x83D4D1D0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 6, 0, 6),
                                                      child: Container(
                                                        width: double.infinity,
                                                        color:
                                                            Color(0x00000000),
                                                        child:
                                                            ExpandableNotifier(
                                                          controller: _model
                                                              .expandableExpandableController2,
                                                          child:
                                                              ExpandablePanel(
                                                            header: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'Select threshold',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            collapsed:
                                                                Container(
                                                              width: 0,
                                                              height: 0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
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
                                                                          children:
                                                                              [
                                                                            Container(
                                                                              width: 85,
                                                                              height: 37,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0x8BF9F0F0),
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: FlutterFlowCountController(
                                                                                decrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.minus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).secondaryText : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                incrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.plus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                countBuilder: (count) => Text(
                                                                                  count.toString(),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 18,
                                                                                        letterSpacing: 0,
                                                                                      ),
                                                                                ),
                                                                                count: _model.countControllerValue1 ??= 20,
                                                                                updateCount: (count) => setState(() => _model.countControllerValue1 = count),
                                                                                stepSize: 1,
                                                                                contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
                                                                          ].divide(SizedBox(height: 4)),
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
                                                                          children:
                                                                              [
                                                                            Container(
                                                                              width: 85,
                                                                              height: 37,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0x8BF9F0F0),
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: FlutterFlowCountController(
                                                                                decrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.minus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).secondaryText : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                incrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.plus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                countBuilder: (count) => Text(
                                                                                  count.toString(),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 18,
                                                                                        letterSpacing: 0,
                                                                                      ),
                                                                                ),
                                                                                count: _model.countControllerValue2 ??= 20,
                                                                                updateCount: (count) => setState(() => _model.countControllerValue2 = count),
                                                                                stepSize: 1,
                                                                                contentPadding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
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
                                                                          ].divide(SizedBox(height: 4)),
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
                                                                          children:
                                                                              [
                                                                            Container(
                                                                              width: 95,
                                                                              height: 37,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0x8BF9F0F0),
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: FlutterFlowCountController(
                                                                                decrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.minus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).secondaryText : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                incrementIconBuilder: (enabled) => FaIcon(
                                                                                  FontAwesomeIcons.plus,
                                                                                  color: enabled ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                  size: 10,
                                                                                ),
                                                                                countBuilder: (count) => Text(
                                                                                  count.toString(),
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        fontFamily: 'Montserrat',
                                                                                        fontSize: 18,
                                                                                        letterSpacing: 0,
                                                                                      ),
                                                                                ),
                                                                                count: _model.countControllerValue3 ??= 1000,
                                                                                updateCount: (count) => setState(() => _model.countControllerValue3 = count),
                                                                                stepSize: 1,
                                                                                contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
                                                                          ].divide(SizedBox(height: 4)),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 4)),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          width:
                                                                              4)),
                                                                ),
                                                              ),
                                                            ),
                                                            theme:
                                                                ExpandableThemeData(
                                                              tapHeaderToExpand:
                                                                  true,
                                                              tapBodyToExpand:
                                                                  false,
                                                              tapBodyToCollapse:
                                                                  false,
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
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x83D4D1D0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      child: Container(
                                                        width: double.infinity,
                                                        color:
                                                            Color(0x00000000),
                                                        child:
                                                            ExpandableNotifier(
                                                          controller: _model
                                                              .expandableExpandableController3,
                                                          child:
                                                              ExpandablePanel(
                                                            header: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'Select Watering Routine',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            collapsed:
                                                                Container(
                                                              width: 0,
                                                              height: 0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            expanded: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        'Days Interval: ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 15,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            37,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0x8BF9F0F0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                        ),
                                                                        child:
                                                                            FlutterFlowCountController(
                                                                          decrementIconBuilder: (enabled) =>
                                                                              FaIcon(
                                                                            FontAwesomeIcons.minus,
                                                                            color: enabled
                                                                                ? FlutterFlowTheme.of(context).secondaryText
                                                                                : FlutterFlowTheme.of(context).alternate,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                          incrementIconBuilder: (enabled) =>
                                                                              FaIcon(
                                                                            FontAwesomeIcons.plus,
                                                                            color: enabled
                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                : FlutterFlowTheme.of(context).alternate,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                          countBuilder: (count) =>
                                                                              Text(
                                                                            count.toString(),
                                                                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                  fontFamily: 'Montserrat',
                                                                                  fontSize: 18,
                                                                                  letterSpacing: 0,
                                                                                ),
                                                                          ),
                                                                          count: _model.countControllerValue4 ??=
                                                                              0,
                                                                          updateCount: (count) =>
                                                                              setState(() => _model.countControllerValue4 = count),
                                                                          stepSize:
                                                                              1,
                                                                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        'Watering quantity:',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              fontSize: 15,
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                      Expanded(
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
                                                                              labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                              alignLabelWithHint: true,
                                                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
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
                                                                              fillColor: Color(0x65F9F0F0),
                                                                              prefixIcon: Icon(
                                                                                FFIcons.kimageSaturation,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
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
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  ),
                                                                ].divide(
                                                                    SizedBox(
                                                                        height:
                                                                            5)),
                                                              ),
                                                            ),
                                                            theme:
                                                                ExpandableThemeData(
                                                              tapHeaderToExpand:
                                                                  true,
                                                              tapBodyToExpand:
                                                                  false,
                                                              tapBodyToCollapse:
                                                                  false,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                                  child: FFButtonWidget(
                                                    onPressed: !((_model.geminiResponse !=
                                                                    null &&
                                                                _model.geminiResponse !=
                                                                    '') &&
                                                            (_model.uploadedFileUrl !=
                                                                    null &&
                                                                _model.uploadedFileUrl !=
                                                                    ''))
                                                        ? null
                                                        : () async {
                                                            if (_model
                                                                .espTrue) {
                                                              var plantsRecordReference1 =
                                                                  PlantsRecord
                                                                      .collection
                                                                      .doc();
                                                              await plantsRecordReference1
                                                                  .set(
                                                                      createPlantsRecordData(
                                                                name: _model
                                                                    .textController4
                                                                    .text,
                                                                interval: _model
                                                                    .countControllerValue4,
                                                                water: _model
                                                                    .textController5
                                                                    .text,
                                                                light: _model
                                                                    .countControllerValue3,
                                                                humidity: _model
                                                                    .countControllerValue2,
                                                                temperature: _model
                                                                    .countControllerValue1,
                                                                image: _model
                                                                    .uploadedFileUrl,
                                                                creationDate:
                                                                    getCurrentTimestamp,
                                                                description:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  getJsonField(
                                                                    functions.jsonConvert(
                                                                        valueOrDefault<
                                                                            String>(
                                                                      _model
                                                                          .geminiResponse,
                                                                      '{\"score\":\"Add\"}',
                                                                    )),
                                                                    r'''$.description''',
                                                                  )?.toString(),
                                                                  'none',
                                                                ),
                                                                score:
                                                                    valueOrDefault<
                                                                        int>(
                                                                  int.parse(
                                                                      valueOrDefault<
                                                                          String>(
                                                                    getJsonField(
                                                                      functions.jsonConvert(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        _model
                                                                            .geminiResponse,
                                                                        '{\"score\":\"Add\"}',
                                                                      )),
                                                                      r'''$.score''',
                                                                    )?.toString(),
                                                                    'Add',
                                                                  )),
                                                                  0,
                                                                ),
                                                                code: random_data
                                                                    .randomString(
                                                                  11,
                                                                  12,
                                                                  true,
                                                                  true,
                                                                  true,
                                                                ),
                                                              ));
                                                              _model.newPlantNoEsp =
                                                                  PlantsRecord
                                                                      .getDocumentFromData(
                                                                          createPlantsRecordData(
                                                                            name:
                                                                                _model.textController4.text,
                                                                            interval:
                                                                                _model.countControllerValue4,
                                                                            water:
                                                                                _model.textController5.text,
                                                                            light:
                                                                                _model.countControllerValue3,
                                                                            humidity:
                                                                                _model.countControllerValue2,
                                                                            temperature:
                                                                                _model.countControllerValue1,
                                                                            image:
                                                                                _model.uploadedFileUrl,
                                                                            creationDate:
                                                                                getCurrentTimestamp,
                                                                            description:
                                                                                valueOrDefault<String>(
                                                                              getJsonField(
                                                                                functions.jsonConvert(valueOrDefault<String>(
                                                                                  _model.geminiResponse,
                                                                                  '{\"score\":\"Add\"}',
                                                                                )),
                                                                                r'''$.description''',
                                                                              )?.toString(),
                                                                              'none',
                                                                            ),
                                                                            score:
                                                                                valueOrDefault<int>(
                                                                              int.parse(valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  functions.jsonConvert(valueOrDefault<String>(
                                                                                    _model.geminiResponse,
                                                                                    '{\"score\":\"Add\"}',
                                                                                  )),
                                                                                  r'''$.score''',
                                                                                )?.toString(),
                                                                                'Add',
                                                                              )),
                                                                              0,
                                                                            ),
                                                                            code:
                                                                                random_data.randomString(
                                                                              11,
                                                                              12,
                                                                              true,
                                                                              true,
                                                                              true,
                                                                            ),
                                                                          ),
                                                                          plantsRecordReference1);
                                                              await currentUserReference!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'plants':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      _model
                                                                          .newPlantNoEsp
                                                                          ?.reference
                                                                    ]),
                                                                    'score': FieldValue.increment(_model
                                                                        .newPlantNoEsp!
                                                                        .score),
                                                                    'wallet': FieldValue.increment(_model
                                                                        .newPlantNoEsp!
                                                                        .score),
                                                                  },
                                                                ),
                                                              });
                                                              await WaterRoutineRecord
                                                                      .createDoc(_model
                                                                          .newPlantNoEsp!
                                                                          .reference)
                                                                  .set(
                                                                      createWaterRoutineRecordData(
                                                                date: functions.nextDayAdd(
                                                                    _model
                                                                        .newPlantNoEsp!
                                                                        .interval,
                                                                    getCurrentTimestamp),
                                                                status: false,
                                                                score: 25.0,
                                                              ));
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _model.isDataUploading =
                                                                    false;
                                                                _model.uploadedLocalFile =
                                                                    FFUploadedFile(
                                                                        bytes: Uint8List.fromList(
                                                                            []));
                                                                _model.uploadedFileUrl =
                                                                    '';
                                                              });
                                                            } else {
                                                              var plantsRecordReference2 =
                                                                  PlantsRecord
                                                                      .collection
                                                                      .doc();
                                                              await plantsRecordReference2
                                                                  .set(
                                                                      createPlantsRecordData(
                                                                name: _model
                                                                    .textController4
                                                                    .text,
                                                                interval: _model
                                                                    .countControllerValue4,
                                                                water: _model
                                                                    .textController5
                                                                    .text,
                                                                light: _model
                                                                    .countControllerValue3,
                                                                humidity: _model
                                                                    .countControllerValue2,
                                                                temperature: _model
                                                                    .countControllerValue1,
                                                                image: _model
                                                                    .uploadedFileUrl,
                                                                creationDate:
                                                                    getCurrentTimestamp,
                                                                description:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  getJsonField(
                                                                    functions.jsonConvert(
                                                                        valueOrDefault<
                                                                            String>(
                                                                      _model
                                                                          .geminiResponse,
                                                                      '{\"score\":\"Add\"}',
                                                                    )),
                                                                    r'''$.description''',
                                                                  )?.toString(),
                                                                  'none',
                                                                ),
                                                                score:
                                                                    valueOrDefault<
                                                                        int>(
                                                                  int.parse(
                                                                      valueOrDefault<
                                                                          String>(
                                                                    getJsonField(
                                                                      functions.jsonConvert(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        _model
                                                                            .geminiResponse,
                                                                        '{\"score\":\"Add\"}',
                                                                      )),
                                                                      r'''$.score''',
                                                                    )?.toString(),
                                                                    'Add',
                                                                  )),
                                                                  0,
                                                                ),
                                                                code: random_data
                                                                    .randomString(
                                                                  11,
                                                                  12,
                                                                  true,
                                                                  true,
                                                                  true,
                                                                ),
                                                                espRef: _model
                                                                    .espCardCreated
                                                                    ?.reference,
                                                              ));
                                                              _model.newPlant =
                                                                  PlantsRecord
                                                                      .getDocumentFromData(
                                                                          createPlantsRecordData(
                                                                            name:
                                                                                _model.textController4.text,
                                                                            interval:
                                                                                _model.countControllerValue4,
                                                                            water:
                                                                                _model.textController5.text,
                                                                            light:
                                                                                _model.countControllerValue3,
                                                                            humidity:
                                                                                _model.countControllerValue2,
                                                                            temperature:
                                                                                _model.countControllerValue1,
                                                                            image:
                                                                                _model.uploadedFileUrl,
                                                                            creationDate:
                                                                                getCurrentTimestamp,
                                                                            description:
                                                                                valueOrDefault<String>(
                                                                              getJsonField(
                                                                                functions.jsonConvert(valueOrDefault<String>(
                                                                                  _model.geminiResponse,
                                                                                  '{\"score\":\"Add\"}',
                                                                                )),
                                                                                r'''$.description''',
                                                                              )?.toString(),
                                                                              'none',
                                                                            ),
                                                                            score:
                                                                                valueOrDefault<int>(
                                                                              int.parse(valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  functions.jsonConvert(valueOrDefault<String>(
                                                                                    _model.geminiResponse,
                                                                                    '{\"score\":\"Add\"}',
                                                                                  )),
                                                                                  r'''$.score''',
                                                                                )?.toString(),
                                                                                'Add',
                                                                              )),
                                                                              0,
                                                                            ),
                                                                            code:
                                                                                random_data.randomString(
                                                                              11,
                                                                              12,
                                                                              true,
                                                                              true,
                                                                              true,
                                                                            ),
                                                                            espRef:
                                                                                _model.espCardCreated?.reference,
                                                                          ),
                                                                          plantsRecordReference2);
                                                              await currentUserReference!
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'plants':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      _model
                                                                          .newPlant
                                                                          ?.reference
                                                                    ]),
                                                                    'score': FieldValue.increment(_model
                                                                        .newPlant!
                                                                        .score),
                                                                    'wallet': FieldValue.increment(_model
                                                                        .newPlant!
                                                                        .score),
                                                                  },
                                                                ),
                                                              });
                                                              await _model
                                                                  .espCardCreated!
                                                                  .reference
                                                                  .update(
                                                                      createEspCardRecordData(
                                                                plantName: _model
                                                                    .textController4
                                                                    .text,
                                                              ));
                                                              await WaterRoutineRecord
                                                                      .createDoc(_model
                                                                          .newPlant!
                                                                          .reference)
                                                                  .set(
                                                                      createWaterRoutineRecordData(
                                                                date: functions.nextDayAdd(
                                                                    _model
                                                                        .newPlant!
                                                                        .interval,
                                                                    getCurrentTimestamp),
                                                                status: false,
                                                                score: 25.0,
                                                              ));
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time:
                                                                        getCurrentTimestamp,
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -1,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -2,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -3,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -4,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -5,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await DataSensorsRecord.createDoc(_model
                                                                          .espCardCreated!
                                                                          .reference)
                                                                      .set(
                                                                          createDataSensorsRecordData(
                                                                    light: 0,
                                                                    temperature:
                                                                        0,
                                                                    humidity: 0,
                                                                    time: functions
                                                                        .nextDayAdd(
                                                                            -6,
                                                                            getCurrentTimestamp),
                                                                  ));
                                                                }),
                                                              ]);
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _model.isDataUploading =
                                                                    false;
                                                                _model.uploadedLocalFile =
                                                                    FFUploadedFile(
                                                                        bytes: Uint8List.fromList(
                                                                            []));
                                                                _model.uploadedFileUrl =
                                                                    '';
                                                              });
                                                              await sendData(
                                                                  _model
                                                                      .textController2
                                                                      .text,
                                                                  _model
                                                                      .textController3
                                                                      .text,
                                                                  currentUserReference
                                                                      .toString(),
                                                                  _model
                                                                      .newPlant!
                                                                      .reference
                                                                      .toString(),
                                                                  _model
                                                                      .espCardCreated!
                                                                      .reference
                                                                      .toString());
                                                            }
                                                            setState(() {});
                                                          },
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        functions.jsonConvert(
                                                            valueOrDefault<
                                                                String>(
                                                          _model.geminiResponse,
                                                          '{\"score\":\"Add\"}',
                                                        )),
                                                        r'''$.score''',
                                                      )?.toString(),
                                                      'Add',
                                                    ),
                                                    icon: Icon(
                                                      Icons.add,
                                                      size: 15,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 35,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24, 0, 24, 0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      disabledColor:
                                                          Color(0x8657636C),
                                                      disabledTextColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 15)),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 20),
                                      child: smooth_page_indicator
                                          .SmoothPageIndicator(
                                        controller:
                                            _model.pageViewController ??=
                                                PageController(initialPage: 0),
                                        count: 3,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) async {
                                          await _model.pageViewController!
                                              .animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
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
                                          dotColor: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
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
                        ],
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
