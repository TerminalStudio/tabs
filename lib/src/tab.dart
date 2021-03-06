import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tabs/src/layout/close_listener.dart';
import 'package:tabs/src/util/invisible.dart';

class TabController with ChangeNotifier {
  TabController();

  TabController._(this._title, this._content);

  String _title;

  Widget _content;

  String get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  Widget get content => _content;

  void setContent(Widget content) {
    _content = content;
    notifyListeners();
  }

  final closeRequest = ChangeNotifier();

  void requestClose() {
    closeRequest.notifyListeners();
  }

  TabController copy() {
    return TabController._(this._title, this._content);
  }
}

class Tab {
  Tab({
    this.title,
    this.controller,
    this.onClose,
    this.onActivate,
    this.onDrop,
  });

  final TabController controller;
  final String title;
  final void Function() onClose;
  final void Function() onActivate;
  final void Function() onDrop;

  Widget build(bool isActive, [bool isAccepting = false]) {
    return TabWidget(
      tab: this,
      isActive: isActive,
      isAccepting: isAccepting,
    );
  }

  Tab copy() {
    return Tab(
      title: title,
      controller: controller.copy(),
      onClose: onClose,
      onActivate: onActivate,
      onDrop: onDrop,
    );
  }
}

const _kInactiveTextColor = Color(0xFF8B8B8B);

class TabWidget extends StatefulWidget {
  TabWidget({
    this.tab,
    this.isActive,
    this.isAccepting,
  });

  final Tab tab;
  final bool isActive;
  final bool isAccepting;

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  var title = '';
  var hover = false;

  void onChange() {
    if (widget.tab.controller?.title != null) {
      setState(() {
        title = widget.tab.controller.title;
      });
    }
  }

  @override
  void initState() {
    title = widget.tab.controller?.title ?? widget.tab.title ?? title;
    widget.tab.controller?.addListener(onChange);
    widget.tab.controller.closeRequest?.addListener(close);
    super.initState();
  }

  @override
  void didUpdateWidget(TabWidget oldWidget) {
    title = widget.tab.controller?.title ?? widget.tab.title ?? title;
    oldWidget.tab.controller?.removeListener(onChange);
    oldWidget.tab.controller.closeRequest?.removeListener(close);
    widget.tab.controller?.addListener(onChange);
    widget.tab.controller.closeRequest?.addListener(close);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.tab.controller?.removeListener(onChange);
    widget.tab.controller.closeRequest?.removeListener(close);
    super.dispose();
  }

  void close() {
    CloseListener.of(context).close(widget.tab);
    widget.tab.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    if (widget.isAccepting) {
      decoration = BoxDecoration(
        color: Color(0xFF5A5A5A),
      );
    } else if (widget.isActive) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3C3F41), Color(0xFF36383A)],
        ),
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.transparent,
      );
    }

    final textColor = widget.isActive ? Colors.white : _kInactiveTextColor;

    final content = Center(
      child: Text(
        title,
        style: TextStyle(color: textColor),
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
    );

    return MouseRegion(
      onEnter: (_) {
        if (!mounted) return;
        setState(() => hover = true);
      },
      onExit: (_) {
        if (!mounted) return;
        setState(() => hover = false);
      },
      child: Container(
        height: double.infinity,
        decoration: decoration,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Invisible(
              visible: hover || widget.isActive,
              child: _CloseButton(onClick: close),
            ),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  _CloseButton({this.onClick});

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: EdgeInsets.only(left: 6, right: 6, bottom: 3),
          child: Icon(
            CupertinoIcons.clear_thick,
            color: _kInactiveTextColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
