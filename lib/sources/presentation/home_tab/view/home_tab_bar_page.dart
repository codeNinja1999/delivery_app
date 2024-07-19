import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import '../../app_account_utility/route/app_account_utility_route.dart';
import '../../dashboard/dashboard.dart';

class HomeTabBar extends StatefulWidget {
  final int initialTabIndex;
  const HomeTabBar({super.key, this.initialTabIndex = 0});

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  int currentTab = 0;

  @override
  void initState() {
    currentTab = widget.initialTabIndex;
    super.initState();
  }

  void updateTab(int selectedTab) {
    KeyboardUtil.hideKeyboard(context);
    switch (selectedTab) {
      case 1:
        Navigator.pushNamed(context, AppRoute.beneficiaryList);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoute.sendMoney);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoute.transactionList);
        break;
      case 4:
        Navigator.pushNamed(context, AppAccountUtilityRoute.account);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: theme.colorScheme.surface,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          child: Stack(children: <Widget>[
            Offstage(
              offstage: currentTab != 0,
              child: BlocProvider(
                create: (context) => sl<DashboardBloc>(),
                child: DashboardPage(sendMoneyCallBack: () => updateTab(2)),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.homeTabBarBackgroundColor,
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: AppColors.homeTabBarBorderColor.withOpacity(0.05)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _TabBarItem(
                  onPressed: () => updateTab(0),
                  iconImage: AppSvg.home,
                  title: LocaleKeys.home.value,
                  index: 0,
                ),
                _TabBarItem(
                  onPressed: () => updateTab(1),
                  iconImage: AppSvg.beneficiary,
                  title: LocaleKeys.receiver.value,
                ),
                _TabBarItem(
                  onPressed: () => updateTab(2),
                  iconImage: AppSvg.sendMoney,
                  title: LocaleKeys.send.value,
                ),
                _TabBarItem(
                  onPressed: () => updateTab(3),
                  iconImage: AppSvg.history,
                  title: LocaleKeys.history.value,
                ),
                _TabBarItem(
                  onPressed: () => updateTab(4),
                  iconImage: AppSvg.account,
                  title: LocaleKeys.setting.value,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.onPressed,
    required this.iconImage,
    required this.title,
    this.index,
  });
  final Function() onPressed;
  final String iconImage;
  final String title;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialButton(
      minWidth: AppSize.iconHeight,
      highlightColor: theme.colorScheme.shadow,
      splashColor: theme.colorScheme.shadow,
      onPressed: onPressed,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        SvgPicture.asset(
          iconImage,
          height: AppSize.iconHeight,
          colorFilter: ColorFilter.mode(
            index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: AppSize.cornerRadiusSmall),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
        )
      ]),
    );
  }
}
