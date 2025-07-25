import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tabbed_view/src/internal/tabs_area/hidden_tabs.dart';
import 'package:tabbed_view/src/internal/tabbed_view_provider.dart';
import 'package:tabbed_view/src/tab_button.dart';
import 'package:tabbed_view/src/tab_button_widget.dart';
import 'package:tabbed_view/src/theme/tabbed_view_theme_data.dart';
import 'package:tabbed_view/src/theme/tabs_area_theme_data.dart';
import 'package:tabbed_view/src/theme/theme_widget.dart';

/// Area for buttons like the hidden tabs menu button.
@internal
class TabsAreaButtonsWidget extends StatelessWidget {
  final TabbedViewProvider provider;
  final HiddenTabs hiddenTabs;

  const TabsAreaButtonsWidget(
      {super.key, required this.provider, required this.hiddenTabs});

  @override
  Widget build(BuildContext context) {
    final TabbedViewThemeData theme = TabbedViewTheme.of(context);
    final TabsAreaThemeData tabsAreaTheme = theme.tabsArea;

    List<TabButton> buttons = [];
    if (provider.tabsAreaButtonsBuilder != null) {
      buttons = provider.tabsAreaButtonsBuilder!(
          context, provider.controller.tabs.length);
    }

    List<Widget> children = [];

    for (int i = 0; i < buttons.length; i++) {
      EdgeInsets? padding;
      if (i > 0 && tabsAreaTheme.buttonsGap > 0) {
        padding = EdgeInsets.only(left: tabsAreaTheme.buttonsGap);
      }
      final TabButton tabButton = buttons[i];
      children.add(Container(
          padding: padding,
          child: TabButtonWidget(
              provider: provider,
              button: tabButton,
              enabled: provider.draggingTabIndex == null,
              normalColor: tabsAreaTheme.normalButtonColor,
              hoverColor: tabsAreaTheme.hoverButtonColor,
              disabledColor: tabsAreaTheme.disabledButtonColor,
              normalBackground: tabsAreaTheme.normalButtonBackground,
              hoverBackground: tabsAreaTheme.hoverButtonBackground,
              disabledBackground: tabsAreaTheme.disabledButtonBackground,
              iconSize: tabButton.iconSize != null
                  ? tabButton.iconSize!
                  : tabsAreaTheme.buttonIconSize,
              themePadding: tabsAreaTheme.buttonPadding)));
    }

    Widget buttonsArea = Row(children: children);

    EdgeInsetsGeometry? margin;
    if (tabsAreaTheme.buttonsOffset > 0) {
      margin = EdgeInsets.only(left: tabsAreaTheme.buttonsOffset);
    }

    if (children.isNotEmpty &&
        (tabsAreaTheme.buttonsAreaDecoration != null ||
            tabsAreaTheme.buttonsAreaPadding != null ||
            margin != null)) {
      buttonsArea = Container(
          decoration: tabsAreaTheme.buttonsAreaDecoration,
          padding: tabsAreaTheme.buttonsAreaPadding,
          margin: margin,
          child: buttonsArea);
    }
    return buttonsArea;
  }
}
