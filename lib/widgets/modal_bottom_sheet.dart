import 'package:flutter/material.dart';
import 'package:yuso_transport_test_app/app/app.dart';

class ModalBottomSheet extends StatelessWidget {
  final double height;
  final double topCircular;
  final double width;
  final String title;
  final Widget content;
  const ModalBottomSheet({
    Key? key,
    required this.content,
    required this.title,
    this.height = 160,
    this.topCircular = 10,
    this.width = double.infinity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(topCircular)),
      ),
      width: width,
      height: height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  title,
                  style: StylesHelpers.w600(18),
                  textAlign: TextAlign.left,
                ),
                content,
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppConstants.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
