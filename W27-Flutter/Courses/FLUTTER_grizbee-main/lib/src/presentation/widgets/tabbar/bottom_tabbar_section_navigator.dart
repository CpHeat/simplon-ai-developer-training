import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_details_page.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_page.dart';
import 'package:grizbee/src/presentation/pages/activity/activity_similar_page.dart';
import 'package:grizbee/src/presentation/pages/info/info_page.dart';
import 'package:grizbee/src/presentation/pages/more/more_page.dart';
import 'package:grizbee/src/presentation/pages/payment/fund_payment_page.dart';
import 'package:grizbee/src/presentation/pages/scanner/scanner_page.dart';
import 'package:grizbee/src/presentation/pages/transfer/transfer_page.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/item.dart';

// Unique global keys for each navigator section of the tab bar (ie parent page keys)
final navigatorKeys = {
  Item.info: GlobalKey<NavigatorState>(),
  Item.scanner: GlobalKey<NavigatorState>(),
  Item.transfer: GlobalKey<NavigatorState>(),
  Item.more: GlobalKey<NavigatorState>(),
};

// All the route names of the app
class RouteName {
  static const String root = '/';
  static const String info = '/info';
  static const String scanner = '/scanner';
  static const String transfer = '/transfer';
  static const String more = '/more';
  static const String activity = '/activity';
  static const String activity_details = '/activity_details';
  static const String activity_similar = '/activity_similar';
  static const String funds_transfer = '/edit_fund_transfer';
}

// This widget aims to provide a specific Navigator for each tab/section of the tab bar
class BottomTabBarSectionNavigator extends StatelessWidget {
  BottomTabBarSectionNavigator({required this.navigatorKey, required this.item});

  final GlobalKey<NavigatorState> navigatorKey;
  final Item item;

  // Page route for each route
  MaterialPageRoute _getRoute(BuildContext context, RouteSettings routeSettings) {
    Widget rootPage;

    // Set root page according to the tab bar section
    switch (item) {
      case Item.info:
        rootPage = InfoPage();
        break;

      case Item.scanner:
        rootPage = ScannerPage();
        break;

      case Item.transfer:
        rootPage = TransferPage();
        break;

      case Item.more:
        rootPage = MorePage();
        break;
    }

    switch (routeSettings.name) {
      case RouteName.info:
        return MaterialPageRoute(builder: (context) => InfoPage());

      case RouteName.scanner:
        return MaterialPageRoute(builder: (context) => ScannerPage());

      case RouteName.transfer:
        return MaterialPageRoute(builder: (context) => TransferPage());

      case RouteName.more:
        return MaterialPageRoute(builder: (context) => MorePage());

      case RouteName.activity:
        return MaterialPageRoute(builder: (context) => ActivityPage());

      case RouteName.activity_details:
        return MaterialPageRoute(builder: (context) => ActivityDetailsPage(args: routeSettings.arguments as ActivityDetailsPageArguments));

      case RouteName.activity_similar:
        return MaterialPageRoute(builder: (context) => ActivitySimilarPage(args: routeSettings.arguments as ActivitySimilarPageArguments));

      case RouteName.funds_transfer:
        return MaterialPageRoute(builder: (context) => FundsTransferPage(args: routeSettings.arguments as FundTransferPageArguments));

      default:
        return MaterialPageRoute(
          builder: (context) => rootPage,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: RouteName.root,
      onGenerateRoute: (routeSettings) {
        return _getRoute(context, routeSettings);
      },
    );
  }
}
