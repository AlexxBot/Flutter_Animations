import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 500);

class ExpansionTileWidget extends StatefulWidget {
  //final Widget? leading;
  final Widget title;
  //final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? callback;
  final List<Widget> children;
  //final Color backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool maintainState;

  const ExpansionTileWidget(
      {Key? key,
      /* this.leading, */ required this.title,
      /* this.subtitle, */ this.onExpansionChanged,
      this.callback,
      required this.children,
      this.trailing,
      this.initiallyExpanded = false,
      this.maintainState = false})
      : super(key: key);

  @override
  _ExpansionTileWidgetState createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late bool _isExpanded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }

      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = /* _borderColor.value ?? */ Colors
        .transparent;

    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              top: BorderSide(color: borderSideColor),
              bottom: BorderSide(color: borderSideColor))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTileTheme.merge(
            child: ListTile(
              onTap: _handleTap,
              trailing: InkWell(
                child: widget.trailing,
                onTap: () {
                  if (_isExpanded) {
                    widget.callback!;
                    _handleTap();
                  }
                },
              ),
              title: widget.title,
            ),
          ),
          ClipRect(child: Align(alignment: Alignment.center, child: child))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      child: TickerMode(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
        enabled: !closed,
      ),
      offstage: closed,
    );
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: shouldRemoveChildren ? null : result);
  }
}
