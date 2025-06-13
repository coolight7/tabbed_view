import 'package:flutter/widgets.dart';
import 'package:tabbed_view/src/icon_provider.dart';
import 'package:tabbed_view/src/theme/tabbed_view_theme_constants.dart';

/// Configures a tab button.
class TabButton {
  TabButton(
      {required this.icon,
      this.color,
      this.hoverColor,
      this.disabledColor,
      this.background,
      this.hoverBackground,
      this.disabledBackground,
      this.onPressed,
      this.toolTip,
      this.padding,
      double? iconSize})
      : iconSize = iconSize == null
            ? iconSize
            : TabbedViewThemeConstants.normalize(iconSize);

  final IconProvider icon;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? hoverColor;
  final Color? disabledColor;
  final BoxDecoration? background;
  final BoxDecoration? hoverBackground;
  final BoxDecoration? disabledBackground;
  final VoidCallback? onPressed;
  final String? toolTip;
  final double? iconSize;
}
