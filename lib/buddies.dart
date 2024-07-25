import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'allpages.dart';
import 'map.dart';

import 'invitation.dart';

class Buddy {
  final int id;
  final String name;
  final String about;
  final bool isAvailable;
  final int rating;
  final String imageUrl;
  final int distance;
  final bool hasPendingInvite;
  final String longitude;
  final String latitude;

  Buddy({
    required this.id,
    required this.name,
    required this.about,
    required this.isAvailable,
    required this.rating,
    required this.imageUrl,
    required this.distance,
    required this.hasPendingInvite,
    required this.longitude,
    required this.latitude,
  });

  factory Buddy.fromJson(Map<String, dynamic> json) {
    return Buddy(
      id: json['id'],
      name: json['name'],
      about: json['about'],
      isAvailable: json['isAvailable'],
      rating: json['rating'],
      imageUrl: json['image'],
      distance: json['distance'],
      hasPendingInvite: json['hasPendingInvite'],
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
    );
  }
}

class BuddiesPage extends StatefulWidget {
  const BuddiesPage({super.key});

  @override
  State<BuddiesPage> createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  List<Buddy> buddies = [
    Buddy(
      id: 1,
      name: 'Georges',
      about: 'About Georges',
      isAvailable: true,
      rating: 4,
      imageUrl: 'assets/user2.png',
      distance: 30,
      hasPendingInvite: false,
      longitude: '',
      latitude: '',
    ),
    Buddy(
      id: 2,
      name: 'Jacob',
      about: 'About Jacob',
      isAvailable: true,
      rating: 5,
      imageUrl: 'assets/user2.png',
      distance: 10,
      hasPendingInvite: false,
      longitude: '',
      latitude: '',
    ),
    Buddy(
        id: 3,
        name: 'Charbel',
        about: 'About Charbel',
        isAvailable: true,
        rating: 6,
        imageUrl: 'assets/user2.png',
        distance: 15,
        hasPendingInvite: false,
        longitude: '',
        latitude: ''
    ),
    Buddy(
      id: 2,
      name: 'Salim',
      about: 'About Salim',
      isAvailable: true,
      rating: 5,
      imageUrl: 'assets/user2.png',
      distance: 10,
      hasPendingInvite: false,
      longitude: '',
      latitude: '',
    ),
    Buddy(
      id: 2,
      name: 'Ali',
      about: 'About Ali',
      isAvailable: true,
      rating: 5,
      imageUrl: 'assets/user2.png',
      distance: 10,
      hasPendingInvite: false,
      longitude: '',
      latitude: '',
    ),
  ];

  List<Buddy> filteredBuddies = [];
  String searchQuery = '';
  bool isLoading = true;
  String errorMessage = '';
  bool isNearestFilterSelected = false;
  bool isRatingFilterSelected = false;

  @override
  void initState() {
    super.initState();
    filteredBuddies = List.from(buddies);
    fetchBuddies();
  }

  Future<void> fetchBuddies() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      filteredBuddies = List.from(buddies);
      isLoading = false;
    });
  }

  void _filterBuddies(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Buddy> tempBuddies = List.from(buddies);

    if (searchQuery.isNotEmpty) {
      tempBuddies = tempBuddies.where((buddy) {
        return buddy.name.toLowerCase().contains(searchQuery);
      }).toList();
    }

    if (isNearestFilterSelected) {
      tempBuddies.sort((a, b) => a.distance.compareTo(b.distance));
    }

    if (isRatingFilterSelected) {
      tempBuddies.sort((a, b) => b.rating.compareTo(a.rating));
    }

    setState(() {
      filteredBuddies = tempBuddies;
    });
  }

  void _toggleNearestFilter() {
    setState(() {
      isNearestFilterSelected = !isNearestFilterSelected;
      _applyFilters();
    });
  }

  void _toggleRatingFilter() {
    setState(() {
      isRatingFilterSelected = !isRatingFilterSelected;
      _applyFilters();
    });
  }

  void _navigateToInvitePage(Buddy buddy) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvitePage(buddy: buddy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 63,
          surfaceTintColor: Colors.white,
          title: Text('Buddies', style: GoogleFonts.comfortaa( fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              },
              child: Text('Map', style: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: LoadingAllpages())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SizedBox(height: 47,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    prefixIcon: Icon(Icons.search, size: 30, color: Colors.grey.shade500),
                    hintText: 'Find Buddies...',
                    hintStyle: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.grey.shade800),
                  onChanged: _filterBuddies,
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: isNearestFilterSelected ? 90:80,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: _toggleNearestFilter,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isNearestFilterSelected)
                            const Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 10,
                            ),
                          const Text(
                            'Nearest',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: isRatingFilterSelected ? 75:65,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: _toggleRatingFilter,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isRatingFilterSelected)
                            const Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 10,
                            ),
                          const Text(
                            'Rating',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 3,
                ),
                itemCount: filteredBuddies.length,
                itemBuilder: (context, index) {
                  final buddy = filteredBuddies[index];
                  return GestureDetector(
                    onTap: () => _navigateToInvitePage(buddy),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Material(
                        elevation: 1,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: FadeInImage.assetNetwork(
                                placeholder: buddy.imageUrl,
                                image: buddy.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    buddy.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                padding: const EdgeInsets.only(top: 8, left: 8),
                                child: Text(
                                  buddy.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvitePage extends StatelessWidget {
  final Buddy buddy;

  const InvitePage({super.key, required this.buddy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Profile', style: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.grey.shade300,
                    Colors.grey.shade300,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: buddy.imageUrl,
                  image: buddy.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      buddy.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    buddy.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InvitePageB()));
                    },
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade600,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: const Center(
                        child: Text('Invite'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InvitePageB extends StatefulWidget {
  const InvitePageB({super.key});

  @override
  State<InvitePageB> createState() => _InvitePageBState();
}

class _InvitePageBState extends State<InvitePageB> {
  bool _isPayForHookapp = false;
  bool _isPayForFood = false;
  bool _isPayYourOwn = false;

  String _selectedPlace = 'Mazaj Restaurant';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _places = [
    'Mazaj Restaurant',
    'Hollywood Cafe',
    'Savoia'
  ];

  void _selectCheckbox(int index) {
    setState(() {
      _isPayForHookapp = index == 0;
      _isPayForFood = index == 1;
      _isPayYourOwn = index == 2;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showPlacePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PlacePicker(
          places: _places,
          onPlaceSelected: (String place) {
            setState(() {
              _selectedPlace = place;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.grey,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Colors.black,
              dialBackgroundColor: Colors.grey[200],
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.black
                  : Colors.grey),
              hourMinuteColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.grey[400]!
                  : Colors.white),
              hourMinuteShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.black
                  : Colors.grey),
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.grey[400]!
                  : Colors.white),
              dayPeriodShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
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
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void _sendInvite() {
    if (_selectedPlace.isEmpty ||
        _messageController.text.isEmpty ||
        (!_isPayForHookapp && !_isPayForFood && !_isPayYourOwn)) {
      _showOverlaySnackBar(context, 'fill all field');
    } else {
      _showOverlaySnackBar(context, 'Invite sent');
      sentInvitations.add(InvitationModel(
          buddies: '1 Buddie(s)',
          cuisine: 'salim',
          description: 'Description',
          details: 'Test',
          image: 'assets/user2.png',
          location: 'location',
          openingHours: '12 am - 12 pm',
          phoneNumber: '76974972',
          rating: 2,
          title: _selectedPlace
      ));
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      onPanDown: (_){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'invite',
              style: GoogleFonts.comfortaa(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Text(
                          'I Will Pay For Hooka',
                          style: TextStyle(fontSize: 17),
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: Colors.black,
                          value: _isPayForHookapp,
                          onChanged: (bool? value) {
                            _selectCheckbox(0);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'I Will Pay For Food',
                          style: TextStyle(fontSize: 17),
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: Colors.black,
                          value: _isPayForFood,
                          onChanged: (bool? value) {
                            _selectCheckbox(1);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'You Will Pay For Your Own Hooka &\nFood',
                          style: TextStyle(fontSize: 17),
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: Colors.black,
                          value: _isPayYourOwn,
                          onChanged: (bool? value) {
                            _selectCheckbox(2);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Choose place',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => _showPlacePicker(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade600),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _selectedPlace,
                              style: const TextStyle(color: Colors.black),
                            ),
                            const Spacer(),
                            Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text(
                            'Choose date time',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month, color: Colors.black),
                            const SizedBox(width: 20),
                            Text(
                              '${_selectedDate.toLocal()}'.split(' ')[0],
                              style: TextStyle(color: Colors.grey.shade800,),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.black),
                            const SizedBox(width: 20),
                            Text(
                              _selectedTime.format(context),
                              style: TextStyle(color: Colors.grey.shade800,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'write message',
                        hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _sendInvite,
                      child: Container(
                        width: 415,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade600,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            'Send',
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlacePicker extends StatefulWidget {
  final List<String> places;
  final ValueChanged<String> onPlaceSelected;

  const PlacePicker(
      {required this.places, required this.onPlaceSelected, super.key});

  @override
  State<PlacePicker> createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  List<String> _filteredPlaces = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredPlaces = widget.places;
    _searchController.addListener(_filterPlaces);
  }

  void _filterPlaces() {
    setState(() {
      _filteredPlaces = widget.places
          .where((place) => place
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: const TextStyle(color: Colors.black),
              labelText: 'Search places',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredPlaces.isEmpty
              ? const Center(child: Text('No data found'))
              : ListView.builder(
            itemCount: _filteredPlaces.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredPlaces[index]),
                onTap: () {
                  widget.onPlaceSelected(_filteredPlaces[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

