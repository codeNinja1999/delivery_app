import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope, StateProvider, Consumer;

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

final searchingProvider = StateProvider.autoDispose((ref) => false);

class AnimationSearchBar extends StatelessWidget {
  const AnimationSearchBar({
    super.key,
    this.searchBarWidth,
    this.searchBarHeight,
    this.previousScreen,
    this.backIconColor,
    this.closeIconColor,
    this.searchIconColor,
    this.centerTitle,
    this.centerTitleStyle,
    this.searchFieldHeight,
    this.searchFieldDecoration,
    this.cursorColor,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    required this.onChanged,
    required this.searchTextEditingController,
    this.horizontalPadding,
    this.verticalPadding,
    this.isBackButtonVisible,
    this.backIcon,
    this.duration,
  });

  ///
  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? searchFieldHeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? previousScreen;
  final Color? backIconColor;
  final Color? closeIconColor;
  final Color? searchIconColor;
  final Color? cursorColor;
  final String? centerTitle;
  final String? hintText;
  final bool? isBackButtonVisible;
  final IconData? backIcon;
  final TextStyle? centerTitleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Decoration? searchFieldDecoration;
  final Duration? duration;
  final TextEditingController searchTextEditingController;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final timeDuration = duration ?? const Duration(milliseconds: 500);
    final searchHeight = searchFieldHeight ?? 40;
    final hPadding = horizontalPadding != null ? horizontalPadding! * 2 : 0;
    final searchWidth = searchBarWidth ?? MediaQuery.of(context).size.width - hPadding;
    final isBackButtonDisplayed = isBackButtonVisible ?? true;

    return ProviderScope(
      child: Consumer(builder: (context, ref, __) {
        final isSearching = ref.watch(searchingProvider);
        final searchNotifier = ref.watch(searchingProvider.notifier);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
          child: SizedBox(
            width: searchBarWidth,
            height: searchBarHeight ?? 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                /// back Button
                isBackButtonDisplayed
                    ? AnimatedOpacity(
                        opacity: isSearching ? 0 : 1,
                        duration: timeDuration,
                        child: AnimatedContainer(
                            curve: Curves.easeInOutCirc,
                            width: isSearching ? 0 : 35,
                            height: isSearching ? 0 : 35,
                            duration: timeDuration,
                            child: FittedBox(
                                child:
                                    KBackButton(icon: backIcon, iconColor: backIconColor, previousScreen: previousScreen))))
                    : AnimatedContainer(
                        curve: Curves.easeInOutCirc,
                        width: isSearching ? 0 : 35,
                        height: isSearching ? 0 : 35,
                        duration: timeDuration),

                /// text
                AnimatedOpacity(
                  opacity: isSearching ? 0 : 1,
                  duration: timeDuration,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    width: isSearching ? 0 : searchWidth - 100,
                    duration: timeDuration,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        centerTitle ?? 'Title',
                        textAlign: TextAlign.center,
                        style: centerTitleStyle ??
                            const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                ),

                /// close search
                AnimatedOpacity(
                  opacity: isSearching ? 1 : 0,
                  duration: timeDuration,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    width: isSearching ? 35 : 0,
                    height: isSearching ? 35 : 0,
                    duration: timeDuration,
                    child: FittedBox(
                      child: KCustomButton(
                        widget: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Icon(Icons.close_rounded, color: closeIconColor ?? Colors.black.withOpacity(.7))),
                        onPressed: () {
                          KeyboardUtil.hideKeyboard(context);
                          searchNotifier.state = false;
                          searchTextEditingController.clear();
                          onChanged('');
                        },
                      ),
                    ),
                  ),
                ),

                /// input panel
                AnimatedOpacity(
                  opacity: isSearching ? 1 : 0,
                  duration: timeDuration,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    duration: timeDuration,
                    width: isSearching ? searchWidth - 55 - (horizontalPadding ?? 0 * 2) : 0,
                    height: isSearching ? searchHeight : 20,
                    margin: EdgeInsets.only(left: isSearching ? 5 : 0, right: isSearching ? 10 : 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: searchFieldDecoration ??
                        BoxDecoration(
                            color: Colors.black.withOpacity(.05),
                            border: Border.all(color: Colors.black.withOpacity(.2), width: .5),
                            borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: searchTextEditingController,
                      cursorColor: cursorColor ?? Colors.lightBlue,
                      style: textStyle ?? const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: hintText ?? 'Search here...',
                        hintStyle: hintStyle ?? const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onChanged: onChanged,
                    ),
                  ),
                ),

                ///  search button
                AnimatedOpacity(
                  opacity: isSearching ? 0 : 1,
                  duration: timeDuration,
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    duration: timeDuration,
                    width: isSearching ? 0 : 35,
                    height: isSearching ? 0 : 35,
                    child: FittedBox(
                      child: KCustomButton(
                          widget: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              AppSvg.search,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                searchIconColor ?? Colors.black.withOpacity(.7),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          onPressed: () => searchNotifier.state = true),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class KCustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? radius;

  const KCustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    this.radius,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 50),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 50),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor.withOpacity(.2),
          highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0), child: widget),
        ),
      ),
    );
  }
}

class KBackButton extends StatelessWidget {
  final Widget? previousScreen;
  final Color? iconColor;
  final IconData? icon;
  const KBackButton({super.key, required this.previousScreen, required this.iconColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor.withOpacity(.2),
          highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
          onTap: () async {
            previousScreen == null
                ? Navigator.pop(context)
                : Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => previousScreen!));
          },
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                icon ?? Icons.arrow_back_ios_new,
                color: iconColor ?? Colors.black.withOpacity(.7),
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
