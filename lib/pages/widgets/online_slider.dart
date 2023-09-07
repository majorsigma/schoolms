import 'package:flutter/material.dart';
import 'package:schoolms/utils/schoolms_colors.dart';

class OnlineSlider extends StatefulWidget {
  const OnlineSlider({super.key});

  @override
  State<OnlineSlider> createState() => _OnlineSliderState();
}

class _OnlineSliderState extends State<OnlineSlider> {
  double _left = 0.0;
  bool _isOnline = false;

  final _dragContainerKey = GlobalKey();

  late Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _dragContainerKey,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
        color: SchoolMsColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            _isOnline == true ? "Slide to go offline" : "Slide to go online",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            left: _left,
            top: 0,
            child: GestureDetector(
              onPanStart: (details) {
                final RenderBox renderBox = _dragContainerKey.currentContext
                    ?.findRenderObject() as RenderBox;
                final size = renderBox.size;
                setState(() {
                  _size = size;
                });
              },
              onPanUpdate: (details) {
                if (_left < _size.width * .50) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                } else {
                  setState(() {
                    _left = 0;
                    _isOnline = !_isOnline;
                  });
                  return;
                }
              },
              child: Container(
                key: const Key("dragIcon"),
                width: 30,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.keyboard_double_arrow_right,
                  size: 24,
                  color: SchoolMsColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
