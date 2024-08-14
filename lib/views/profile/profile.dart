import 'package:amp/views/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../response/validateUserOtp.dart';
import '../../routes/route_names.dart';
import '../../utils/app_colors.dart';
import '../../utils/user_helper.dart';
import '../notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserResponse? user;
  String initials = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    UserResponse? userDetails = await UserDetailsHelper.getUserDetails();
    if (userDetails != null) {
      setState(() {
        user = userDetails;
        initials = UserDetailsHelper.getInitials(user!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildSmallScreenLayout(context);
        } else {
          return _buildLargeScreenLayout(context);
        }
      },
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text('Audit Management Platform',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: AppColors.meruWhite,
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                ))),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: 2,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, Routenames.dmDashboardScreen);
                  break;
                case 1:
                // Handle navigation to Stations
                  break;
                case 2:
                // Current screen (Profile)
                  break;
                case 3:
                // Handle navigation to Notifications
                  break;
              }
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey),
            selectedLabelTextStyle: TextStyle(color: Colors.blueGrey),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: Colors.grey),
                label: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 11.0,
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
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications, color: Colors.blue),
                label: Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: AppColors.meruBlack,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: user == null
                ? Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Name: ${user!.firstName} ${user!.lastName}'),
                  Text('Email: ${user!.email}'),
                  Text('Phone: ${user!.phone1}'),
                  Text('Designation: ${user!.designation}'),
                  SizedBox(height: 20),
                  Text(
                    'Initials: $initials',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          width: 60, // Set your desired width
          height: 60, // Set your desired height
          child: IconButton(
            icon: Image.asset("assets/images/menu_logo.png"),
            iconSize: 40, // Set the size of the IconButton
            onPressed: () => Navigator.pop(context), // Handle back button press
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red, // Background color of the circle
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$initials',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: user == null
            ? Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20),
            Text('Name: ${user!.firstName} ${user!.lastName}'),
            Text('Email: ${user!.email}'),
            Text('Phone: ${user!.phone1}'),
            Text('Designation: ${user!.designation}'),
            SizedBox(height: 20),
            Text(
              'Initials: $initials',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Adjust currentIndex as needed
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, Routenames.dmDashboardScreen);
              break;
            case 1:
            // Handle navigation to Stations
              break;
            case 2:
            // Current screen (Profile)
              break;
            case 3:
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
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Stations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),*/
    );
  }
}


