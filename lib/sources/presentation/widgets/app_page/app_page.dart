import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppPage
/// -------
/// A single, reusable "page shell" (like a BaseViewController in iOS) that:
/// - Keeps Scaffold usage consistent across the app
/// - Optionally applies system UI overlay style (icons brightness, etc.)
/// - Optionally dismisses keyboard on background tap
/// - Protects interactive content from *actual* system UI overlap
///   (navigation bar/home indicator/cutouts) in an orientation-aware way.
///
/// Why NOT systemGestureInsets?
/// ---------------------------
/// `systemGestureInsets` represents the gesture-reserved slop area and can be
/// larger than the real overlapped area, which often creates "too much space".
/// For "exact overlap" spacing, use `viewPadding`/`padding`.
///
/// Modes
/// -----
/// 1) Default constructor: FIXED layout
///    - Applies [padding] + optional overlap-inset protection
///
/// 2) AppPage.scroll: SIMPLE SCROLL layout
///    - Wraps [body] with SingleChildScrollView
///    - Applies scroll padding + optional overlap-inset protection
///
/// 3) AppPage.raw: RAW layout
///    - Scaffold shell only (no padding, no inset protection, no scroll wrapper)
///    - You fully control ListView/CustomScrollView padding/insets.
///
class AppPage extends StatelessWidget {
  // ===========================================================================
  // Constructors
  // ===========================================================================

  /// FIXED (default) — most common pages.
  ///
  /// Use when:
  /// - Body is not a simple "Column that needs scrolling"
  /// - You want consistent padding and safe overlap protection
  /// - You may have a bottom CTA that should not overlap system UI
  const AppPage({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.restorationId,

    // Cross-cutting "base" behaviors
    this.systemUiStyle,
    this.dismissKeyboardOnTap = true,

    // Layout defaults
    this.padding = EdgeInsets.zero,
    this.protectSystemInsets = true,
    this.paintBackground = true,

    // Bottom bar protection (taps not overlapped by system UI)
    this.safeBottomForBottomBar = true,
    this.bottomBarPadding = const EdgeInsets.all(16),
  })  : _mode = _AppPageMode.fixed,
        _wrapScroll = false,
        _scrollPadding = EdgeInsets.zero;

  /// SCROLL — wraps [body] in a SingleChildScrollView.
  ///
  /// Use when:
  /// - Your screen content is a Column/form and you want the whole page to scroll
  ///
  /// Do NOT use when:
  /// - You already have a ListView/CustomScrollView/NestedScrollView
  ///   -> Use AppPage.raw, or default AppPage with a scrollable body.
  const AppPage.scroll({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.restorationId,

    // Cross-cutting "base" behaviors
    this.systemUiStyle,
    this.dismissKeyboardOnTap = true,

    // Scroll layout defaults
    EdgeInsets scrollPadding = const EdgeInsets.all(16),
    this.protectSystemInsets = true,
    this.paintBackground = true,

    // Bottom bar protection
    this.safeBottomForBottomBar = true,
    this.bottomBarPadding = const EdgeInsets.all(16),
  })  : _mode = _AppPageMode.scroll,
        _wrapScroll = true,
        _scrollPadding = scrollPadding,
        padding = EdgeInsets.zero;

  /// RAW — Scaffold shell only. No padding/inset/scroll behavior.
  ///
  /// Use when:
  /// - You provide your own scrollable (ListView/CustomScrollView/NestedScrollView)
  /// - You want full manual control for padding and system insets
  const AppPage.raw({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.restorationId,

    // Cross-cutting "base" behaviors still allowed
    this.systemUiStyle,
    this.dismissKeyboardOnTap = true,

    // In raw mode: these are ignored/disabled by design
    this.padding = EdgeInsets.zero,
    this.protectSystemInsets = false,
    this.paintBackground = true,
    this.safeBottomForBottomBar = false,
    this.bottomBarPadding = EdgeInsets.zero,
  })  : _mode = _AppPageMode.raw,
        _wrapScroll = false,
        _scrollPadding = EdgeInsets.zero;

  // ===========================================================================
  // Scaffold-like parameters (forwarded)
  // ===========================================================================

  final PreferredSizeWidget? appBar;
  final Widget body;

  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final Widget? drawer;
  final Widget? endDrawer;

  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final String? restorationId;

  // ===========================================================================
  // Cross-cutting base behaviors
  // ===========================================================================

  /// Recommended place to set icon brightness for Android/iOS.
  /// Example:
  ///   SystemUiOverlayStyle(
  ///     statusBarIconBrightness: Brightness.dark,
  ///     systemNavigationBarIconBrightness: Brightness.dark,
  ///     systemNavigationBarContrastEnforced: false,
  ///   )
  final SystemUiOverlayStyle? systemUiStyle;

  /// Dismiss keyboard when tapping anywhere outside input fields.
  final bool dismissKeyboardOnTap;

  // ===========================================================================
  // Layout config
  // ===========================================================================

  /// Fixed mode body padding.
  final EdgeInsets padding;

  /// When true, we apply an orientation-aware overlap inset:
  /// - portrait: bottom overlap inset
  /// - landscape: left/right overlap inset
  ///
  /// This protects interactive content from *actual* system UI overlap.
  final bool protectSystemInsets;

  /// Paint behind body and bottom areas to avoid the “dark” system bar gap.
  /// Useful for edge-to-edge on Android.
  final bool paintBackground;

  /// Wrap bottomNavigationBar with SafeArea(top:false) + padding.
  /// Keeps taps out of the overlapped system UI region.
  final bool safeBottomForBottomBar;

  /// Extra padding around bottomNavigationBar content (your app spacing).
  final EdgeInsets bottomBarPadding;

  // Internal mode flags
  final _AppPageMode _mode;
  final bool _wrapScroll;
  final EdgeInsets _scrollPadding;

  // ===========================================================================
  // Build
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    Widget page = Scaffold(
      backgroundColor: bg,
      appBar: appBar,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      restorationId: restorationId,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,

      // Body is painted (optional) so edge-to-edge never shows black gaps.
      body: _paintIfNeeded(bg, _buildBody(context)),

      // Bottom bar is also painted + safe-protected (optional).
      bottomNavigationBar:
          bottomNavigationBar == null ? null : _paintIfNeeded(bg, _buildBottomBar(context, bottomNavigationBar!)),
    );

    // Apply system UI style for the subtree (works even without AppBar).
    if (systemUiStyle != null) {
      page = AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemUiStyle!,
        child: page,
      );
    }

    // Optional keyboard dismiss on tap.
    if (dismissKeyboardOnTap) {
      page = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _dismissKeyboard,
        child: page,
      );
    }

    return page;
  }

  // ===========================================================================
  // Body builders
  // ===========================================================================

  Widget _buildBody(BuildContext context) {
    // RAW mode: you fully manage insets/scroll/padding.
    if (_mode == _AppPageMode.raw) return body;

    final sys = protectSystemInsets ? _systemInsets(context) : EdgeInsets.zero;

    // FIXED mode: apply padding + (optional) overlap inset protection.
    if (_mode == _AppPageMode.fixed) {
      return Padding(
        padding: padding.add(sys),
        child: body,
      );
    }

    // SCROLL mode: wrap simple content with SingleChildScrollView.
    // Intended for Column-based pages, not for ListView/CustomScrollView.
    if (_wrapScroll) {
      return SingleChildScrollView(
        padding: _scrollPadding.add(sys),
        child: body,
      );
    }

    // Fallback (should not happen)
    return body;
  }

  Widget _buildBottomBar(BuildContext context, Widget bottom) {
    // RAW mode: Scaffold shell only; caller manages insets/padding.
    if (_mode == _AppPageMode.raw || !safeBottomForBottomBar) return bottom;

    // `SafeArea` uses MediaQuery.padding (viewPadding minus keyboard),
    // which matches the *actual* overlapped area of system UI.
    return SafeArea(
      top: false,
      child: Padding(
        padding: bottomBarPadding,
        child: bottom,
      ),
    );
  }

  // ===========================================================================
  // Helpers
  // ===========================================================================

  /// Unfocuses any active input field.
  ///
  /// Kept as a static method to avoid creating a new closure each build.
  static void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget _paintIfNeeded(Color bg, Widget child) {
    if (!paintBackground) return child;
    return ColoredBox(color: bg, child: child);
  }

  /// Orientation-aware *overlap* insets (precise).
  ///
  /// IMPORTANT:
  /// - `systemGestureInsets` can be larger than the actual overlapped area (gesture slop),
  ///   so we intentionally DO NOT use it here.
  /// - `viewPadding` represents the real system bars/cutouts that can overlap your UI.
  /// - When the keyboard is open, `padding` is preferred (it subtracts `viewInsets`)
  ///   so we don’t add extra bottom space on top of the keyboard adjustments.
  EdgeInsets _systemInsets(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isLandscape = mq.size.width > mq.size.height;

    final keyboardOpen = mq.viewInsets.bottom > 0;

    // Only apply top inset when you actually need it.
    // If you have a normal AppBar and you're NOT drawing behind it, top is already handled.
    final needsTop = (appBar == null || extendBodyBehindAppBar);

    // Exact overlapped space at the bottom (nav/home indicator).
    final bottom = keyboardOpen ? mq.padding.bottom : mq.viewPadding.bottom;

    if (isLandscape) {
      // In landscape, overlap usually shifts to the sides.
      return EdgeInsets.only(
        left: mq.viewPadding.left,
        right: mq.viewPadding.right,
        top: needsTop ? mq.viewPadding.top : 0,
      );
    } else {
      return EdgeInsets.only(bottom: bottom);
    }
  }
}

enum _AppPageMode { fixed, scroll, raw }
