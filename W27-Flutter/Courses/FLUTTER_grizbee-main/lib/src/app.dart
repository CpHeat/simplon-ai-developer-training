import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grizbee/src/presentation/blocs/balance/balance_bloc.dart';
import 'package:grizbee/src/presentation/blocs/contact/contact_bloc.dart';
import 'package:grizbee/src/presentation/blocs/scanner/scanner_bloc.dart';
import 'package:grizbee/src/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:grizbee/src/presentation/internationalization/translation_delegate.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/item.dart';

// This widget instantiate the app by :
// - setting up the theme
// - providing all required blocs (MultiBlocProvider)
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        splashColor: Colors.transparent, // Disable default widget splash effect
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFff5252)), // Disable default widget splash effect
      ),
      localizationsDelegates: [
        TranslationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
      ],
      // Provide all the blocs needed in the children widget
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ScannerBloc>(
            create: (BuildContext context) => ScannerBloc(),
          ),
          BlocProvider<TransactionBloc>(
            create: (BuildContext context) => TransactionBloc(),
          ),
          BlocProvider<TransactionContactBloc>(
            create: (BuildContext context) => TransactionContactBloc(),
          ),
          BlocProvider<TransactionPaymentBloc>(
            create: (BuildContext context) => TransactionPaymentBloc(),
          ),
          BlocProvider<BalanceBloc>(
            create: (BuildContext context) => BalanceBloc(),
          ),
          BlocProvider<ContactBloc>(
            create: (BuildContext context) => ContactBloc(),
          ),
        ],
        child: _AppContent(),
      ),
    );
  }
}

// This widget aims to draw the initial shape of the app by :
// - setting up the tab bar (bottomNavigationBar)
// - setting up the content for each section of the tab bar. We use Stack here in order to keep state
class _AppContent extends StatefulWidget {
  @override
  _AppContentState createState() => _AppContentState();
}

class _AppContentState extends State<_AppContent> {
  var _currentTab = Item.info;

  @override
  Widget build(BuildContext context) {
    // WillPopScope allows us to override Android back button effects
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != Item.info) {
            _selectTab(Item.info);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // Create all tab bar sections in an unique stack, display only the section corresponding to clicked tab item
        // Using stack allows all our navigators preserve their state as they remain inside the widget tree
        body: Stack(
          children: <Widget>[
            BottomTabBarSection(item: Item.info, currentItem: _currentTab),
            BottomTabBarSection(item: Item.scanner, currentItem: _currentTab),
            BottomTabBarSection(item: Item.transfer, currentItem: _currentTab),
            BottomTabBarSection(item: Item.more, currentItem: _currentTab),
          ],
        ),
        bottomNavigationBar: BottomTabBar(
          currentItem: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  // Handle tab selection
  void _selectTab(Item item) {
    // If we click twice on the current tab
    if (item == _currentTab) {
      // Go to the root page of the section by popping all pages
      navigatorKeys[item]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      // Retains the selected tab
      setState(() => _currentTab = item);
    }
  }
}
