import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class TempTab extends StatelessWidget {
  const TempTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Temp').snapshots(),
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
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextRegular(
                            text: data.docs[index]['time'] +
                                ' - ' +
                                data.docs[index]['temp'] +
                                '°C',
                            fontSize: 12,
                            color: Colors.green),
                      ],
                    ),
                    leading: Image.asset('assets/images/temp1.png'),
                    title: TextRegular(
                        text: data.docs[index]['pondName'],
                        fontSize: 18,
                        color: Colors.black),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRegular(
                            text:
                                'Address: ' + data.docs[index]['pondLocation'],
                            fontSize: 12,
                            color: Colors.grey),
                        TextRegular(
                            text: 'Personel: ' + data.docs[index]['name'],
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
