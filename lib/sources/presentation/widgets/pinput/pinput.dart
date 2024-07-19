import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class Pinput extends StatefulWidget {
  const Pinput({
    this.length = 4,
    this.smsRetriever,
    this.defaultPinTheme,
    this.focusedPinTheme,
    this.submittedPinTheme,
    this.followingPinTheme,
    this.disabledPinTheme,
    this.errorPinTheme,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onTap,
    this.onLongPress,
    this.onTapOutside,
    this.controller,
    this.focusNode,
    this.preFilledWidget,
    this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.pinContentAlignment = Alignment.center,
    this.animationCurve = Curves.easeIn,
    this.animationDuration = PinputConstants._animationDuration,
    this.pinAnimationType = PinAnimationType.scale,
    this.enabled = true,
    this.readOnly = false,
    this.useNativeKeyboard = true,
    this.toolbarEnabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.showCursor = true,
    this.isCursorAnimationEnabled = true,
    this.enableIMEPersonalizedLearning = false,
    this.enableSuggestions = true,
    this.hapticFeedbackType = HapticFeedbackType.disabled,
    this.closeKeyboardWhenCompleted = true,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.slideTransitionBeginOffset,
    this.cursor,
    this.keyboardAppearance,
    this.inputFormatters = const [],
    this.textInputAction,
    this.autofillHints = const [
      AutofillHints.oneTimeCode,
    ],
    this.obscuringCharacter = '•',
    this.obscuringWidget,
    this.selectionControls,
    this.restorationId,
    this.onClipboardFound,
    this.onAppPrivateCommand,
    this.mouseCursor,
    this.forceErrorState = false,
    this.errorText,
    this.validator,
    this.errorBuilder,
    this.errorTextStyle,
    this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
    this.scrollPadding = const EdgeInsets.all(20),
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    Key? key,
  }) :
        //  assert(obscuringCharacter.length == 1),
        // assert(length > 0),
        // assert(
        //   textInputAction != TextInputAction.newline,
        //   'Pinput is not multiline',
        // ),
        // _builder = null,
        super(key: key);

  // Pinput.builder({
  //   required PinItemWidgetBuilder builder,
  //   this.smsRetriever,
  //   this.length,
  //   this.onChanged,
  //   this.onCompleted,
  //   this.onSubmitted,
  //   this.onTap,
  //   this.onLongPress,
  //   this.onTapOutside,
  //   this.controller,
  //   this.focusNode,
  //   this.separatorBuilder,
  //   this.mainAxisAlignment = MainAxisAlignment.center,
  //   this.crossAxisAlignment = CrossAxisAlignment.start,
  //   this.enabled = true,
  //   this.readOnly = false,
  //   this.useNativeKeyboard = true,
  //   this.toolbarEnabled = true,
  //   this.autofocus = false,
  //   this.enableIMEPersonalizedLearning = false,
  //   this.enableSuggestions = true,
  //   this.hapticFeedbackType = HapticFeedbackType.disabled,
  //   this.closeKeyboardWhenCompleted = true,
  //   this.keyboardType = TextInputType.number,
  //   this.textCapitalization = TextCapitalization.none,
  //   this.keyboardAppearance,
  //   this.inputFormatters = const [],
  //   this.textInputAction,
  //   this.autofillHints,
  //   this.selectionControls,
  //   this.restorationId,
  //   this.onClipboardFound,
  //   this.onAppPrivateCommand,
  //   this.mouseCursor,
  //   this.forceErrorState = false,
  //   this.validator,
  //   this.pinputAutovalidateMode = PinputAutovalidateMode.onSubmit,
  //   this.scrollPadding = const EdgeInsets.all(20),
  //   this.contextMenuBuilder = _defaultContextMenuBuilder,
  //   Key? key,
  // })  : assert(length > 0),
  //       assert(
  //         textInputAction != TextInputAction.newline,
  //         'Pinput is not multiline',
  //       ),
  //       _builder = _PinItemBuilder(
  //         itemBuilder: builder,
  //       ),
  //       defaultPinTheme = null,
  //       focusedPinTheme = null,
  //       submittedPinTheme = null,
  //       followingPinTheme = null,
  //       disabledPinTheme = null,
  //       errorPinTheme = null,
  //       preFilledWidget = null,
  //       pinContentAlignment = Alignment.center,
  //       animationCurve = Curves.easeIn,
  //       animationDuration = PinputConstants._animationDuration,
  //       pinAnimationType = PinAnimationType.scale,
  //       obscureText = false,
  //       showCursor = false,
  //       isCursorAnimationEnabled = false,
  //       slideTransitionBeginOffset = null,
  //       cursor = null,
  //       obscuringCharacter = '•',
  //       obscuringWidget = null,
  //       errorText = null,
  //       errorBuilder = null,
  //       errorTextStyle = null,
  //       super(key: key);

  final PinTheme? defaultPinTheme;
  final PinTheme? focusedPinTheme;
  final PinTheme? submittedPinTheme;
  final PinTheme? followingPinTheme;
  final PinTheme? disabledPinTheme;
  final PinTheme? errorPinTheme;
  final bool closeKeyboardWhenCompleted;
  final int length;
  final SmsRetriever? smsRetriever;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? preFilledWidget;
  final JustIndexedWidgetBuilder? separatorBuilder;
  // final _PinItemBuilder? _builder;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final AlignmentGeometry pinContentAlignment;
  final Curve animationCurve;
  final Duration animationDuration;
  final PinAnimationType pinAnimationType;
  final Offset? slideTransitionBeginOffset;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool useNativeKeyboard;
  final bool toolbarEnabled;
  final bool showCursor;
  final bool isCursorAnimationEnabled;
  final bool enableIMEPersonalizedLearning;
  final Widget? cursor;
  final Brightness? keyboardAppearance;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final String obscuringCharacter;
  final Widget? obscuringWidget;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool enableSuggestions;
  final TextSelectionControls? selectionControls;
  final String? restorationId;
  final ValueChanged<String>? onClipboardFound;
  final HapticFeedbackType hapticFeedbackType;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final MouseCursor? mouseCursor;
  final bool forceErrorState;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final PinputErrorBuilder? errorBuilder;
  final FormFieldValidator<String>? validator;
  final PinputAutovalidateMode pinputAutovalidateMode;
  final EdgeInsets scrollPadding;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TapRegionCallback? onTapOutside;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  State<Pinput> createState() => _PinputState();

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'defaultPinTheme',
  //       defaultPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'focusedPinTheme',
  //       focusedPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'submittedPinTheme',
  //       submittedPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'followingPinTheme',
  //       followingPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'disabledPinTheme',
  //       disabledPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinTheme>(
  //       'errorPinTheme',
  //       errorPinTheme,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<TextEditingController>(
  //       'controller',
  //       controller,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<FocusNode>(
  //       'focusNode',
  //       focusNode,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: true));
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'closeKeyboardWhenCompleted',
  //       closeKeyboardWhenCompleted,
  //       defaultValue: true,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<TextInputType>(
  //       'keyboardType',
  //       keyboardType,
  //       defaultValue: TextInputType.number,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<int>(
  //       'length',
  //       length,
  //       defaultValue: PinputConstants._defaultLength,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<ValueChanged<String>?>(
  //       'onCompleted',
  //       onCompleted,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<ValueChanged<String>?>(
  //       'onChanged',
  //       onChanged,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<ValueChanged<String>?>(
  //       'onClipboardFound',
  //       onClipboardFound,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<VoidCallback?>('onTap', onTap, defaultValue: null),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<VoidCallback?>(
  //       'onLongPress',
  //       onLongPress,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Widget?>(
  //       'preFilledWidget',
  //       preFilledWidget,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Widget?>('cursor', cursor, defaultValue: null),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<JustIndexedWidgetBuilder?>(
  //       'separatorBuilder',
  //       separatorBuilder,
  //       defaultValue: PinputConstants._defaultSeparator,
  //     ),
  //   );
  //   // properties.add(
  //   //   DiagnosticsProperty<_PinItemBuilder>(
  //   //     '_builder',
  //   //     _builder,
  //   //     defaultValue: null,
  //   //   ),
  //   // );
  //   properties.add(
  //     DiagnosticsProperty<Widget?>(
  //       'obscuringWidget',
  //       obscuringWidget,
  //       defaultValue: null,
  //     ),
  //   );

  //   properties.add(
  //     DiagnosticsProperty<MainAxisAlignment>(
  //       'mainAxisAlignment',
  //       mainAxisAlignment,
  //       defaultValue: MainAxisAlignment.center,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<AlignmentGeometry>(
  //       'pinContentAlignment',
  //       pinContentAlignment,
  //       defaultValue: Alignment.center,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Curve>(
  //       'animationCurve',
  //       animationCurve,
  //       defaultValue: Curves.easeIn,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Duration>(
  //       'animationDuration',
  //       animationDuration,
  //       defaultValue: PinputConstants._animationDuration,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinAnimationType>(
  //       'pinAnimationType',
  //       pinAnimationType,
  //       defaultValue: PinAnimationType.scale,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Offset?>(
  //       'slideTransitionBeginOffset',
  //       slideTransitionBeginOffset,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: true));
  //   properties.add(
  //     DiagnosticsProperty<bool>('readOnly', readOnly, defaultValue: false),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'obscureText',
  //       obscureText,
  //       defaultValue: false,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'useNativeKeyboard',
  //       useNativeKeyboard,
  //       defaultValue: false,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'toolbarEnabled',
  //       toolbarEnabled,
  //       defaultValue: true,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'showCursor',
  //       showCursor,
  //       defaultValue: true,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<String>(
  //       'obscuringCharacter',
  //       obscuringCharacter,
  //       defaultValue: '•',
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'obscureText',
  //       obscureText,
  //       defaultValue: false,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<bool>(
  //       'enableSuggestions',
  //       enableSuggestions,
  //       defaultValue: true,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<List<TextInputFormatter>>(
  //       'inputFormatters',
  //       inputFormatters,
  //       defaultValue: const <TextInputFormatter>[],
  //     ),
  //   );
  //   properties.add(
  //     EnumProperty<TextInputAction>(
  //       'textInputAction',
  //       textInputAction,
  //       defaultValue: TextInputAction.done,
  //     ),
  //   );
  //   properties.add(
  //     EnumProperty<TextCapitalization>(
  //       'textCapitalization',
  //       textCapitalization,
  //       defaultValue: TextCapitalization.none,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Brightness>(
  //       'keyboardAppearance',
  //       keyboardAppearance,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<TextInputType>(
  //       'keyboardType',
  //       keyboardType,
  //       defaultValue: TextInputType.number,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<Iterable<String>?>(
  //       'autofillHints',
  //       autofillHints,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<TextSelectionControls?>(
  //       'selectionControls',
  //       selectionControls,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<String?>(
  //       'restorationId',
  //       restorationId,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<AppPrivateCommandCallback?>(
  //       'onAppPrivateCommand',
  //       onAppPrivateCommand,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<MouseCursor?>(
  //       'mouseCursor',
  //       mouseCursor,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<TextStyle?>(
  //       'errorTextStyle',
  //       errorTextStyle,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinputErrorBuilder?>(
  //       'errorBuilder',
  //       errorBuilder,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<FormFieldValidator<String>?>(
  //       'validator',
  //       validator,
  //       defaultValue: null,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<PinputAutovalidateMode>(
  //       'pinputAutovalidateMode',
  //       pinputAutovalidateMode,
  //       defaultValue: PinputAutovalidateMode.onSubmit,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<HapticFeedbackType>(
  //       'hapticFeedbackType',
  //       hapticFeedbackType,
  //       defaultValue: HapticFeedbackType.disabled,
  //     ),
  //   );
  //   properties.add(
  //     DiagnosticsProperty<EditableTextContextMenuBuilder?>(
  //       'contextMenuBuilder',
  //       contextMenuBuilder,
  //       defaultValue: _defaultContextMenuBuilder,
  //     ),
  //   );
  // }
}

T? _ambiguate<T>(T? value) => value;

class _PinputState extends State<Pinput>
    with RestorationMixin, WidgetsBindingObserver, _PinputUtilsMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.toolbarEnabled;

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  String? get restorationId => widget.restorationId;

  late TextEditingValue _recentControllerValue;
  late final _PinputSelectionGestureDetectorBuilder _gestureDetectorBuilder;
  RestorableTextEditingController? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;
  String? _validatorErrorText;
  SmsRetriever? _smsRetriever;

  String? get _errorText => widget.errorText ?? _validatorErrorText;

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ?? NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return isEnabled && widget.useNativeKeyboard;
      case NavigationMode.directional:
        return true && widget.useNativeKeyboard;
    }
  }

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  @protected
  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @protected
  bool get hasError => widget.forceErrorState || _validatorErrorText != null;

  @protected
  bool get isEnabled => widget.enabled;

  int get _currentLength => _effectiveController.value.text.characters.length;

  EditableTextState? get _editableText => editableTextKey.currentState;

  int get selectedIndex => pin.length;

  String get pin => _effectiveController.text;

  bool get _completed => pin.length == widget.length;

  @override
  void initState() {
    super.initState();
    _gestureDetectorBuilder = _PinputSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
      _recentControllerValue = TextEditingValue.empty;
    } else {
      _recentControllerValue = _effectiveController.value;
      widget.controller!.addListener(_handleTextEditingControllerChanges);
    }
    effectiveFocusNode.canRequestFocus = isEnabled && widget.useNativeKeyboard;
    _maybeInitSmartAuth();
    _maybeCheckClipboard();

    _ambiguate(WidgetsBinding.instance)!.addObserver(this);
  }

  void _maybeInitSmartAuth() async {
    if (_smsRetriever == null && widget.smsRetriever != null) {
      _smsRetriever = widget.smsRetriever!;
      _listenForSmsCode();
    }
  }

  void _listenForSmsCode() async {
    final res = await _smsRetriever!.getSmsCode();
    if (res != null && res.length == widget.length) {
      _effectiveController.setText(res);
    }

    if (_smsRetriever!.listenForMultipleSms) {
      _listenForSmsCode();
    }
  }

  void _handleTextEditingControllerChanges() {
    final textChanged = _recentControllerValue.text != _effectiveController.value.text;
    _recentControllerValue = _effectiveController.value;
    if (textChanged) {
      _onChanged(pin);
    }
  }

  void _onChanged(String pin) {
    widget.onChanged?.call(pin);
    if (_completed) {
      widget.onCompleted?.call(pin);
      _maybeValidateForm();
      _maybeCloseKeyboard();
    }
  }

  void _maybeValidateForm() {
    if (widget.pinputAutovalidateMode == PinputAutovalidateMode.onSubmit) {
      _validator();
    }
  }

  void _maybeCloseKeyboard() {
    if (widget.closeKeyboardWhenCompleted) {
      effectiveFocusNode.unfocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(Pinput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.removeListener(_handleTextEditingControllerChanges);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleTextEditingControllerChanges);
      widget.controller?.addListener(_handleTextEditingControllerChanges);
    }

    effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    _controller!.addListener(_handleTextEditingControllerChanges);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextEditingControllerChanges);
    _focusNode?.dispose();
    _controller?.dispose();
    _smsRetriever?.dispose();

    _ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    super.dispose();
  }

  void _requestKeyboard() {
    if (effectiveFocusNode.canRequestFocus) {
      _editableText?.requestKeyboard();
    }
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    _effectiveController.selection = TextSelection.collapsed(offset: pin.length);

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.drag) {
          _editableText?.bringIntoView(selection.extent);
        }
        break;
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
        break;
    }
  }

  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (hovering != _isHovering) {
      setState(() => _isHovering = hovering);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) async {
    if (appLifecycleState == AppLifecycleState.resumed) {
      _maybeCheckClipboard();
    }
  }

  void _maybeCheckClipboard() async {
    if (widget.onClipboardFound != null) {
      final clipboard = await _getClipboardOrEmpty();
      if (clipboard.length == widget.length) {
        widget.onClipboardFound!.call(clipboard);
      }
    }
  }

  String? _validator([String? _]) {
    final res = widget.validator?.call(pin);
    setState(() => _validatorErrorText = res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    final isDense = widget.mainAxisAlignment == MainAxisAlignment.center;

    return isDense ? IntrinsicWidth(child: _buildPinput()) : _buildPinput();
  }

  Widget _buildPinput() {
    final theme = Theme.of(context);
    VoidCallback? handleDidGainAccessibilityFocus;
    TextSelectionControls? textSelectionControls = widget.selectionControls;

    switch (theme.platform) {
      case TargetPlatform.iOS:
        forcePressEnabled = true;
        textSelectionControls ??= cupertinoTextSelectionHandleControls;
        break;
      case TargetPlatform.macOS:
        forcePressEnabled = false;
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        handleDidGainAccessibilityFocus = () {
          if (!effectiveFocusNode.hasFocus && effectiveFocusNode.canRequestFocus) {
            effectiveFocusNode.requestFocus();
          }
        };
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionHandleControls;
        break;
      case TargetPlatform.linux:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        break;
      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        handleDidGainAccessibilityFocus = () {
          if (!effectiveFocusNode.hasFocus && effectiveFocusNode.canRequestFocus) {
            effectiveFocusNode.requestFocus();
          }
        };
        break;
    }

    return _PinputFormField(
      enabled: isEnabled,
      validator: _validator,
      initialValue: _effectiveController.text,
      builder: (FormFieldState<String> field) {
        return MouseRegion(
          cursor: _effectiveMouseCursor,
          onEnter: (PointerEnterEvent event) => _handleHover(true),
          onExit: (PointerExitEvent event) => _handleHover(false),
          child: TextFieldTapRegion(
            child: IgnorePointer(
              ignoring: !isEnabled || !widget.useNativeKeyboard,
              child: AnimatedBuilder(
                animation: _effectiveController,
                builder: (_, Widget? child) => Semantics(
                  maxValueLength: widget.length,
                  currentValueLength: _currentLength,
                  onTap: widget.readOnly ? null : _semanticsOnTap,
                  onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                  child: child,
                ),
                child: _gestureDetectorBuilder.buildGestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      _buildEditable(textSelectionControls, field),
                      _buildFields(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditable(
    TextSelectionControls? textSelectionControls,
    FormFieldState<String> field,
  ) {
    final formatters = <TextInputFormatter>[
      ...widget.inputFormatters,
      LengthLimitingTextInputFormatter(
        widget.length,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    ];

    return RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          maxLines: 1,
          style: PinputConstants._hiddenTextStyle,
          onChanged: (value) {
            field.didChange(value);
            _maybeUseHaptic(widget.hapticFeedbackType);
          },
          expands: false,
          showCursor: false,
          autocorrect: false,
          autofillClient: this,
          showSelectionHandles: false,
          rendererIgnoresPointer: true,
          enableInteractiveSelection: false,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          selectionColor: Colors.transparent,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onSubmitted: (s) {
            widget.onSubmitted?.call(s);
            _maybeValidateForm();
          },
          onTapOutside: widget.onTapOutside,
          mouseCursor: MouseCursor.defer,
          focusNode: effectiveFocusNode,
          textAlign: TextAlign.center,
          autofocus: widget.autofocus,
          inputFormatters: formatters,
          restorationId: 'pinput',
          clipBehavior: Clip.hardEdge,
          cursorColor: Colors.transparent,
          controller: _effectiveController,
          autofillHints: widget.autofillHints,
          scrollPadding: widget.scrollPadding,
          selectionWidthStyle: BoxWidthStyle.tight,
          backgroundCursorColor: Colors.transparent,
          selectionHeightStyle: BoxHeightStyle.tight,
          enableSuggestions: widget.enableSuggestions,
          contextMenuBuilder: widget.contextMenuBuilder,
          obscuringCharacter: widget.obscuringCharacter,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onSelectionChanged: _handleSelectionChanged,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          readOnly: widget.readOnly || !isEnabled || !widget.useNativeKeyboard,
          selectionControls: widget.toolbarEnabled ? textSelectionControls : null,
          keyboardAppearance: widget.keyboardAppearance ?? Theme.of(context).brightness,
        ),
      ),
    );
  }

  MouseCursor get _effectiveMouseCursor {
    return MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      <MaterialState>{
        if (!isEnabled) MaterialState.disabled,
        if (_isHovering) MaterialState.hovered,
        if (effectiveFocusNode.hasFocus) MaterialState.focused,
        if (hasError) MaterialState.error,
      },
    );
  }

  void _semanticsOnTap() {
    if (!_effectiveController.selection.isValid) {
      _effectiveController.selection = TextSelection.collapsed(offset: _effectiveController.text.length);
    }
    _requestKeyboard();
  }

  PinItemStateType _getState(int index) {
    if (!isEnabled) {
      return PinItemStateType.disabled;
    }

    if (showErrorState) {
      return PinItemStateType.error;
    }

    if (hasFocus && index == selectedIndex.clamp(0, widget.length - 1)) {
      return PinItemStateType.focused;
    }

    if (index < selectedIndex) {
      return PinItemStateType.submitted;
    }

    return PinItemStateType.following;
  }

  Widget _buildFields() {
    Widget onlyFields() {
      return _SeparatedRaw(
        separatorBuilder: widget.separatorBuilder,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: Iterable<int>.generate(widget.length).map<Widget>((index) {
          // if (widget._builder != null) {
          //   return widget._builder!.itemBuilder.call(
          //     context,
          PinItemState(
            value: pin.length > index ? pin[index] : '',
            index: index,
            type: _getState(index),
          );
          // );
          // }

          return _PinItem(state: this, index: index);
        }).toList(),
      );
    }

    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge(
          <Listenable>[effectiveFocusNode, _effectiveController],
        ),
        builder: (BuildContext context, Widget? child) {
          final shouldHideErrorContent = widget.validator == null && widget.errorText == null;

          if (shouldHideErrorContent) return onlyFields();

          return AnimatedSize(
            duration: widget.animationDuration,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [
                onlyFields(),
                _buildError(),
              ],
            ),
          );
        },
      ),
    );
  }

  @protected
  bool get hasFocus {
    final isLastPin = selectedIndex == widget.length;
    return effectiveFocusNode.hasFocus || (!widget.useNativeKeyboard && !isLastPin);
  }

  @protected
  bool get showErrorState => hasError && (!hasFocus || widget.forceErrorState);

  Widget _buildError() {
    if (showErrorState) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!.call(_errorText, pin);
      }

      final theme = Theme.of(context);
      if (_errorText != null) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, top: 8),
          child: Text(
            _errorText!,
            style: widget.errorTextStyle ?? theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }
}

class PinItem extends StatelessWidget {
  final _PinputState state;
  final int index;

  const PinItem({
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pinTheme = _pinTheme(index);

    return Flexible(
      child: AnimatedContainer(
        height: pinTheme.height,
        width: pinTheme.width,
        constraints: pinTheme.constraints,
        padding: pinTheme.padding,
        margin: pinTheme.margin,
        decoration: pinTheme.decoration,
        alignment: state.widget.pinContentAlignment,
        duration: state.widget.animationDuration,
        curve: state.widget.animationCurve,
        child: AnimatedSwitcher(
          switchInCurve: state.widget.animationCurve,
          switchOutCurve: state.widget.animationCurve,
          duration: state.widget.animationDuration,
          transitionBuilder: _getTransition,
          child: _buildFieldContent(index, pinTheme),
        ),
      ),
    );
  }

  PinTheme _pinTheme(int index) {
    final pintState = state._getState(index);
    switch (pintState) {
      case PinItemStateType.initial:
        return _getDefaultPinTheme();
      case PinItemStateType.focused:
        return _pinThemeOrDefault(state.widget.focusedPinTheme);
      case PinItemStateType.submitted:
        return _pinThemeOrDefault(state.widget.submittedPinTheme);
      case PinItemStateType.following:
        return _pinThemeOrDefault(state.widget.followingPinTheme);
      case PinItemStateType.disabled:
        return _pinThemeOrDefault(state.widget.disabledPinTheme);
      case PinItemStateType.error:
        return _pinThemeOrDefault(state.widget.errorPinTheme);
    }
  }

  PinTheme _getDefaultPinTheme() => state.widget.defaultPinTheme ?? PinputConstants._defaultPinTheme;

  PinTheme _pinThemeOrDefault(PinTheme? theme) => theme ?? _getDefaultPinTheme();

  Widget _buildFieldContent(int index, PinTheme pinTheme) {
    final pin = state.pin;
    final key = ValueKey<String>(index < pin.length ? pin[index] : '');
    final isSubmittedPin = index < pin.length;

    if (isSubmittedPin) {
      if (state.widget.obscureText && state.widget.obscuringWidget != null) {
        return SizedBox(key: key, child: state.widget.obscuringWidget);
      }

      return Text(
        state.widget.obscureText ? state.widget.obscuringCharacter : pin[index],
        key: key,
        style: pinTheme.textStyle,
      );
    }

    final isActiveField = index == pin.length;
    final focused = state.effectiveFocusNode.hasFocus || !state.widget.useNativeKeyboard;
    final shouldShowCursor = state.widget.showCursor && state.isEnabled && isActiveField && focused;

    if (shouldShowCursor) {
      return _buildCursor(pinTheme);
    }

    if (state.widget.preFilledWidget != null) {
      return SizedBox(key: key, child: state.widget.preFilledWidget);
    }

    return Text('', key: key, style: pinTheme.textStyle);
  }

  Widget _buildCursor(PinTheme pinTheme) {
    if (state.widget.isCursorAnimationEnabled) {
      return _PinputAnimatedCursor(
        textStyle: pinTheme.textStyle,
        cursor: state.widget.cursor,
      );
    }

    return _PinputCursor(
      textStyle: pinTheme.textStyle,
      cursor: state.widget.cursor,
    );
  }

  Widget _getTransition(Widget child, Animation<double> animation) {
    if (child is _PinputAnimatedCursor) {
      return child;
    }

    switch (state.widget.pinAnimationType) {
      case PinAnimationType.none:
        return child;
      case PinAnimationType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case PinAnimationType.scale:
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      case PinAnimationType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: state.widget.slideTransitionBeginOffset ?? const Offset(0.8, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PinAnimationType.rotation:
        return RotationTransition(
          turns: animation,
          child: child,
        );
    }
  }
}

class _PinputSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _PinputSelectionGestureDetectorBuilder({required _PinputState state})
      : _state = state,
        super(delegate: state);

  final _PinputState _state;

  @override
  void onForcePressStart(details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onSingleTapUp(details) {
    super.onSingleTapUp(details);
    editableText.hideToolbar();
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapEnd(LongPressEndDetails details) {
    super.onSingleLongTapEnd(details);
    _state.widget.onLongPress?.call();
  }

  @override
  void onSingleLongTapStart(details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}

typedef JustIndexedWidgetBuilder = Widget Function(int index);

class _PinputFormField extends FormField<String> {
  const _PinputFormField({
    required final FormFieldValidator<String>? validator,
    required final bool enabled,
    required final String? initialValue,
    required final Widget Function(FormFieldState<String> field) builder,
    Key? key,
  }) : super(
          key: key,
          enabled: enabled,
          validator: validator,
          autovalidateMode: AutovalidateMode.disabled,
          initialValue: initialValue,
          builder: builder,
        );
}

class _SeparatedRaw extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final JustIndexedWidgetBuilder? separatorBuilder;

  const _SeparatedRaw({
    required this.children,
    required this.mainAxisAlignment,
    this.separatorBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemCount = max(0, children.length * 2 - 1);
    final indexedList = [for (int i = 0; i < itemCount; i += 1) i];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisAlignment == MainAxisAlignment.center ? MainAxisSize.min : MainAxisSize.max,
      children: indexedList.map((index) {
        final itemIndex = index ~/ 2;
        return index.isEven ? children[itemIndex] : _separator(itemIndex);
      }).toList(growable: false),
    );
  }

  Widget _separator(int index) => separatorBuilder?.call(index) ?? PinputConstants._defaultSeparator;
}

class _PinputCursor extends StatelessWidget {
  final Widget? cursor;
  final TextStyle? textStyle;

  const _PinputCursor({required this.textStyle, required this.cursor});

  @override
  Widget build(BuildContext context) => cursor ?? Text('|', style: textStyle);
}

class _PinputAnimatedCursor extends StatefulWidget {
  final Widget? cursor;
  final TextStyle? textStyle;

  const _PinputAnimatedCursor({
    required this.textStyle,
    required this.cursor,
  });

  @override
  State<_PinputAnimatedCursor> createState() => _PinputAnimatedCursorState();
}

class _PinputAnimatedCursorState extends State<_PinputAnimatedCursor> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _startCursorAnimation();
  }

  void _startCursorAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animationController.repeat(reverse: true);
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: _PinputCursor(textStyle: widget.textStyle, cursor: widget.cursor),
    );
  }
}

class PinTheme {
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;

  const PinTheme({
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textStyle,
    this.decoration,
    this.constraints,
  });

  PinTheme apply({required PinTheme theme}) {
    return PinTheme(
      width: width ?? theme.width,
      height: height ?? theme.height,
      textStyle: textStyle ?? theme.textStyle,
      constraints: constraints ?? theme.constraints,
      decoration: decoration ?? theme.decoration,
      padding: padding ?? theme.padding,
      margin: margin ?? theme.margin,
    );
  }

  PinTheme copyWith({
    double? width,
    double? height,
    TextStyle? textStyle,
    BoxConstraints? constraints,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return PinTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      textStyle: textStyle ?? this.textStyle,
      constraints: constraints ?? this.constraints,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
    );
  }

  PinTheme copyDecorationWith({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape? shape,
  }) {
    assert(decoration != null);
    return copyWith(
      decoration: decoration?.copyWith(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape,
      ),
    );
  }

  PinTheme copyBorderWith({required Border border}) {
    assert(decoration != null);
    return copyWith(
      decoration: decoration?.copyWith(border: border),
    );
  }
}

abstract class SmsRetriever {
  bool get listenForMultipleSms;
  Future<String?> getSmsCode();
  Future<void> dispose();
}

typedef PinItemWidgetBuilder = Widget Function(
  BuildContext context,
  PinItemState pinItemBuilderState,
);

enum PinItemStateType {
  initial,
  focused,
  submitted,
  following,
  disabled,
  error,
}

class PinItemState {
  const PinItemState({
    required this.value,
    required this.index,
    required this.type,
  });

  final String value;
  final int index;
  final PinItemStateType type;
}

class _PinItemBuilder {
  const _PinItemBuilder({
    required this.itemBuilder,
  });

  final PinItemWidgetBuilder itemBuilder;
}

enum PinputAutovalidateMode {
  disabled,
  onSubmit,
}

enum AndroidSmsAutofillMethod {
  none,
  smsRetrieverApi,
  smsUserConsentApi,
}

enum PinAnimationType {
  none,
  scale,
  fade,
  slide,
  rotation,
}

enum HapticFeedbackType {
  disabled,
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
  vibrate,
}

typedef PinputErrorBuilder = Widget Function(String? errorText, String pin);

extension PinputControllerExt on TextEditingController {
  int get length => this.text.length;

  void setText(String pin) {
    this.text = pin;
    this.moveCursorToEnd();
  }

  void delete() {
    if (text.isEmpty) return;
    final pin = this.text.substring(0, this.length - 1);
    this.text = pin;
    this.moveCursorToEnd();
  }

  void append(String s, int maxLength) {
    if (this.length == maxLength) return;
    this.text = '${this.text}$s';
    this.moveCursorToEnd();
  }

  void moveCursorToEnd() {
    this.selection = TextSelection.collapsed(offset: this.length);
  }
}

class PinputConstants {
  const PinputConstants._();

  static const defaultSmsCodeMatcher = '\\d{4,7}';

  static const _animationDuration = Duration(milliseconds: 180);

  static const _defaultLength = 6;

  static const _defaultSeparator = SizedBox(width: 8);

  static const _hiddenTextStyle = TextStyle(fontSize: 1, height: 1, color: Colors.transparent);

  static const _defaultPinFillColor = Color.fromRGBO(222, 231, 240, .57);
  static const _defaultPinputDecoration = BoxDecoration(
    color: _defaultPinFillColor,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const _defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(),
    decoration: _defaultPinputDecoration,
  );
}

mixin _PinputUtilsMixin {
  void _maybeUseHaptic(HapticFeedbackType hapticFeedbackType) {
    switch (hapticFeedbackType) {
      case HapticFeedbackType.disabled:
        break;
      case HapticFeedbackType.lightImpact:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.mediumImpact:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavyImpact:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selectionClick:
        HapticFeedback.selectionClick();
        break;
      case HapticFeedbackType.vibrate:
        HapticFeedback.vibrate();
        break;
    }
  }

  Future<String> _getClipboardOrEmpty() async {
    final ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    return clipboardData?.text ?? '';
  }
}

class _PinItem extends StatelessWidget {
  final _PinputState state;
  final int index;

  const _PinItem({
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final pinTheme = _pinTheme(index);

    return Flexible(
      child: AnimatedContainer(
        height: pinTheme.height,
        width: pinTheme.width,
        constraints: pinTheme.constraints,
        padding: pinTheme.padding,
        margin: pinTheme.margin,
        decoration: pinTheme.decoration,
        alignment: state.widget.pinContentAlignment,
        duration: state.widget.animationDuration,
        curve: state.widget.animationCurve,
        child: AnimatedSwitcher(
          switchInCurve: state.widget.animationCurve,
          switchOutCurve: state.widget.animationCurve,
          duration: state.widget.animationDuration,
          transitionBuilder: _getTransition,
          child: _buildFieldContent(index, pinTheme),
        ),
      ),
    );
  }

  PinTheme _pinTheme(int index) {
    final pintState = state._getState(index);
    switch (pintState) {
      case PinItemStateType.initial:
        return _getDefaultPinTheme();
      case PinItemStateType.focused:
        return _pinThemeOrDefault(state.widget.focusedPinTheme);
      case PinItemStateType.submitted:
        return _pinThemeOrDefault(state.widget.submittedPinTheme);
      case PinItemStateType.following:
        return _pinThemeOrDefault(state.widget.followingPinTheme);
      case PinItemStateType.disabled:
        return _pinThemeOrDefault(state.widget.disabledPinTheme);
      case PinItemStateType.error:
        return _pinThemeOrDefault(state.widget.errorPinTheme);
    }
  }

  PinTheme _getDefaultPinTheme() => state.widget.defaultPinTheme ?? PinputConstants._defaultPinTheme;

  PinTheme _pinThemeOrDefault(PinTheme? theme) => theme ?? _getDefaultPinTheme();

  Widget _buildFieldContent(int index, PinTheme pinTheme) {
    final pin = state.pin;
    final key = ValueKey<String>(index < pin.length ? pin[index] : '');
    final isSubmittedPin = index < pin.length;

    if (isSubmittedPin) {
      if (state.widget.obscureText && state.widget.obscuringWidget != null) {
        return SizedBox(key: key, child: state.widget.obscuringWidget);
      }

      return Text(
        state.widget.obscureText ? state.widget.obscuringCharacter : pin[index],
        key: key,
        style: pinTheme.textStyle,
      );
    }

    final isActiveField = index == pin.length;
    final focused = state.effectiveFocusNode.hasFocus || !state.widget.useNativeKeyboard;
    final shouldShowCursor = state.widget.showCursor && state.isEnabled && isActiveField && focused;

    if (shouldShowCursor) {
      return _buildCursor(pinTheme);
    }

    if (state.widget.preFilledWidget != null) {
      return SizedBox(key: key, child: state.widget.preFilledWidget);
    }

    return Text('', key: key, style: pinTheme.textStyle);
  }

  Widget _buildCursor(PinTheme pinTheme) {
    if (state.widget.isCursorAnimationEnabled) {
      return _PinputAnimatedCursor(
        textStyle: pinTheme.textStyle,
        cursor: state.widget.cursor,
      );
    }

    return _PinputCursor(
      textStyle: pinTheme.textStyle,
      cursor: state.widget.cursor,
    );
  }

  Widget _getTransition(Widget child, Animation<double> animation) {
    if (child is _PinputAnimatedCursor) {
      return child;
    }

    switch (state.widget.pinAnimationType) {
      case PinAnimationType.none:
        return child;
      case PinAnimationType.fade:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case PinAnimationType.scale:
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      case PinAnimationType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: state.widget.slideTransitionBeginOffset ?? const Offset(0.8, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PinAnimationType.rotation:
        return RotationTransition(
          turns: animation,
          child: child,
        );
    }
  }
}
