import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final int dotCount;

  const DottedDivider({
    super.key,
    this.height = 1.5,
    this.color,
    this.dotCount = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        dotCount,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 
                ? Colors.transparent 
                : (color ?? AppColors.border),
            height: height,
          ),
        ),
      ),
    );
  }
}
