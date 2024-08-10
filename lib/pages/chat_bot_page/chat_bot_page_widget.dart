import 'package:flutter_markdown/flutter_markdown.dart';

import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/gemini/gemini.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'chat_bot_page_model.dart';
export 'chat_bot_page_model.dart';

class ChatBotPageWidget extends StatefulWidget {
  const ChatBotPageWidget({super.key});

  @override
  State<ChatBotPageWidget> createState() => _ChatBotPageWidgetState();
}

class _ChatBotPageWidgetState extends State<ChatBotPageWidget> {
  late ChatBotPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatBotPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF78CA92), Color(0xFF3B6448)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(1, 0.87),
                      end: AlignmentDirectional(-1, -0.87),
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 20,
                                  buttonSize: 34,
                                  fillColor: Color(0x46F9F0F0),
                                  icon: Icon(
                                    FFIcons.kback,
                                    color: Color(0xFF57636C),
                                    size: 12,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ask',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            lineHeight: 1,
                                          ),
                                    ),
                                    Text(
                                      'Gemini',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 22,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                            lineHeight: 1,
                                          ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(width: 10)),
                            ),
                            // Generated code for this IconButton Widget...
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 20,
                                buttonSize: 34,
                                fillColor: Color(0x5FF9F0F0),
                                icon: Icon(
                                  Icons.refresh_outlined,
                                  color: Color(0xFF57636C),
                                  size: 14,
                                ),
                                onPressed: () async {
                                  _model.chatHistory = [];
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0x50FFFFFF), Color(0x2BFFFFFF)],
                              stops: [0, 1],
                              begin: AlignmentDirectional(1, 0.87),
                              end: AlignmentDirectional(-1, -0.87),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Gemini ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Can Assist you to ask any information about planting.',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0,
                                        ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0,
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
              Expanded(
                child: Builder(
                  builder: (context) {
                    final chat = _model.chatHistory.toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: chat.length,
                      itemBuilder: (context, chatIndex) {
                        final chatItem = chat[chatIndex];
                        return Padding(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(1, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(4),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          chatItem.userChat.userText,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (chatItem.userChat.userImage != null &&
                                      chatItem.userChat.userImage != '')
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(4),
                                      ),
                                      child: Image.network(
                                        chatItem.userChat.userImage,
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                ].divide(SizedBox(height: 5)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/Vector_44.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 300,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          FlutterFlowTheme.of(context).primary,
                                          FlutterFlowTheme.of(context).secondary
                                        ],
                                        stops: [0, 1],
                                        begin: AlignmentDirectional(1, 0.87),
                                        end: AlignmentDirectional(-1, -0.87),
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: MarkdownBody(
                                        data: chatItem.geminiChat.toString(),
                                        styleSheet: MarkdownStyleSheet(
                                          p: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          h3: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w800,
                                              ),
                                          listBullet: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 7)),
                              ),
                            ].divide(SizedBox(height: 20)),
                          ),
                        );
                      },
                      controller: _model.listViewController,
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_model.uploadedLocalFile1 != null &&
                                  (_model.uploadedLocalFile1.bytes
                                          ?.isNotEmpty ??
                                      false))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    _model.uploadedLocalFile1.bytes ??
                                        Uint8List.fromList([]),
                                    width: 180,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment: AlignmentDirectional(1, 0),
                                      children: [
                                        Form(
                                          key: _model.formKey,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode:
                                                _model.textFieldFocusNode,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0,
                                                      ),
                                              hintText: 'Ask Gemini...',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        letterSpacing: 0,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              filled: true,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  letterSpacing: 0,
                                                ),
                                            validator: _model
                                                .textControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 10,
                                          buttonSize: 47,
                                          icon: Icon(
                                            Icons.add_photo_alternate_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24,
                                          ),
                                          showLoadingIndicator: true,
                                          onPressed: () async {
                                            final selectedMedia =
                                                await selectMediaWithSourceBottomSheet(
                                              context: context,
                                              allowPhoto: true,
                                            );
                                            if (selectedMedia != null &&
                                                selectedMedia.every((m) =>
                                                    validateFileFormat(
                                                        m.storagePath,
                                                        context))) {
                                              setState(() => _model
                                                  .isDataUploading1 = true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              try {
                                                selectedUploadedFiles =
                                                    selectedMedia
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                            ))
                                                        .toList();
                                              } finally {
                                                _model.isDataUploading1 = false;
                                              }
                                              if (selectedUploadedFiles
                                                      .length ==
                                                  selectedMedia.length) {
                                                setState(() {
                                                  _model.uploadedLocalFile1 =
                                                      selectedUploadedFiles
                                                          .first;
                                                });
                                              } else {
                                                setState(() {});
                                                return;
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF5A956E),
                                          Color(0xFF6A8AFE)
                                        ],
                                        stops: [0, 1],
                                        begin: AlignmentDirectional(0.24, -1),
                                        end: AlignmentDirectional(-0.24, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 10,
                                      buttonSize: 54,
                                      icon: Icon(
                                        FFIcons.ksend,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 24,
                                      ),
                                      showLoadingIndicator: true,
                                      onPressed: () async {
                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        if (_model.uploadedLocalFile1 != null &&
                                            (_model.uploadedLocalFile1.bytes
                                                    ?.isNotEmpty ??
                                                false)) {
                                          {
                                            setState(() =>
                                                _model.isDataUploading2 = true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];
                                            var selectedMedia =
                                                <SelectedFile>[];
                                            var downloadUrls = <String>[];
                                            try {
                                              selectedUploadedFiles = _model
                                                      .uploadedLocalFile1
                                                      .bytes!
                                                      .isNotEmpty
                                                  ? [_model.uploadedLocalFile1]
                                                  : <FFUploadedFile>[];
                                              selectedMedia =
                                                  selectedFilesFromUploadedFiles(
                                                selectedUploadedFiles,
                                              );
                                              downloadUrls = (await Future.wait(
                                                selectedMedia.map(
                                                  (m) async => await uploadData(
                                                      m.storagePath, m.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              _model.isDataUploading2 = false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedMedia.length &&
                                                downloadUrls.length ==
                                                    selectedMedia.length) {
                                              setState(() {
                                                _model.uploadedLocalFile2 =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl2 =
                                                    downloadUrls.first;
                                              });
                                            } else {
                                              setState(() {});
                                              return;
                                            }
                                          }

                                          await geminiTextFromImage(
                                            context,
                                            _model.textController.text,
                                            uploadImageBytes:
                                                _model.uploadedLocalFile1,
                                          ).then((generatedText) {
                                            safeSetState(() =>
                                                _model.geminiResponse =
                                                    generatedText);
                                          });

                                          if (_model.geminiResponse != null &&
                                              _model.geminiResponse != '') {
                                            _model.addToChatHistory(
                                                UserAndGeminiStruct(
                                              geminiChat: _model.geminiResponse,
                                              userChat: UserChatStruct(
                                                userText:
                                                    _model.textController.text,
                                                userImage:
                                                    _model.uploadedFileUrl2,
                                              ),
                                            ));
                                            setState(() {});
                                            setState(() {
                                              _model.textController?.clear();
                                            });
                                            setState(() {
                                              _model.isDataUploading1 = false;
                                              _model.uploadedLocalFile1 =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Your API Call Failed!',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                          }

                                          await Future.delayed(const Duration(
                                              milliseconds: 800));
                                          await _model.listViewController
                                              ?.animateTo(
                                            _model.listViewController!.position
                                                .maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 100),
                                            curve: Curves.ease,
                                          );
                                        } else {
                                          await geminiGenerateText(
                                            context,
                                            'Please answer the following question briefly  based on the previous discussion:Question :${_model.textController.text}Rest of conversation :${functions.getListMessages(_model.chatHistory.toList())}',
                                          ).then((generatedText) {
                                            safeSetState(() =>
                                                _model.geminiResponseText =
                                                    generatedText);
                                          });

                                          if (_model.geminiResponseText !=
                                                  null &&
                                              _model.geminiResponseText != '') {
                                            _model.addToChatHistory(
                                                UserAndGeminiStruct(
                                              geminiChat:
                                                  _model.geminiResponseText,
                                              userChat: UserChatStruct(
                                                userText:
                                                    _model.textController.text,
                                              ),
                                            ));
                                            setState(() {});
                                            setState(() {
                                              _model.textController?.clear();
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Your API Call Failed!',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            );
                                          }

                                          await Future.delayed(const Duration(
                                              milliseconds: 800));
                                          await _model.listViewController
                                              ?.animateTo(
                                            _model.listViewController!.position
                                                .maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 100),
                                            curve: Curves.ease,
                                          );
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10)),
                              ),
                            ].divide(SizedBox(height: 10)),
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
