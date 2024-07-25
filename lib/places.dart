import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'restaurant.dart';
import 'hollywood.dart';
import 'mazaj.dart';
import 'savoia.dart';
import 'map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  await Hive.openBox<Restaurant>('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Places(),
    );
  }
}

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final List<Restaurant> restaurants = [
    Restaurant(
      name: "Mazaj Restaurant",
      cuisine: "International",
      location: "Zahle",
      rating: 4.3,
      imageUrl: "assets/mazaj_restaurant.jpg",
    ),
    Restaurant(
      name: 'Hollywood Cafe Zahle',
      cuisine: 'International',
      location: 'Zahle',
      rating: 3,
      imageUrl: "assets/hollywood.jpg",
    ),
    Restaurant(
      name: 'Savoia Resto Pub & Lounge',
      cuisine: 'Turkish',
      location: 'Zahle',
      rating: 5,
      imageUrl: 'assets/savoia.jpg',
    ),
  ];

  String searchQuery = '';
  String? selectedCuisine;
  bool isChecked = false;
  bool isRating = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  void _loadFavorites() {
    final favoritesBox = Hive.box<Restaurant>('favorites');
    for (var restaurant in restaurants) {
      restaurant.isFavorite = favoritesBox.containsKey(restaurant.name);
    }
  }

  void _toggleFavorite(Restaurant restaurant) {
    setState(() {
      restaurant.isFavorite = !restaurant.isFavorite;
      final favoritesBox = Hive.box<Restaurant>('favorites');
      if (restaurant.isFavorite) {
        favoritesBox.put(restaurant.name, restaurant);
      } else {
        favoritesBox.delete(restaurant.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Restaurant> filteredRestaurants = restaurants.where((restaurant) {
      if (selectedCuisine != null && restaurant.cuisine != selectedCuisine) {
        return false;
      }
      if (searchQuery.isNotEmpty &&
          !restaurant.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      if (isFavorite && !restaurant.isFavorite) {
        return false;
      }
      return true;
    }).toList();

    filteredRestaurants.sort((a, b) => isRating ? b.rating.compareTo(a.rating) : 0);
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade200, Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 55,
                expandedHeight: 20,
                title: Text(
                  'Places',
                  style: GoogleFonts.comfortaa(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MapPage()),
                      );
                    },
                    child: Text(
                      'Map',
                      style: GoogleFonts.comfortaa(
                        textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
                floating: true,
                snap: true,
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _SliverAppBarDelegate(
                  minHeight: 180,
                  maxHeight: 180,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: 'Restaurant name...',
                                hintStyle: const TextStyle(fontSize: 14),
                                prefixIcon: const Icon(
                                  Icons.search_outlined,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade400),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow.shade600),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: SizedBox(
                                      width: 118,
                                      height: 34,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          focusColor: Colors.white,
                                          icon: const Icon(Icons.keyboard_arrow_down),
                                          iconSize: 22,
                                          hint: const Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text("Cuisines", style: TextStyle(color: Colors.black, fontSize: 14)),
                                          ),
                                          dropdownColor: Colors.white,
                                          value: selectedCuisine,
                                          items: <String>[
                                            'International',
                                            'Italian',
                                            'Chinese',
                                            'Mexican',
                                            'Thai',
                                            'Greek',
                                            'Indian',
                                            'Japanese',
                                            'Spanish',
                                            'French',
                                            'Lebanese',
                                            'American',
                                            'Turkish',
                                            'German',
                                            'Portuguese',
                                            'Polish',
                                            'Indonesian',
                                            'Argentina',
                                            'Korean',
                                            'Iranian',
                                            'Syrian'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(fontSize: 14),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCuisine = newValue!;
                                            });
                                          },
                                          alignment: Alignment.centerLeft,
                                          isExpanded: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCuisine = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.yellow,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  },
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
                                      if (isChecked)
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
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 80,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
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
                                      if (isFavorite)
                                        const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 10,
                                        ),
                                      if (isFavorite)
                                        const SizedBox(width: 3),
                                      const Flexible(
                                        child: Text(
                                          'Favorites',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 80,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isRating = !isRating;
                                    });
                                  },
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
                                      if (isRating)
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
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Popular restaurants around you',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RestaurantCard(
                        restaurant: filteredRestaurants[index],
                        onFavoritePressed: () => _toggleFavorite(filteredRestaurants[index]),
                      ),
                    );
                  },
                  childCount: filteredRestaurants.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onFavoritePressed;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (restaurant.name == "Mazaj Restaurant") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Mazaj(),
            ),
          );
        } else if (restaurant.name == 'Hollywood Cafe Zahle') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Hollywood(),
            ),
          );
        } else if (restaurant.name == 'Savoia Resto Pub & Lounge') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Savoia(),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: SizedBox(
          height: 310,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    restaurant.imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Container()
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        restaurant.cuisine,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    Expanded(
                        child: Container()
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 5),
                      child: SizedBox(
                        height: 15,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: onFavoritePressed,
                          icon: Icon(
                            restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.yellow[600],
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        restaurant.location,
                        style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}