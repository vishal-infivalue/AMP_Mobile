import 'package:amp/views/dashboard_screen.dart';
import 'package:amp/views/login/audit_login.dart';
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
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.blue,
                    child: Text(
                      "$initials",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('Name: ${user!.firstName} ${user!.lastName}'),
                  Text('Email: ${user!.email}'),
                  Text('Phone: ${user!.phone1}'),
                  Text('Designation: ${user!.designation}'),
                  SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    bool _showLoadingSubmit = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.meruWhite,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white), // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: user == null
            ? Center(child: CircularProgressIndicator())
            : Center(  // Center the entire content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              // Profile circular avatar with initials
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.red,
                child: Text(
                  '$initials',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Profile details
              Text(
                "Name : ${user!.firstName} ${user!.lastName}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'User Id : ${user!.id}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Email : ${user!.email}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Phone : ${user!.phone1}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Designation : ${user!.designation}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700],
                ),
              ),

              SizedBox(height: 120.0),

              // Logout button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.meruRed,
                  foregroundColor: AppColors.meruWhite,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                label: _showLoadingSubmit
                    ? CircularProgressIndicator(
                  color: AppColors.meruYellow,
                  strokeWidth: 1.0,
                )
                    : Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    color: AppColors.meruWhite,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _showLoadingSubmit = true;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuditLogin(args: {},)), // Replace with your new route
                        (route) => false, // This condition removes all routes
                  );
                  setState(() {
                    _showLoadingSubmit = false;
                  });
                },
              ),
              SizedBox(height: 20.0),

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
            ],
          ),
        ),
      ),
    );
  }


/* Widget _buildSmallScreenLayout(BuildContext context) {
    bool _showLoadingSubmit = false;
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Profile',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: AppColors.meruWhite,
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
            )
        ),
        backgroundColor: AppColors.meruRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_sharp, color: Colors.white), // Blue icon
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: user == null
            ? Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer to push content towards the top
            Spacer(flex: 2),

            // Profile circular avatar with initials
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.red,
              child: Text(
                '$initials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Profile details
            Text(
              "Name : ${user!.firstName} ${user!.lastName}",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
            Text(
              'User Id : ${user!.id}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Email : ${user!.email}",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Phone : ${user!.phone1}",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Designation : ${user!.designation}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[700],
              ),
            ),


            // Spacer to push content upwards
            Spacer(flex: 3),

            // Logout button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.meruRed,
                foregroundColor: AppColors.meruWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              label: _showLoadingSubmit
                  ? CircularProgressIndicator(
                color: AppColors.meruYellow,
                strokeWidth: 1.0,
              )
                  : Text(
                "Logout",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: AppColors.meruWhite,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _showLoadingSubmit = true;
                });
                await Future.delayed(const Duration(seconds: 2));
                Navigator.pushNamed(
                    context, Routenames.witnessSignature);
                setState(() {
                  _showLoadingSubmit = false;
                });
              },
            ),

            // Spacer to adjust the overall layout
            Spacer(flex: 2),
          ],
        )
        *//*Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


        SizedBox(height: 20),
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: Text(
                "$initials",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
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
            ElevatedButton(
              onPressed: () {
                // Handle logout action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),*//*
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }*/
}



/*class ProfileScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular design with initials
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: Text(
                'EP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Profile details
            Text(
              'Name: Esau Phiri',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: vishal.v@infini.com',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Phone: 2600020020',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Designation: Cluster Manager',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[700],
              ),
            ),
            Spacer(),
            // Logout button
            ElevatedButton(
              onPressed: () {
                // Handle logout action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


