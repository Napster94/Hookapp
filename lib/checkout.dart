import 'package:dotted_line_flutter/dotted_line_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'allpages.dart';
import 'complete-order.dart';
import 'products.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title:  Center(
          child: Text(
            'Checkout',
            style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          SizedBox(width: 45,),
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
      body: const CheckoutBody(),
    );
  }
}

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  late Future<Box<Product>> _cartBoxFuture;

  @override
  void initState() {
    super.initState();
    _cartBoxFuture = Hive.openBox<Product>('cartBox2');
  }

  double getTotalAmount(Box<Product> cartBox) {
    if (cartBox.isEmpty) return 0;
    return cartBox.values
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Product>>(
      future: _cartBoxFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            var cartBox = snapshot.data;
            if (cartBox!.isEmpty) {
              return FutureBuilder<Box<Product>>(
                future: _cartBoxFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      var cartBox = snapshot.data;
                      double totalAmount = getTotalAmount(cartBox!);
                      return ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          const Text(
                            'Your Basket',
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 34),
                          ...cartBox.values.map((product) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${product.name} x ${product.quantity}',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      '${(product.price * product.quantity).toStringAsFixed(2)} \$',
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 55,),
                          const Text(
                            'Order Summary',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 41),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Order amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text('${totalAmount.toStringAsFixed(2)} \$',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Delivery fees', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                Text('0.00 \$', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 47,
                          ),
                          Divider(
                            thickness: 1,
                            height: 40,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Payment Method',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 19),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: Checkbox(
                                  activeColor: Colors.black,
                                  checkColor: Colors.yellow.shade600,
                                  value: true,
                                  onChanged: (value) {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              const Text('Cash On Delivery', style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          CustomPaint(
                            size: const Size(200, 1),
                            painter: DottedLinePainter(
                              dashWidth: 4,
                              dashGap: 7,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total amount',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${totalAmount.toStringAsFixed(2)} \$',
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CompleteOrder()),
                                    );
                                  },
                                  child: Container(
                                    width: 220,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.shade600,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Complete Order',
                                        style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        );

                    }
                  } else {
                    return const Center(
                      child: LoadingAllpages(),
                    );
                  }
                },
              );
            } else {
              double totalAmount = getTotalAmount(cartBox);
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Your Basket',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 34),
                  ...cartBox.values.map((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '${product.name} x ${product.quantity}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              '${(product.price * product.quantity).toStringAsFixed(2)} \$',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(
                    height: 55,
                  ),
                  const Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 41),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Order amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('${totalAmount.toStringAsFixed(2)} \$',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery fees', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('0.00 \$', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 47,
                  ),
                  Divider(
                    thickness: 1,
                    height: 40,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          activeColor: Colors.black,
                          checkColor: Colors.yellow.shade600,
                          value: true,
                          onChanged: (value) {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      const Text('Cash On Delivery', style: TextStyle(fontSize: 14 , fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  CustomPaint(
                    size: const Size(200, 1),
                    painter: DottedLinePainter(
                      dashWidth: 4,
                      dashGap: 7,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total amount',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${totalAmount.toStringAsFixed(2)} \$',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CompleteOrder()),
                          );
                        },
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade600,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Complete Order',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              );
            }
          }
        } else {
          return const Center(
            child: LoadingAllpages(),
          );
        }
      },
    );
  }
}