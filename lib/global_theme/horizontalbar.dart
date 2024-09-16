import 'package:flutter/material.dart';

class HorizontalBarChartCard extends StatelessWidget {
  final String title;
  final List<ChartData1> data;
  final double barWidth;
  final double barSpacing;

  const HorizontalBarChartCard({
    Key? key,
    required this.title,
    required this.data,
    this.barWidth = 1,
    this.barSpacing = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),

            // Horizontal Bar Chart
            Row(
              children: [
                // Labels (optional)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Text(
                        '',
                        style: const TextStyle(fontSize: 12.0),
                      );
                    },
                  ),
                ),

                // Bars
                SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: Row(
                    children: [
                      for (final item in data)
                        SizedBox(
                          width: barWidth,
                        ),
                      const Spacer(), // Add spacer for better layout
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            HorizontalBarChartCard(
              title: 'Audit Score Breakdown',
              data: data,
            ),

            // Values (optional)
            Row(
              children: [
                const Expanded(child: SizedBox()),
                for (final item in data)
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class ChartData1 {

  ChartData1(this.x, this.y);

  final String x;
  final double y;
}


class ChartData2 {
  ChartData2(this.x, this.y);

  final String x;
  final double y;
}

