import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'buddies.dart';
import 'buddies.dart';
import 'checkout.dart';
import 'login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BodyAllPages extends StatelessWidget {
  const BodyAllPages({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      onLongPress: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: Text(
              'Please log in',
              style: GoogleFonts.comfortaa(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingAllpages extends StatelessWidget {
  const LoadingAllpages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}
// class InvitationsPage extends StatelessWidget {
//   const InvitationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         backgroundColor: Colors.white,
//         title:  Center(child: Text('Invitations' ,
//          style: GoogleFonts.comfortaa(fontSize: 20), )),
//         actions: const [
//           SizedBox(
//             width: 55,
//           ),
//         ],
//         leading: IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () => ZoomDrawer.of(context)!.toggle()),
//       ),
//       body: BodyAllPages(),
//     );
//   }
// }

class CheckoutPageNoLogin extends StatelessWidget {
  const CheckoutPageNoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
              'Checkout',
              style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        actions: const [
          SizedBox(
            width: 55,
          ),
        ],
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => ZoomDrawer.of(context)!.toggle()),
      ),
      body: const BodyAllPages(),
    );
  }
}

class CheckoutDrawer extends StatelessWidget {
  const CheckoutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
              'Checkout',
              style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        actions: const [
          SizedBox(
            width: 55,
          ),
        ],
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => ZoomDrawer.of(context)!.toggle()),
      ),
      body: const CheckoutBody(),
    );
  }
}

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage ({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         backgroundColor: Colors.white,
//         title:  Center(child: Text('Notifications' ,  style: GoogleFonts.comfortaa(fontSize: 20),)),
//         actions: const [
//           SizedBox(
//             width: 55,
//           ),
//         ],
//         leading: IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () => ZoomDrawer.of(context)!.toggle()),
//       ),
//       body: BodyAllPages(),
//     );
//   }
// }


class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Offers',
            style: GoogleFonts.comfortaa(fontSize: 20),
          ),
        ),
        actions: const [
          SizedBox(
            width: 55,
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingAllpages());
          } else {
            return const Scaffold(
              backgroundColor: Colors.white,
            );
          }
        },
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _changeBodyContent();
  }

  void _changeBodyContent() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showLoading = false;
      });
    });
  }

  void _showOverlaySnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 40,
        left: MediaQuery.of(context).size.width * 0.25,
        right: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white , fontWeight: FontWeight.w600 , fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Settings', style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        actions: const [
          SizedBox(width: 55),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
        ),
      ),
      body: _showLoading
          ? const LoadingAllpages()
          : SettingMainPage(showSnackBar: _showOverlaySnackBar),
    );
  }
}

class SettingMainPage extends StatefulWidget {
  final void Function(BuildContext context, String message) showSnackBar;

  const SettingMainPage({super.key, required this.showSnackBar});

  @override
  _SettingMainPageState createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
  bool _isAvailable = false;

  void _handleSwitchChange(bool? value) {
    setState(() {
      _isAvailable = value ?? false;
    });

    String message = _isAvailable ? 'Available' : 'Not Available';
    widget.showSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                'Preferences',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 45,),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: _isAvailable ? Colors.yellow.shade600 : Colors.grey,
                size: 25,
              ),
              const SizedBox(width: 20),
              const Text(
                'Available',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: GFToggle(
                  value: _isAvailable,
                  onChanged: _handleSwitchChange,
                  disabledThumbColor: Colors.white,
                  disabledTrackColor: Colors.grey,
                  enabledThumbColor: Colors.yellow[600],
                  enabledTrackColor: Colors.yellow[200],
                  duration: const Duration(milliseconds: 1),
                ),
              )
              /*Switch(
                // thumb color (round icon)
                activeColor: Colors.amber,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: _isAvailable,
                // changes the state of the switch
                onChanged: (value) => setState(() => _isAvailable = value),
              ),*/
            ],
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BuddiesPage()));
            },
            child: Container(
                height: 37,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellow.shade600,
                ),
                child: const Center(
                  child: Text('Invite friends', style: TextStyle(fontWeight: FontWeight.bold),),
                )),
          ),
          const SizedBox(height: 20),
          Container(
              height: 37,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.shade600,
              ),
              child: const Center(
                child: Text('Delete account', style: TextStyle(fontWeight: FontWeight.bold),),
              )),
        ],
      ),
    );
  }
}