import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_list_component_model.dart';
export 'empty_list_component_model.dart';

class EmptyListComponentWidget extends StatefulWidget {
  const EmptyListComponentWidget({
    super.key,
    String? parametre,
  }) : this.parametre = parametre ?? 'none';

  final String parametre;

  @override
  State<EmptyListComponentWidget> createState() =>
      _EmptyListComponentWidgetState();
}

class _EmptyListComponentWidgetState extends State<EmptyListComponentWidget> {
  late EmptyListComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyListComponentModel());

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
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        'No ${widget!.parametre} Found',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Montserrat',
              fontSize: 17.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
