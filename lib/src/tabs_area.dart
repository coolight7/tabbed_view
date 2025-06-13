import 'package:flutter/material.dart';
import 'package:tabbed_view/src/internal/tabbed_view_provider.dart';
import 'package:tabbed_view/src/internal/tabs_area/hidden_tabs.dart';
import 'package:tabbed_view/src/internal/tabs_area/tabs_area_corner.dart';
import 'package:tabbed_view/src/tab_status.dart';
import 'package:tabbed_view/src/tab_widget.dart';
import 'package:tabbed_view/src/tabbed_view_controller.dart';
import 'package:tabbed_view/src/tabs_area_layout.dart';
import 'package:tabbed_view/src/theme/theme_widget.dart';

/// Widget for the tabs and buttons.
class TabsArea extends StatefulWidget {
  const TabsArea({
    super.key,
    required this.provider,
    required this.buildTabBar,
    required this.buildTabItem,
  });

  final TabbedViewProvider provider;
  final Widget Function(Widget)? buildTabBar;
  final Widget Function(
    int index,
    Widget item,
    TabStatus status,
  )? buildTabItem;

  @override
  State<StatefulWidget> createState() => _TabsAreaState();
}

/// The [TabsArea] state.
class _TabsAreaState extends State<TabsArea> {
  int? _highlightedIndex;

  final HiddenTabs _hiddenTabs = HiddenTabs();

  @override
  Widget build(BuildContext context) {
    TabbedViewController controller = widget.provider.controller;
    List<Widget> children = [];
    for (int index = 0; index < controller.tabs.length; index++) {
      TabStatus status = _getStatusFor(index);
      final item = TabWidget(
        key: controller.tabs[index].uniqueKey,
        index: index,
        status: status,
        provider: widget.provider,
        updateHighlightedIndex: _updateHighlightedIndex,
        onClose: _onTabClose,
      );
      children.add(widget.buildTabItem?.call(
            index,
            item,
            status,
          ) ??
          item);
    }

    children.add(TabsAreaCorner(
      provider: widget.provider,
      hiddenTabs: _hiddenTabs,
    ));

    final reWidget = TabsAreaLayout(
      theme: TabbedViewTheme.of(context),
      hiddenTabs: _hiddenTabs,
      selectedTabIndex: controller.selectedIndex,
      children: children,
    );
    return widget.buildTabBar?.call(reWidget) ?? reWidget;
  }

  /// Gets the status of the tab for a given index.
  TabStatus _getStatusFor(int tabIndex) {
    TabbedViewController controller = widget.provider.controller;
    if (controller.tabs.isEmpty || tabIndex >= controller.tabs.length) {
      throw Exception('Invalid tab index: $tabIndex');
    }

    if (controller.selectedIndex != null &&
        controller.selectedIndex == tabIndex) {
      return TabStatus.selected;
    } else if (_highlightedIndex != null && _highlightedIndex == tabIndex) {
      return TabStatus.highlighted;
    }
    return TabStatus.normal;
  }

  void _updateHighlightedIndex(int? tabIndex) {
    if (_highlightedIndex != tabIndex) {
      setState(() {
        _highlightedIndex = tabIndex;
      });
    }
  }

  void _onTabClose() {
    setState(() {
      _highlightedIndex = null;
    });
  }
}
