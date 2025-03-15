import 'package:flutter/material.dart';
import 'package:planza/core/constants/dummy_data.dart';

import 'chart_slice.dart';

class ChartColumn extends StatelessWidget {
  const ChartColumn({
    super.key,
    required this.height,
    required this.width,
    required this.text,
  });

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              dummyGoals.length,
              (index) {
                int goalTaskCount = dummyGoals[index].tasks.isEmpty
                    ? 1
                    : dummyGoals[index].tasks.length;

                int totalTask = totalTaskCount == 0 ? 1 : totalTaskCount;

                double columnHeight =
                    (height * goalTaskCount) / (totalTask + 0);

                return ChartSlice(
                  color: dummyGoals[index].color,
                  height: columnHeight,
                  bottomRadius: index == dummyGoals.length - 1,
                  topRadius: index == 0,
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
