import 'package:flutter/material.dart';
import 'package:tabbed_view/src/icon_provider.dart';
import 'package:tabbed_view/src/theme/tab_theme_data.dart';
import 'package:tabbed_view/src/theme/tabs_area_theme_data.dart';

/// The [TabbedView] theme.
/// Defines the configuration of the overall visual [Theme] for a widget subtree within the app.
class TabbedViewThemeData {
  TabbedViewThemeData({
    TabsAreaThemeData? tabsArea,
    TabThemeData? tab,
  })  : tab = tab ?? TabThemeData(),
        tabsArea = tabsArea ?? TabsAreaThemeData();

  TabsAreaThemeData tabsArea;
  TabThemeData tab;

  /// Sets the Material Design icons.
  void materialDesignIcons() {
    tabsArea.menuIcon = IconProvider.data(Icons.arrow_drop_down);
    tab.closeIcon = IconProvider.data(Icons.close);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabbedViewThemeData &&
          runtimeType == other.runtimeType &&
          tabsArea == other.tabsArea &&
          tab == other.tab;

  @override
  int get hashCode => tabsArea.hashCode ^ tab.hashCode;
}
