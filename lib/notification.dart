import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Notifications',
            style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          SizedBox(
            width: 55,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.fromLTRB(5, 4, 5, 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.shade600,
                  blurRadius: 0.1,
                  offset: const Offset(0, 0.8),
                ),
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow.shade600,
                backgroundImage: const AssetImage('assets/hookalogo.png'),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Salim reacted to your \ninvite!'),
                            const Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow.shade600,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.06,)
                          ],
                        ),
                        const Row(
                          children: [
                            Text('Invite has been accepted', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,),
                            ),
                            Spacer(),
                            Text('2024-6-21', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}