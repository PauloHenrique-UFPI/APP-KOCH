import 'package:flutter/material.dart';
import 'package:koch_app/componentization/API.dart';
import 'package:koch_app/models/user.dart';

class SearchUser extends SearchDelegate {
  final FetchUser _userList = FetchUser();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: _userList.getPaciente(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<User>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${data?[index].id}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data?[index].nome}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ])
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search Users'),
    );
  }
}
