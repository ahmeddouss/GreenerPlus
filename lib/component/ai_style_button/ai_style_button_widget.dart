import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ai_style_button_model.dart';
export 'ai_style_button_model.dart';

class AiStyleButtonWidget extends StatefulWidget {
  const AiStyleButtonWidget({super.key});

  @override
  State<AiStyleButtonWidget> createState() => _AiStyleButtonWidgetState();
}

class _AiStyleButtonWidgetState extends State<AiStyleButtonWidget> {
  late AiStyleButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AiStyleButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        width: 97.0,
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5A956E), Color(0xFF6A8AFE)],
            stops: [0.0, 1.0],
            begin: AlignmentDirectional(-1.0, 0.0),
            end: AlignmentDirectional(1.0, 0),
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/Vector_44.png',
                    width: 16.0,
                    height: 16.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Check',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ].divide(SizedBox(width: 5.0)),
            ),
          ),
        ),
      ),
    );
  }
}
