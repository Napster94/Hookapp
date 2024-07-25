import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class AddressTab extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onAdd;
  final Function(int) onRemove;

  const AddressTab({
    required this.items,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  @override
  _AddressTabState createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  late List<Map<String, dynamic>> addresses;

  @override
  void initState() {
    super.initState();
    addresses = List.from(widget.items);
  }

  void _addAddress(Map<String, dynamic> newAddress) async {
    setState(() {
      addresses.insert(0, newAddress);
      addresses.sort((a, b) => a['title'].compareTo(b['title']));
    });
    var box = await Hive.openBox('userBox');
    for (int index = 0; index < addresses.length; index++) {
      await box.put('addressTitle$index', addresses[index]['title']);
      await box.put('addressCity$index', addresses[index]['city']);
      await box.put('addressStreet$index', addresses[index]['street']);
      await box.put('addressBuilding$index', addresses[index]['building']);
      await box.put('addressAppartment$index', addresses[index]['appartment']);
    }
    widget.onAdd(newAddress);
  }

  void _removeAddress(int index) async {
    if (index >= 0 && index < addresses.length) {
      var box = await Hive.openBox('userBox');

      // Remove the specified address
      await box.delete('addressTitle$index');
      await box.delete('addressCity$index');
      await box.delete('addressStreet$index');
      await box.delete('addressBuilding$index');
      await box.delete('addressAppartment$index');

      setState(() {
        addresses.removeAt(index);
      });

      for (int i = index; i < addresses.length; i++) {
        await box.put('addressTitle$i', box.get('addressTitle${i + 1}'));
        await box.put('addressCity$i', box.get('addressCity${i + 1}'));
        await box.put('addressStreet$i', box.get('addressStreet${i + 1}'));
        await box.put('addressBuilding$i', box.get('addressBuilding${i + 1}'));
        await box.put('addressAppartment$i', box.get('addressAppartment${i + 1}'));
      }

      int lastIndex = addresses.length;
      await box.delete('addressTitle$lastIndex');
      await box.delete('addressCity$lastIndex');
      await box.delete('addressStreet$lastIndex');
      await box.delete('addressBuilding$lastIndex');
      await box.delete('addressAppartment$lastIndex');

      widget.onRemove(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final item = addresses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenWidth * 0.2,
                                color: Colors.yellow.shade600,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/building.svg'
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 25,
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text('Title :', style: TextStyle(fontSize: 17)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text('${item['title']}', style: const TextStyle(fontSize: 17)),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 25,
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text('City :', style: TextStyle(fontSize: 17)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text('${item['city']}', style: const TextStyle(fontSize: 17)),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 25,
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text('Street :', style: TextStyle(fontSize: 17)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text('${item['street']}', style: const TextStyle(fontSize: 17)),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 25,
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text('Building :', style: TextStyle(fontSize: 17)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text('${item['building']}', style: const TextStyle(fontSize: 17)),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _removeAddress(index);
                                      },
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete, color: Colors.white),
                                              SizedBox(width: 5),
                                              Text('Remove item', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
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
        Positioned(
          bottom: 40,
          right: 30,
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressPage(),
                ),
              );
              if (result != null) {
                _addAddress(result);
              }
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.yellow,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _appartmentController = TextEditingController();

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

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      content: Center(child: Text(message)),
      width: 190,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ));
  }

  bool _validateInput(String value) {
    return value.trim().isNotEmpty;
  }

  void _handleAddAddress(BuildContext context) {
    if (!_validateInput(_titleController.text) ||
        !_validateInput(_cityController.text) ||
        !_validateInput(_streetController.text) ||
        !_validateInput(_buildingController.text)) {
      _showSnackBar(context, 'Please Fill Out All Fields');
    } else {
      final newAddress = {
        'title': _titleController.text,
        'city': _cityController.text,
        'street': _streetController.text,
        'building': _buildingController.text,
        'appartment': _appartmentController.text,
      };
      Navigator.pop(context, newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Add new address',
            style: GoogleFonts.comfortaa(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Address title *',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                          hintText: 'Address title *',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    onTap: () =>
                        _selectFromList(context, _cityController, cities, cities[0]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox(
                        height: 40,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                              labelText: 'Select a city*',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _streetController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Street *',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                        hintText: 'Street *',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _buildingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Building *',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
                        hintText: 'Building *',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleAddAddress(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade600,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}