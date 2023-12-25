import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suit_media_test_application/model.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late ScrollController scrollController;
  late List<User> allUsers;
  List<User> displayedUsers = [];
  int displayIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    allUsers = [];
    loadAllUsers();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (!isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
          color: Color(0xFF554AF0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Third Screen",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              displayedUsers.clear();
              displayIndex = 0;
              isLoading = false;
            });
            loadAllUsers();
          },
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: displayedUsers.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < displayedUsers.length) {
                      User user = displayedUsers[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                          radius: 49,
                        ),
                        title: Text(
                          user.first_name + " " + user.last_name,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        subtitle: Text(
                          user.email.toUpperCase(),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                              context, user.first_name + " " + user.last_name);
                        },
                      );
                    } else if (isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
        ),
      ),
    );
  }

  Future<void> loadAllUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      final users = await getUsers();
      if (users.isNotEmpty) {
        setState(() {
          allUsers.addAll(users);
          loadMoreUsers();
        });
      }
    } catch (e) {
      print('Error loading all users: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      int end = displayIndex + 10;
      if (end > allUsers.length) {
        end = allUsers.length;
      }

      List<User> moreUsers = allUsers.sublist(displayIndex, end);

      setState(() {
        displayedUsers.addAll(moreUsers);
        displayIndex = end;
      });
    } catch (e) {
      print('Error loading more users: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<User>> getUsers() async {
    const url = "https://reqres.in/api/users";
    try {
      var response = await http.get(Uri.parse("$url?per_page=1000"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var jsonArray = jsonData["data"];

        List<User> newUsers = [];
        for (var jsonUser in jsonArray) {
          User user = User(
            id: jsonUser["id"],
            first_name: jsonUser["first_name"],
            last_name: jsonUser["last_name"],
            avatar: jsonUser["avatar"],
            email: jsonUser["email"],
          );

          newUsers.add(user);
        }

        return newUsers;
      } else {
        print('HTTP Error: ${response.statusCode}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error loading users: $e');
      throw Exception('Failed to load users');
    }
  }
}
