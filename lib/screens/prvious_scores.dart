import '../Constants/constants.dart';
import '../widgets/previous_score_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreviousScores extends StatelessWidget {
  const PreviousScores({super.key});

  static const routeName = "prevSCroes";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Previous Scores")),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(Constants.user)
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection(Constants.prevScores)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data;
              return Column(
                children: [
                  const PreviousScoreItem(score: 'Score', date: 'Date', time: 'Time'),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) => PreviousScoreItem(
                          score: extractedData?.docs[index]['score'].toString(),
                          date: extractedData?.docs[index]['date'],time: extractedData?.docs[index]['time'],)),
                      itemCount: extractedData?.size,
                    ),
                  ),
                ],
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
