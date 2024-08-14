import 'package:amp/utils/global_values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../global_theme/horizontalbar.dart';
import '../providers_vm/generateOtp_provider.dart';
import '../routes/route_names.dart';
import '../utils/app_colors.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:syncfusion_flutter_charts/charts.dart' as syncfusion_charts;
import '../utils/carousal_items.dart';
import '../utils/status_data.dart';
import '../utils/strings.dart';
import 'notification_screen.dart';

class CM_DashboardScreen extends StatelessWidget {
  const CM_DashboardScreen({super.key});

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> data = [
      ChartData('Emmm', 20,""),
      ChartData('ERB Consumer', 30,""),
      ChartData('ERB Consumer', 30,""),
    ];

    final List<BarChartData> barChart = [
      BarChartData('<1', 500, 2, 3, 3),
      BarChartData('<6', 750, 2, 3, 3),
      BarChartData('1-3', 900, 2, 3, 3),
      BarChartData('3-6', 1250, 2, 3, 3),
    ];

    final List<NChartData> ndata = [
      NChartData('# of Completed Audits - 25', 60),
      NChartData('# of ERB-CC  - 15', 20),
      NChartData('# of ERB-TC - 15', 10),
      NChartData('# of STOCK - 10', 10),
    ];

    List<_ChartData>? topPerforming = <_ChartData>[
      _ChartData('S1', 21, 28),
      _ChartData('s2', 24, 44),
      _ChartData('s3', 36, 48),
      _ChartData('s4', 38, 50),
      _ChartData('s5', 54, 66),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildSmallScreenLayout(
              context, data, ndata, barChart, topPerforming, chartData,chartData2);
        } else {
          return _buildLargeScreenLayout(context, data);
        }
      },
    );
  }





  Widget _buildSmallScreenLayout(
      BuildContext context,
      List<ChartData> data,
      List<NChartData> ndata,
      List<BarChartData> barData,
      List<_ChartData> topPerforming,
      List<ChartData1> chartData,
      List<ChartData2> chartData2,
      ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.meruWhite,
        leading: Container(
          width: 60,  // Set your desired width
          height: 60, // Set your desired height
          child: IconButton(
            icon: Image.asset("assets/images/menu_logo.png"),
            iconSize: 40, // Set the size of the IconButton
            onPressed: () => Navigator.pop(context), // Handle back button press
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildSmallScreenBody(context, data, ndata, barData, chartData,chartData2),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildSmallScreenBody(
      BuildContext context,
      List<ChartData> data,
      List<NChartData> ndata,
      List<BarChartData> barData,
      List<ChartData1> charData,
      List<ChartData2> charData2
      ) {

    return SingleChildScrollView(
      child: Container(
        color: AppColors.merudashBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FloatingActionButton(
              heroTag: 'uniqueTag', onPressed: () {

            },
            ),

            SizedBox(
              height: 27.0,
            ),


            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Text(
                'Hello, ' + AppStrings.profileName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.meruBlack,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Text(
                AppStrings.welcomeMessage,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruBlack,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(
              height: 17.0,
            ),

            //audit score
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                      15), // Ensures the gradient follows the card's rounded corners
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        15), // Keeps the padding inside the gradient
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.auditScore,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              AppStrings.auditScoreText,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                            SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  radiusFactor: 0.6,
                                  interval: 20,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: -10,
                                        endValue: 20,
                                        startWidth: 25,
                                        endWidth: 25,
                                        color: Colors.red),
                                    GaugeRange(
                                        startValue: 20,
                                        endValue: 40,
                                        startWidth: 25,
                                        endWidth: 25,
                                        color: Colors.orange),
                                    GaugeRange(
                                        startValue: 40,
                                        endValue: 60,
                                        startWidth: 25,
                                        endWidth: 25,
                                        color: Colors.yellow),
                                    GaugeRange(
                                        startValue: 60,
                                        endValue: 80,
                                        startWidth: 25,
                                        endWidth: 25,
                                        color: Colors.greenAccent),
                                    GaugeRange(
                                        startValue: 80,
                                        endValue: 100,
                                        startWidth: 25,
                                        endWidth: 25,
                                        color: Colors.green),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(value: 70)
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '\n\n\n\nAverage Score : 70\nAverage Grade : Fair',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                letterSpacing: 2,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        angle: 90,
                                        positionFactor: 0.9)
                                  ])
                            ]),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routenames.otpScreen);
                                },
                                child: Text(
                                  AppStrings.clickAuditScore,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.meruBlack,
                                    fontSize: 12.0,
                                    letterSpacing: 1,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //upcoming
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.upcomingAudits,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        AppStrings.txtUpcomingAudits,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.meruBlack,
                          fontSize: 10.0,
                          letterSpacing: 1,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "You have 4 upcoming audits in the next 20 days.",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routenames.ERBScreen);
                          },
                          child: Text(
                            AppStrings.clickUpcomingAudits,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //completed & NC
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.fromLTRB(16, 4, 2, 8),
                    // SmallerF margin for mobile
                    child: Container(
                      height: 450,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Smaller padding for mobile
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.completedAudits,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              AppStrings.txtCompletedAudits,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: pie_chart.PieChart(
                                        dataMap: ndata.asMap().map(
                                            (index, chartData) => MapEntry(
                                                chartData.title,
                                                chartData.value.toDouble())),
                                        chartRadius:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        // Adjust radius for mobile
                                        legendOptions:
                                            const pie_chart.LegendOptions(
                                          showLegendsInRow: false,
                                          legendPosition:
                                              pie_chart.LegendPosition.bottom,
                                          // Legend at the bottom
                                          showLegends: true,
                                        ),
                                        chartValuesOptions:
                                            const pie_chart.ChartValuesOptions(
                                          showChartValueBackground: false,
                                          showChartValues: false,
                                          showChartValuesInPercentage: false,
                                          showChartValuesOutside: false,
                                          decimalPlaces: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routenames.splashScreen);
                                },
                                child: Text(
                                  AppStrings.clickCompletedAudits,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.meruBlack,
                                    fontSize: 10.0,
                                    // Smaller font size for mobile
                                    letterSpacing: 1,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.fromLTRB(1, 4, 16, 8),
                    child: Container(
                      height: 450,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        // Smaller padding for mobile
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.ncText,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              'Number of open NCs per month',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.meruBlack,
                                fontSize: 10.0,
                                letterSpacing: 1,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: [
                                StackedColumnSeries<BarChartData, String>(
                                  dataSource: barData,
                                  xValueMapper: (BarChartData br, _) =>
                                      br.x as String,
                                  yValueMapper: (BarChartData br, _) =>
                                      br.y1 as num,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routenames.splashScreen);
                                },
                                child: Text(
                                  AppStrings.clickNCText,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.meruBlack,
                                    fontSize: 10.0,
                                    // Smaller font size for mobile
                                    letterSpacing: 1,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Performing Station
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.fromLTRB(16, 2, 16, 2),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.PerformingStation,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text(
                        AppStrings.StaticPerformingStation,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.meruBlack,
                          fontSize: 10.0,
                          letterSpacing: 1,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "Top 3 Performing Stations",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    primaryYAxis: NumericAxis(
                                        minimum: 0, maximum: 100, interval: 20),
                                    series: <CartesianSeries<ChartData1, String>>[
                                      BarSeries<ChartData1, String>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData1 data, _) =>
                                            data.x ?? '',
                                        yValueMapper: (ChartData1 data, _) =>
                                            data.y ?? 0,
                                        name: 'Gold',
                                        color: Colors.cyan,
                                        width: 0.2,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // here here
                              Text(
                                "Bottom 3 Performing Stations",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    primaryYAxis: NumericAxis(
                                        minimum: 0, maximum: 100, interval: 20),
                                    series: <CartesianSeries<ChartData1, String>>[
                                      BarSeries<ChartData1, String>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData1 data, _) =>
                                        data.x ?? '',
                                        yValueMapper: (ChartData1 data, _) =>
                                        data.y ?? 0,
                                        name: 'Gold',
                                        color: Colors.redAccent,
                                        width: 0.2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routenames.loginScreen);
                          },
                          child: Text(
                            AppStrings.clickUpcomingAudits,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: AppColors.meruBlack,
                              fontSize: 12.0,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            Center(
              child: Text(
                ' © MERU AUDIT PLATFORM 2024 ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                  fontSize: 11.0,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context, List<ChartData> data) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Audit Management Platform',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: AppColors.meruWhite,
              fontSize: 14.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.meruRed,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: 0,
            onDestinationSelected: (index) {
              String message;
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CM_DashboardScreen()),
                  );
                  break;
                case 1:
                  // message = "Profile tapped";
                  //add map here
                  break;
                case 3:
                  // message = "Profile tapped";

                  break;
                case 2:
                  // message = "Notifications tapped";
                  final List<NotificationItem> notifications = [
                    NotificationItem(
                      title: 'New Order Received',
                      content: 'You have a new order #12345 from John Doe.',
                      dateTime:
                          DateTime.now().subtract(const Duration(hours: 2)),
                    ),
                    NotificationItem(
                      title: 'Reminder: Weekly Meeting',
                      content: 'Your weekly team meeting is today at 2 PM.',
                      dateTime:
                          DateTime.now().subtract(const Duration(days: 1)),
                    ),
                    NotificationItem(
                      title: 'App Update Available',
                      content:
                          'A new update for your app is available. Please update to enjoy the latest features.',
                      dateTime:
                          DateTime.now().subtract(const Duration(days: 3)),
                      isNew: true,
                    ),
                  ];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                          notifications: notifications, currentIndex: index),
                    ),
                  );
                  break;
                default:
                  message = "";
              }
              // showToast(message);
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey),
            selectedLabelTextStyle: TextStyle(color: Colors.blueGrey),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: Colors.blue),
                label: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_outlined, color: Colors.grey),
                label: Text(
                  'Stations',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person, color: Colors.grey),
                label: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications, color: Colors.grey),
                label: Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Joe Rogan',
                                    style: TextStyle(
                                      color: Color(0xFFC62828),
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Name : User',
                                    style: TextStyle(
                                      color: Color(0xFFC62828),
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/logo.jpeg'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PieChart(
                            dataMap: data.asMap().map((index, chartData) =>
                                MapEntry(chartData.title,
                                    chartData.value.toDouble())),
                            colorList: [
                              Colors.red,
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                            ],
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            legendOptions: const LegendOptions(
                              // legendPosition: LegendPosition.right,
                              showLegendsInRow: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildTopChecklistTable(),
                  const SizedBox(height: 20.0),
                  _buildChecklistUtilizationTable(),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Audits',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, Routenames.form);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.title),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Location Overview',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildLocationOverViewTable(),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        /*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuditLogin()),
                        );*/
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC62828),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Logout",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the TopChecklistTable
  Widget _buildTopChecklistTable() {
    // Implementation of your TopChecklistTable widget
    return Placeholder();
  }

  Widget buildStatusGraph(List<StatusData> data) {
    final chartData = data.map((item) => item.count).toList();
    final colorList = data.map((item) => item.color).toList();
    final legendLabels = data.map((item) => item.status).toList();

    return PieChart(
      dataMap: Map.fromIterable(
        data,
        key: (item) => item.status,
        value: (item) => item.count,
      ),
      animationDuration: Duration(milliseconds: 800),
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Status",
      legendOptions: LegendOptions(
        showLegends: true,
        // legendPosition: LegendPosition.right,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      colorList: colorList,
      chartLegendSpacing: 32,
      initialAngleInDegree: 0,
      // legendLabels: legendLabels,
    );
  }

  // Function to build the ChecklistUtilizationTable
  Widget _buildChecklistUtilizationTable() {
    // Implementation of your ChecklistUtilizationTable widget
    return Placeholder();
  }

  // Function to build the LocationOverViewTable
  Widget _buildLocationOverViewTable() {
    // Implementation of your LocationOverViewTable widget
    return Placeholder();
  }

  Widget _buildExpandableCard(
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruBlack,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        trailing: Icon(Icons.expand_more),
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruBlack,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
            ),
          ),
          Flexible(
              child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruBlack,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
            ),
          )),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CM_DashboardScreen()),
            );
            break;
          case 1:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Location Service running. Background thread.')),
            );
            break;
          case 2:
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ProfileScreen(currentIndex: index)),
            // );
            break;
          case 3:
            final List<NotificationItem> notifications = [
              NotificationItem(
                title: 'New Order Received',
                content: 'You have a new order #12345 from John Doe.',
                dateTime: DateTime.now().subtract(const Duration(hours: 2)),
              ),
              NotificationItem(
                title: 'Reminder: Weekly Meeting',
                content: 'Your weekly team meeting is today at 2 PM.',
                dateTime: DateTime.now().subtract(const Duration(days: 1)),
              ),
              NotificationItem(
                title: 'App Update Available',
                content:
                    'A new update for your app is available. Please update to enjoy the latest features.',
                dateTime: DateTime.now().subtract(const Duration(days: 3)),
                isNew: true,
              ),
            ];
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(
                    notifications: notifications, currentIndex: index),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Stations',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.black),
      ],
      selectedIconTheme: const IconThemeData(
        color: Colors.blue,
      ),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 11.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 11.0,
      ),
    );
  }
}

class BarChartData {
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;

  BarChartData(this.x, this.y1, this.y2, this.y3, this.y4);
}

class ChartData {
  final String title;
  final int value;
  final String title2;

  ChartData(this.title, this.value,this.title2);
}

GlobalVariables globalVariables = GlobalVariables();
final chartData = [
  ChartData1(globalVariables.topStationList[0].stationCode, globalVariables.topStationList[0].avgScore),
  ChartData1(globalVariables.topStationList[1].stationCode, globalVariables.topStationList[1].avgScore),
  ChartData1(globalVariables.topStationList[2].stationCode, globalVariables.topStationList[2].avgScore),

];




final chartData2 = [
  ChartData2('s9', 35),
  ChartData2('s5', 55),
  ChartData2('s6', 75),
];

class TopPerformingData {
  final String title;
  final int value;

  TopPerformingData(this.title, this.value);
}

final topPerformingData = [
  TopPerformingData('s7', 65),
  TopPerformingData('s6', 80),
  TopPerformingData('s5', 40),
];

class NChartData {
  final String title;
  final int value;

  NChartData(this.title, this.value);
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final String x;
  final double y;
  final double y2;
}

class _BarChartProvider extends ChangeNotifier {
  List<_ChartData>? chartData = <_ChartData>[
    _ChartData('Mon', 21, 28),
    _ChartData('Tus', 24, 44),
    _ChartData('Wen', 36, 48),
    _ChartData('Thr', 38, 50),
    _ChartData('Fri', 54, 66),
    _ChartData('Sat', 57, 78),
    _ChartData('Sun', 70, 84)
  ];

  void init() {}

  @override
  void dispose() {
    chartData?.clear();
    super.dispose();
  }
}
