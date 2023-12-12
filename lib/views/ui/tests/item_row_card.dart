/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/cars/cars_provider.dart';
import '../../../db/db_helper.dart';
import '../../common/widgets/custom_btn.dart';
import 'customListTile.dart';

class SqflitePage extends StatefulWidget {
  const SqflitePage({super.key});

  @override
  State<SqflitePage> createState() => _SqflitePageState();
}

class _SqflitePageState extends State<SqflitePage> {
  List<Map<String, dynamic>> _journals = [];

  List<Map<String, dynamic>> mapObject = [
    {
      'status': true,
      'title': '2018  Ford  F-150',
      'description': '',
      'imageUrl': 'img2.png'
    },
    {
      'status': false,
      'title': '2019  Mercedes  S-Class',
      'description': '',
      'imageUrl': 'img3.png'
    },
    {
      'status': false,
      'title': '2022  Porsche  Panamera',
      'description': '',
      'imageUrl': 'img5.png'
    },
    {
      'status': true,
      'title': '2023  Audi  A-4',
      'description': '',
      'imageUrl': 'img6.png'
    },
  ];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = true;

  var userId = 0;

  Future<void> _loadSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedValue = prefs.getInt('userId') ?? 0;
    setState(() {
      userId = storedValue;
    });
  }

  Future<void> _refreshJournals() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSharedPreferencesData();
    _refreshJournals();
    print('...Numbers of items is ${_journals.length}');
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully deleted a journal")));
    _refreshJournals();
  }

  void _showForm(int? id) {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);

      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        color: Colors.grey.withOpacity(0.3),
        padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addItem();
                  }
                  if (id != null) {
                    await _updateItem(id);
                  }

                  _titleController.text = '';
                  _descriptionController.text = '';
                  Navigator.pop(context);
                },
                child: Text(id == null ? 'Create New' : 'Update'))
          ],
        ),
      ),
    );
  }

  bool isChecked = false;
  bool isfirstTime = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<CarsNotifier>(
      builder: (context, carsNotifier, child) {
        if (isfirstTime) {
          carsNotifier.getUserCarsData(11);
          isfirstTime = false;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 8, 99, 155),
            centerTitle: true,
            title: const Text('Update List'),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.all(7),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 18, 131, 223),
                    borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  "assets/icons/arrow_back.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 167, 217, 234),
                  Color.fromARGB(255, 6, 137, 166)
                ], // Replace with your desired colors
                begin: Alignment.topLeft, // Adjust the starting point
                end: Alignment.bottomRight, // Adjust the ending point
              )),
              child: FutureBuilder(
                future: carsNotifier.carsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error exception ${snapshot.error}"),
                    );
                  } else {
                    var carList = snapshot.data;
                    return Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: carList!.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5, top: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20)),
                              child: CustomTile(
                                index: index,
                                title:
                                    '${carList![index].year}  ${carList[index].make}  ${carList[index].model}',
                                subTitle: mapObject[index]['description'],
                                imageUrl: carList[index].imageUrl,
                                onDeletePressed: () => _deleteItem(
                                  _journals[index]['id'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            var list = Provider.of<CarsNotifier>(context,
                                    listen: false)
                                .carIdsList;

                            print('List==========>$list');
                          },
                          child: const ReuseableButton(
                            text: "Update",
                            height: 45,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  }
                },
              )),
        );
      },
    );
  }
}
 */