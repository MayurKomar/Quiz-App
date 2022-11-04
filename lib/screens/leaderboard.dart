import '../Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardSCreen extends StatelessWidget {
  const LeaderboardSCreen({super.key});

  static const routeName = 'Leaderboard';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Leaderboard")),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(Constants.user)
              .orderBy(Constants.topScore,descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("No.",style: TextStyle(
                                  fontSize: 18,
                                )),
                            Text(Constants.userName.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                            Text(
                              Constants.score.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ]),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.size > 10 ? 10 : snapshot.data?.size,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${index+1}',style: const TextStyle(fontSize: 16),),
                                      Text(
                                        snapshot.data?.docs[index]
                                            [Constants.userName],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        snapshot.data?.docs[index]
                                            [Constants.topScore],
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ]),
                              ),
                            );
                          })))
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
