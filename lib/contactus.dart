import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'main.dart';

class MyContactPage extends StatelessWidget {
  const MyContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
        menuScreen: MenuScreen(),
        mainScreen: ContactMainScreen(),
        borderRadius: 24.0,
        showShadow: true,
        drawerShadowsBackgroundColor: Color.fromARGB(255, 57, 55, 55),
        menuBackgroundColor: Colors.black,
        mainScreenTapClose: true);
  }
}

class ContactMainScreen extends StatelessWidget {
  const ContactMainScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final drawerController = ZoomDrawer.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('ContactUs', style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            if (drawerController?.isOpen == true) {
              drawerController?.close();
            } else {
              drawerController?.open();
            }
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (drawerController?.isOpen == true) {
            drawerController?.close();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (drawerController?.isOpen == true && details.delta.dx > 0) {
            drawerController?.close();
          }
        },
        child: const ContactUsPage(),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _navigateToPage(BuildContext context, String pageName) {
    ZoomDrawer.of(context)?.open();

    if (pageName == 'MainScreen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else if (pageName == 'ContactUs') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactUsPage()),
      );
    } else if (pageName == 'Login') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          const SizedBox(
            height: 100,
          ),
          ListTile(
            leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.yellow.shade600,
            ),
            title: GestureDetector(
              onTap: () => _navigateToPage(context, 'MainScreen'),
              child: const Text(
                'MainScreen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.check,
              color: Colors.yellow.shade600,
            ),
            title: const Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade600,
            ),
            title: const Text(
              'My Orders',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              color: Colors.yellow.shade600,
            ),
            title: const Text(
              'Invitations',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.yellow.shade600,
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.yellow.shade600,
            child: GestureDetector(
              onTap: () => ZoomDrawer.of(context)!.close(),
              child: const ListTile(
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.black,
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.yellow.shade600,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () => _navigateToPage(context, 'Login'),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.yellow.shade600,
              ),
              title: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> cities = ['Zahle', 'Beirut', 'Byblos'];

  Future<void> _selectFromList(
      BuildContext context,
      TextEditingController controller,
      List<String> items,
      String selectedItem,
      ) async {
    await showModalBottomSheet<String>(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context, selectedItem);
          },
          child: Container(
            height: 250,
            color: Colors.transparent,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedItem = items[index];
                      });
                    },
                    children: items.map((item) {
                      return Center(child: Text(item));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((pickedItem) {
      if (pickedItem != null) {
        setState(() {
          controller.text = pickedItem;
        });
      }
    });
  }

  void _handleSend() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      Timer(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black,
              behavior: SnackBarBehavior.floating,
              content: const Center(
                child: Text('Your message sent successfully', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            width: 250,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
              ),
            ),
        );
        _nameController.clear();
        _mobileController.clear();
        _emailController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double baseFontSize = 17;
    double largeFontSize = 18;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/hookalogo.png',
                  width: 230,
                  height: 230,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'We are committed to your Experience',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: largeFontSize * (width / 365),
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      textAlign: TextAlign.justify,
                      'Recognizing   the   value   of   memorable experiences, we   are   deeply   committed \nto   delivering    consistent   and    reliable \nservice     across     our      business       to   \nguarantee     the     highest       level       of \nsatisfaction. ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: baseFontSize * (width / 365),
                      ),
                    ),
                    const SizedBox(height: 19),
                    Text(
                      textAlign: TextAlign.justify,
                      'Our  talented  team  understands  the  needs and expectations of hosts and customers, and we take immense pride  in the quality of the products we use.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: baseFontSize * (width / 365),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      textAlign: TextAlign.justify,
                      'Whether   you   are   interested   in becoming a host \nor learning more about the experience, we\'d love to hear from you.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: baseFontSize * (width / 365),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.justify,
                      'Please send an email to info@hookatimes.com \nfor  further  information  about  our  brand.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: baseFontSize * (width / 365),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      cursorColor: Colors.yellow[600],
                      controller: _nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Name',
                        labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 11),
                        hintText: 'Name',
                        hintStyle: const TextStyle(fontSize: 11),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 11.8 ,horizontal: 16.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      cursorColor: Colors.yellow[600],
                      controller: _mobileController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Mobile',
                        labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 11),
                        hintText: 'Mobile',
                        hintStyle: const TextStyle(fontSize: 11),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 11.8, horizontal: 16.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (value.length != 8) {
                          return 'Mobile number must be 8 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      cursorColor: Colors.yellow[600],
                      controller: _emailController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email',
                        labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 11),
                        hintText: 'Email',
                        hintStyle: const TextStyle(fontSize: 11),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 11.8, horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                      cursorColor: Colors.yellow[600],
                      controller: _messageController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Your Message...',
                        labelStyle:
                        TextStyle(color: Colors.grey.shade700, fontSize: 11),
                        hintText: 'Your Message...',
                        hintStyle: const TextStyle(fontSize: 11),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 11.8, horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 65),
                    Container(
                      width: 331,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow.shade600,
                      ),
                      child: TextButton(
                        onPressed: _handleSend,
                        child: Center(
                          child: isLoading
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                'Loading...',
                                  style: GoogleFonts.comfortaa(textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  )
                              ),
                            ],
                          )
                              : Text(
                            'Send',
                            style: GoogleFonts.comfortaa(textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
