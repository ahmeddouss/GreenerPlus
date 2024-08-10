import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/widgets/delete_dialog/delete_dialog_widget.dart';
import '/widgets/edit_plant_dialog/edit_plant_dialog_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_svg/flutter_svg.dart';

import 'drop_down_component_model.dart';
export 'drop_down_component_model.dart';

class DropDownComponentWidget extends StatefulWidget {
  const DropDownComponentWidget({
    super.key,
    required this.plantRef,
  });

  final DocumentReference? plantRef;

  @override
  State<DropDownComponentWidget> createState() =>
      _DropDownComponentWidgetState();
}

class _DropDownComponentWidgetState extends State<DropDownComponentWidget> {
  final directory = Directory('/storage/emulated/0/Download');

  late DropDownComponentModel _model;

  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    // Increase the dimensions to get a higher-quality image
    final width = 200; // Width in pixels
    final height = 80; // Height in pixels

    final pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), context);

    final image = await pictureInfo.picture.toImage(width, height);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  Future<void> _downloadBarcode(
      BuildContext context, String data, String name) async {
    if (await Permission.storage.request().isGranted) {
      try {
        // Create the Barcode
        final barcode = Barcode.code128();

        // Generate the barcode as an SVG string
        final svg = barcode.toSvg(
          data,
          width: 200,
          height: 80,
          drawText: false,
        );

        // Convert SVG to PNG
        final pngBytes = await svgToPng(svg, context);

        // Get directory to save the image
        // final directory = await getExternalStorageDirectory();

        final filePath = '${directory.path}/${name}.png';
        final file = File(filePath);

        // Save the image
        await file.writeAsBytes(pngBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Barcode saved to Download')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
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
    _model = createModel(context, () => DropDownComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: 200,
          decoration: BoxDecoration(),
          alignment: AlignmentDirectional(-1, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(15),
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

                    final selectWidgetPlantsRecord = snapshot.data!;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 0, 0),
                          child: Text(
                            'Options',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0, 0)
                                        .resolve(Directionality.of(context)),
                                    child: EditPlantDialogWidget(
                                      plantRef: widget!.plantRef!,
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Icon(
                                      Icons.edit_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Edit',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0, 0)
                                        .resolve(Directionality.of(context)),
                                    child: EditPlantDialogWidget(
                                      plantRef: widget!.plantRef!,
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await _downloadBarcode(
                                      context,
                                      selectWidgetPlantsRecord.code,
                                      selectWidgetPlantsRecord.name);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Icon(
                                        Icons.download_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          selectWidgetPlantsRecord.code,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
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
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                              _model.plantDoc =
                                  await PlantsRecord.getDocumentOnce(
                                      widget!.plantRef!);
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0, 0)
                                        .resolve(Directionality.of(context)),
                                    child: DeleteDialogWidget(
                                      plantRef: _model.plantDoc!,
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));

                              setState(() {});
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Icon(
                                        Icons.delete_outline_rounded,
                                        color: Color(0xFFFF5963),
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          'Delete',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFFF5963),
                                                fontSize: 15,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
