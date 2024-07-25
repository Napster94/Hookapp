import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'buddies.dart';

class Hollywood extends StatefulWidget {
  const Hollywood({Key? key}) : super(key: key);

  @override
  State<Hollywood> createState() => _HollywoodState();
}

class _Review {
  final int rating;
  final String message;

  _Review({
    required this.rating,
    required this.message,
  });
}

class _HollywoodState extends State<Hollywood> {
  bool isFavorite = false;
  List<_Review> reviews = [];

  @override
  void initState() {
    super.initState();
    _Review hardcodedReview = _Review(
      rating: 5,
      message: 'Good Ambience!',
    );
    reviews.add(hardcodedReview);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20,),
                  onPressed: () {
                    Navigator.of(context).pop();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  padding: const EdgeInsets.only(left: 8),
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 500,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/hollywood.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    'Hollywood \nCafe Zahle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  width: 50,
                  height: 22,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4.3',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'International',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.fastfood,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Zahle',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Zahle - Lebanon Hollywood Cafe',
                        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),

                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.info_outline,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextButton(
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: 'tel',
                            path: '08813903',
                          );
                          await launchUrl(url);
                        },
                        child: const Text(
                          '08813903',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerRight,
                      icon: const Icon(
                        Icons.phone,
                        size: 12,
                      ),
                      onPressed: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: '08813903',
                        );
                        await launchUrl(url);
                      },
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_outlined, size: 18,color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('Opening hours [ 12:00pm - 12:00am ]', style: TextStyle(fontSize: 13, letterSpacing: 0.2, color: Colors.grey),),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1, color: Colors.grey,),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                    'Favorite to',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/user.jpg'),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/user.jpg'),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/user.jpg'),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/user.jpg'),
                    ),
                  ),
                  const SizedBox(width: 20,),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  context;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BuddiesPage())
                  );
                },
                label: const Text(
                  'Invite buddy',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
                icon: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16, // Adjust the icon size as needed
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(thickness: 1, color: Colors.grey,),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: Text('Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextButton.icon(
                      onPressed: () {
                        _showAddReviewDialog();
                      },
                      label: const Text(
                        'Add review',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      icon: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.yellow[600],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Column(
              children: reviews.map((review) {
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Icon(Icons.star, color: Colors.yellow[600], size: 50),
                              Text(
                                '${review.rating}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Charbel',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              review.message,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );


              }).toList(),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReviewDialog(
          onReviewAdded: (newReview) {
            if (newReview != null) {
              setState(() {
                reviews.add(newReview);
              });
            }
          },
        );
      },
    );
  }
}

class AddReviewDialog extends StatefulWidget {
  final Function(_Review?) onReviewAdded;

  const AddReviewDialog({Key? key, required this.onReviewAdded}) : super(key: key);

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  TextEditingController _messageController = TextEditingController();
  double _rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(''),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Add review', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            TextField(
              cursorColor: Colors.black,
              controller: _messageController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow.shade600),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            const Text('Select rate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
            ),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: Container(
            width: 130,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {
                String message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  _addReview(_rating.toInt(), message);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Save Review',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),

      ],
    );
  }

  void _addReview(int rating, String message) {
    _Review newReview = _Review(rating: rating, message: message);
    widget.onReviewAdded(newReview);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
