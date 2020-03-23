library water_drop;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///Parameter of a single water drop
class WaterDropParam {
  ///Distance from the top of child
  final double top;

  ///Distance from the left of child
  final double left;

  ///Width of a water drop
  final double width;

  ///Height of a water drop
  final double height;

  WaterDropParam(
      {@required this.top,
      @required this.left,
      @required this.width,
      @required this.height})
      : assert(top != null),
        assert(left != null),
        assert(width != null && width > 0),
        assert(height != null && height > 0);
}

class WaterDrop extends StatelessWidget {
  ///Parameters of water drops. Each parameter represents one drop.
  final List<WaterDropParam> params;

  ///Child on which drops will be drawn.
  final Widget child;

  const WaterDrop({
    Key key,
    @required this.params,
    @required this.child,
  })  : assert(params != null),
        assert(child != null),
        super(key: key);

  ///A factory for creating a single drop
  factory WaterDrop.single(
          {Key key,
          double left,
          double top,
          double height,
          double width,
          Widget child}) =>
      WaterDrop(
        child: child,
        params: [
          WaterDropParam(top: top, left: left, width: width, height: height),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ...params.map((param) => _WaterDrop(
              child: child,
              left: param.left,
              top: param.top,
              width: param.width,
              height: param.height,
            )),
      ],
    );
  }
}

class _WaterDrop extends StatefulWidget {
  final double top;
  final double left;
  final double width;
  final double height;
  final Widget child;

  const _WaterDrop(
      {Key key, this.child, this.top, this.width, this.left, this.height})
      : super(key: key);

  @override
  __WaterDropState createState() => __WaterDropState();
}

class __WaterDropState extends State<_WaterDrop> {
  ///Size of a child widget. It is needed to provide correct gradient on the drop.
  Size totalSize;

  @override
  Widget build(BuildContext context) {
    //After build, rebuild it again but save the size of a widget (see [totalSize])
    if (totalSize == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() => totalSize = context.size);
      });
    }
    //If there's no totalSize, use size of the screen
    final size = totalSize ?? MediaQuery.of(context).size;

    //Alignment of center
    final alignment = getAlignment(size);

    //used for determining alignments for gradient
    final alignmentModifier = Alignment(
      widget.width / size.width,
      widget.height / size.height,
    );

    //A child with gradient on it for light illusion
    Widget childWithGradient = Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: alignment - alignmentModifier,
          end: alignment + alignmentModifier,
          colors: [Colors.black, Colors.white],
        ),
        backgroundBlendMode: BlendMode.overlay,
      ),
      child: widget.child,
    );

    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          _OvalShadow(
            width: widget.width,
            height: widget.height,
            top: widget.top,
            left: widget.left,
          ),
          ...List.generate(8, (i) {
            return Transform.scale(
              scale: 1 + 0.02 * i,
              alignment: alignment,
              child: ClipPath(
                clipper: OvalClipper(
                  center: center,
                  width: widget.width * (1 - 0.04 * i),
                  height: widget.height * (1 - 0.04 * i),
                ),
                clipBehavior: Clip.hardEdge,
                child: childWithGradient,
              ),
            );
          }),
          _LightDot(
            width: widget.width,
            height: widget.height,
            top: widget.top,
            left: widget.left,
          ),
        ],
      ),
    );
  }

  ///Get center of a drop
  Offset get center => Offset(
        widget.left + widget.width / 2,
        widget.top + widget.height / 2,
      );

  ///Map Center and Size to Alignment
  Alignment getAlignment(Size size) => Alignment(
        (center.dx - size.width / 2) / (size.width / 2),
        (center.dy - size.height / 2) / (size.height / 2),
      );
}

class OvalClipper extends CustomClipper<Path> {
  final double height;
  final double width;
  final Offset center;

  OvalClipper({this.center, this.width, this.height});

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addOval(Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      ));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

///A white dot in top left corner
class _LightDot extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final double height;

  const _LightDot({Key key, this.top, this.left, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left + width / 4,
      top: top + height / 4,
      child: SizedBox(
        width: width / 4,
        height: height / 4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.white.withOpacity(0.9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///A shadow below the drop
class _OvalShadow extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final double height;

  const _OvalShadow({Key key, this.top, this.left, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.elliptical(width / 2, height / 2),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(4, 4),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
