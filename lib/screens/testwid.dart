import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:moodclicks/model/classopinion.dart';
import 'package:moodclicks/model/classopinion.dart';

class GetOpinion extends StatelessWidget {
  List<Opinion> op = []; 
  final String documentId;

  GetOpinion(this.documentId);
  
   CollectionReference users =
        FirebaseFirestore.instance.collection('opinion');
  @override
  Widget build(BuildContext context) {
 

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
 

          Opinion ops = Opinion.fromMap(Map<String, dynamic> snapshot.data!.data()) as Opinion;

          Map<String, dynamic> data1 =
              snapshot.data!.data() as Opinion.fromMap(data1);

              
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['name']} ${data['description']}");
        }

        return Text("loading");
      },
    );
  }
}
