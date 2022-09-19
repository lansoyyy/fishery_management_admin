import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishery_management_admin/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FarmerTab extends StatelessWidget {
  const FarmerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Farmers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting');
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    trailing:
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      backgroundImage:
                          NetworkImage(data.docs[index]['profilePicture']),
                    ),
                    title: TextRegular(
                        text: data.docs[index]['name'],
                        fontSize: 18,
                        color: Colors.black),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRegular(
                            text: 'Address: ' + data.docs[index]['address'],
                            fontSize: 12,
                            color: Colors.grey),
                        TextRegular(
                            text: 'Contact Number: ' +
                                data.docs[index]['contactNumber'],
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
