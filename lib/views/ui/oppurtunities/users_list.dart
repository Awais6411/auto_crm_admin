import 'package:auto_crm_admin/controllers/admin/admin_provider.dart';
import 'package:auto_crm_admin/views/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/auctioneer_container.dart';

class UsersList extends StatefulWidget {
  int? userId;
  int? auctioneerId;
  UsersList({
    Key? key,
    this.userId,
    this.auctioneerId = 0,
  }) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final ScrollController scrollController = ScrollController();
  var userId = 0; // Default value until SharedPreferences data is fetched
  var auctioneerId;
  var isEdit = false;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future<void> _loadSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedValue = prefs.getInt('auctioneerId') ?? 7;

    setState(() {
      auctioneerId = storedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNotifier>(
      builder: (context, auctioneerNotifier, child) {
        auctioneerNotifier.getUsersList(
            auctioneerId, auctioneerNotifier.weekId);
        return Scaffold(
            appBar: customAppBar(
                onTap: () {
                  Navigator.pop(context);
                },
                title: "${auctioneerNotifier.selectedDate} "),
            body: FutureBuilder(
              future: auctioneerNotifier.usersList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Network error${snapshot.error}"),
                  );
                } else {
                  var userAuctioneersList = snapshot.data;

                  return Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 167, 217, 234),
                        Color.fromARGB(255, 6, 137, 166)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: userAuctioneersList!.length,
                            itemBuilder: (context, index) {
                              return AuctioneerContainer(
                                name: userAuctioneersList[index].firstName,
                                userId: userAuctioneersList[index].userId,
                                auctioneerId: auctioneerId,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ));
      },
    );
  }
}
