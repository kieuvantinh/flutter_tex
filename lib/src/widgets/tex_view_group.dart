import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:flutter_tex/src/models/tex_view_widget_meta.dart';
import 'package:flutter_tex/src/utils/style_utils.dart';

class TeXViewGroup extends TeXViewWidget {
  final String id;

  /// A list of [TeXViewWidget].
  final List<TeXViewGroupItem> children;

  /// On Tap Callback when a child is tapped.
  final Function(String id) onTap;

  /// On Tap Callback when a child is tapped.
  final Function(List<String> ids) onItemsSelection;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle style;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle selectedItemStyle;

  /// Style TeXView Widget with [TeXViewStyle].
  final TeXViewStyle normalItemStyle;

  final bool single;

  final String lastSelectedId;

  final List<String> selectedIds;

  const TeXViewGroup(
      {this.id,
      @required this.children,
      @required this.onTap,
      this.lastSelectedId,
      this.selectedIds,
      this.style,
      this.selectedItemStyle,
      this.normalItemStyle})
      : onItemsSelection = null,
        single = true;

  const TeXViewGroup.multipleSelection(
      {this.id,
      @required this.children,
      @required this.onItemsSelection,
      this.lastSelectedId,
      this.selectedIds,
      this.style,
      this.selectedItemStyle,
      this.normalItemStyle})
      : onTap = null,
        single = false;

  @override
  TeXViewWidgetMeta meta() {
    return TeXViewWidgetMeta(
        tag: 'div', classList: 'tex-view-group', node: Node.InternalChildren);
  }

  @override
  void onTapManager(String id) {
    if (single) {
      for (TeXViewGroupItem child in this.children)
        if (child.id == id) this.onTap(id);
    } else {
      this.onItemsSelection((jsonDecode(id) as List<dynamic>).cast<String>());
    }
  }

  @override
  Map toJson() => {
        'meta': meta().toJson(),
        'data': this.children?.map((child) => child?.toJson())?.toList(),
        'lastSelectedId': this.lastSelectedId,
        'selectedIds': this.selectedIds,
        'single': this.single,
        'style': this.style?.initStyle() ?? teXViewDefaultStyle,
        'selectedItemStyle':
            this.selectedItemStyle?.initStyle() ?? teXViewDefaultStyle,
        'normalItemStyle':
            this.normalItemStyle?.initStyle() ?? teXViewDefaultStyle,
      };
}
