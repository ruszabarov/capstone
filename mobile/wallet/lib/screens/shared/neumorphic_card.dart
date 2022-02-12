import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCard extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  const NeumorphicCard(this.child, this.onPressed);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        color: Colors.grey[200],
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
      ),
      padding: EdgeInsets.all(20),
      onPressed: () {
        widget.onPressed();
      },
      child: widget.child,
    );
  }
}
