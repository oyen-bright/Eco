part of '../dashboard_drawer.dart';

class DrawerTileList extends StatelessWidget {
  const DrawerTileList({super.key});

  @override
  Widget build(BuildContext context) {
    print(GoRouterState.of(context).uri.toString());

    final currentRoute = GoRouterState.of(context).uri.toString();

    void closeDrawer() =>
        context.read<AppScaffoldController>().closeEndDrawer();

    final listDrawerItem = [
      {
        'iconData': AppImages.dashboardIcon,
        'title': Strings.dashboardTitle,
        'isSelected': currentRoute == EcomotoRoutes.profile,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profile);
        }
      },
      {
        'iconData': AppImages.savedIcon,
        'title': Strings.savedMenu,
        'isSelected': false,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profile);
        }
      },
      {
        'iconData': AppImages.reviewIcon,
        'title': Strings.reviewTitle,
        'isSelected': false,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profile);
        }
      },
      {
        'iconData': AppImages.verifyIcon,
        'title': Strings.verifyTitle,
        'isSelected': currentRoute == EcomotoRoutes.profileProfile,
        'callBack': () {
          closeDrawer();

          AppRouter.router.go(EcomotoRoutes.profileProfile);
        }
      },
      {
        'iconData': AppImages.notificationIcon,
        'title': Strings.notificationTitle,
        'isSelected': currentRoute == EcomotoRoutes.profilePayments,
        'callBack': () {
          closeDrawer();

          AppRouter.router.go(EcomotoRoutes.profilePayments);
        }
      },
      {
        'iconData': AppImages.settingsIcon,
        'title': Strings.settingsTitle,
        'isSelected': currentRoute == EcomotoRoutes.profileSettings,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profileSettings);
        }
      },
      {
        'iconData': AppImages.helpIcon,
        'title': Strings.helpCenterTitle,
        'isSelected': false,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profileSettings);
        }
      },
      {
        'iconData': AppImages.termsPolicyIcon,
        'title': Strings.termsPoliciesTitle,
        'isSelected': false,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profileSettings);
        }
      },
      {
        'iconData': AppImages.logoutIcon,
        'title': Strings.logoutTitle,
        'isSelected': false,
        'textColor': Colors.red,
        'callBack': () {
          closeDrawer();
          AppRouter.router.go(EcomotoRoutes.profileSettings);
        }
      }
    ];
    return ListView.separated(
        separatorBuilder: (context, index) {
          if (index == 5) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    Strings.helpSupport,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }
          if (index == 7) {
            return const Divider();
          }
          return const SizedBox.shrink();
        },
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (_, index) {
          final String icon = listDrawerItem[index]['iconData']! as String;
          final String title = listDrawerItem[index]['title']! as String;
          final bool isSelected = listDrawerItem[index]['isSelected']! as bool;
          final Color? textColor = listDrawerItem[index]['textColor'] as Color?;
          final VoidCallback callBack =
              listDrawerItem[index]['callBack']! as VoidCallback;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              selectedTileColor: context.colorScheme.secondary,
              horizontalTitleGap: 0,
              selected: isSelected,
              titleAlignment: ListTileTitleAlignment.center,
              leading: Image.asset(
                icon,
                alignment: Alignment.centerLeft,
                scale: 2,
              ),
              title: Text(
                title,
                style: TextStyle(color: textColor),
              ),
              onTap: callBack,
            ),
          );
        },
        itemCount: listDrawerItem.length);
  }
}
