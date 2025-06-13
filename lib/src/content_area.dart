import 'package:flutter/material.dart';
import 'package:tabbed_view/src/internal/tabbed_view_provider.dart';
import 'package:tabbed_view/src/tabbed_view_controller.dart';

/// Container widget for the tab content and menu.
class ContentArea extends StatelessWidget {
  const ContentArea({super.key, required this.provider});

  final TabbedViewProvider provider;

  @override
  Widget build(BuildContext context) {
    TabbedViewController controller = provider.controller;

    List<Widget> children = [];

    for (int i = 0; i < controller.tabs.length; i++) {
      final tab = controller.tabs[i];
      bool selectedTab = (i == controller.selectedIndex);
      if (tab.keepAlive || selectedTab) {
        Widget? child;
        if (provider.contentBuilder != null) {
          child = provider.contentBuilder!(context, i);
        } else {
          child = tab.content;
        }
        if (child != null) {
          child = ExcludeFocus(excluding: !selectedTab, child: child);
        }
        if (tab.keepAlive) {
          child = Offstage(offstage: !selectedTab, child: child);
        }
        children.add(
          Positioned.fill(key: tab.key, child: child ?? const SizedBox()),
        );
      }
    }

    final content = Stack(children: children);
    if (provider.contentClip) {
      return ClipRect(child: content);
    }
    return content;
  }
}
