import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:greener_plus/backend/push_notifications/push_notifications_util.dart';

import 'package:greener_plus/widgets/qr_scanned_dialog/qr_scanned_dialog_widget.dart';

import '/backend/backend.dart';
import '/backend/gemini/gemini.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';

import '/widgets/scanned_disease_plant_dialog/scanned_disease_plant_dialog_widget.dart';
import '/widgets/scanned_plant_details_dialog/scanned_plant_details_dialog_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;

import 'package:google_fonts/google_fonts.dart';

import 'scanning_page_model.dart';
export 'scanning_page_model.dart';
import 'package:camera/camera.dart';

class ScanningPageWidget extends StatefulWidget {
  const ScanningPageWidget({super.key});

  @override
  State<ScanningPageWidget> createState() => _ScanningPageWidgetState();
}

class _ScanningPageWidgetState extends State<ScanningPageWidget> {
  Future<void>? _initializeControllerFuture;
  late ScanningPageModel _model;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  InputImage? inputImages;

  Future<void> captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController?.takePicture();
      final imageBytes = await image?.readAsBytes();

      final inputImage = InputImage.fromFilePath(image!.path);
      if (imageBytes != null) {
        final ffUploadedFile = FFUploadedFile(
          name: image.name,
          bytes: imageBytes,
          height: 1280, // you can dynamically get height if needed
          width: 720, // you can dynamically get width if needed
        );

        // Now you can use the ffUploadedFile instance as needed
        print(ffUploadedFile);
        setState(() {
          inputImages = inputImage;
          _model.uploadedLocalFile = ffUploadedFile;
          //imageFile = visionImage;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0], // Use the first available camera
        ResolutionPreset.high,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> scanBarcode(InputImage inputImage) async {
    final barcodes = await BarcodeScanner().processImage(inputImage);
    String text = "No detection";
    try {
      text = barcodes.firstOrNull!.displayValue.toString();

      _model.outputCopy = await queryPlantsRecordOnce(
        queryBuilder: (plantsRecord) => plantsRecord.where(
          'code',
          isEqualTo: text,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.outputCopy?.reference != null) {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0, 0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
                child: QrScannedDialogWidget(
                  plantRef: _model.outputCopy!.reference,
                ),
              ),
            );
          },
        ).then((value) => setState(() {}));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cannot Detect Plante!',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).alternate,
        ),
      );
    }

    setState(() {});
    // ... process barcodes
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanningPageModel());
    initializeCamera();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
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
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              _isCameraInitialized
                  ? SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 90,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 140),
                        height: _model.showButtons ? 210.0 : 60.0,
                        curve: Curves.easeIn,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_model.showButtons)
                                  Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderRadius: 35.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0x32CEB8B8),
                                      icon: Icon(
                                        Icons.qr_code,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                      showLoadingIndicator: true,
                                      onPressed: () async {
                                        await captureImage();
                                        await scanBarcode(inputImages!);
                                      },
                                    ),
                                  ),
                                if (_model.showButtons)
                                  Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 35.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0x32CEB8B8),
                                      icon: Icon(
                                        Icons.spa,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                      showLoadingIndicator: true,
                                      onPressed: () async {
                                        await captureImage();
                                        await geminiTextFromImage(
                                          context,
                                          'if image containe plant return only the name else return no',
                                          uploadImageBytes:
                                              _model.uploadedLocalFile,
                                        ).then((generatedText) {
                                          safeSetState(() =>
                                              _model.plantName = generatedText);
                                        });

                                        if (_model.plantName == 'no') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Cannot Detect Plante!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          );
                                        } else {
                                          await geminiGenerateText(
                                            context,
                                            valueOrDefault<String>(
                                              'What are the maximum values that the plant${_model.plantName}can withstand without being in danger? Provide the response in JSON format:{ \"humidity\": \"valeur moyen%(intiger)\", \"temperature\": \"valeur moyen°C(intiger)\", \"light\": \"valeur moyen LDR (from 0 to 1023)(intiger)\", \"description\": \"short description about the plant (max 2 lines)\", \"interval\":\"number of days between each watering(integer)\", \"water\":\"water quantity(text(max 4 word))\", \"score\": \"integer (between 20-150, depending on the difficulty and rarity of the plant)\" }',
                                              'None',
                                            ),
                                          ).then((generatedText) {
                                            safeSetState(() => _model
                                                .geminiJson = generatedText);
                                          });

                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child:
                                                      ScannedPlantDetailsDialogWidget(
                                                    plantName:
                                                        _model.plantName!,
                                                    geminiResponse:
                                                        _model.geminiJson!,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                if (_model.showButtons)
                                  Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 35.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      fillColor: Color(0x32CEB8B8),
                                      icon: Icon(
                                        Icons.health_and_safety_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                      showLoadingIndicator: true,
                                      onPressed: () async {
                                        await captureImage();
                                        await geminiTextFromImage(
                                          context,
                                          'if there is deases (What is the Plant diseases in this picture and how to trate it answer in Json format {\"name\":\"diseases name\",\"level\":\"(integer from 0 to 100 )danger level\",\"answer\":\"advice how to trate this diseases in max 3 line\"}) else return no',
                                          uploadImageBytes:
                                              _model.uploadedLocalFile,
                                        ).then((generatedText) {
                                          safeSetState(() => _model
                                              .geminiAnswer = generatedText);
                                        });

                                        if ((_model.geminiAnswer == 'no') ||
                                            ('${getJsonField(
                                                  functions.jsonConvert(
                                                      _model.geminiAnswer),
                                                  r'''$.name''',
                                                ).toString()}' ==
                                                'no') ||
                                            ('${getJsonField(
                                                  functions.jsonConvert(
                                                      _model.geminiAnswer),
                                                  r'''$.name''',
                                                ).toString()}' ==
                                                'no diseases')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'No diseases detected',
                                                style: GoogleFonts.getFont(
                                                  'Roboto',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child:
                                                      ScannedDiseasePlantDialogWidget(
                                                    geminiResponse: functions
                                                        .jsonConvert(_model
                                                            .geminiAnswer)!,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x32CEB8B8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: ToggleIcon(
                                      onPressed: () async {
                                        setState(() => _model.showButtons =
                                            !_model.showButtons);
                                      },
                                      value: _model.showButtons,
                                      onIcon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                      offIcon: Icon(
                                        Icons.camera_enhance_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 10.0)),
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
        ),
      ),
    );
  }
}
