import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class FishTab extends StatelessWidget {
  const FishTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Pond').snapshots(),
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
                  child: ColoredBox(
                    color: Colors.white,
                    child: ExpansionTile(
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                      leading: Image.asset('assets/images/pond.png'),
                      title: TextRegular(
                          text: data.docs[index]['pondName'],
                          fontSize: 18,
                          color: Colors.black),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRegular(
                              text: 'Location: ' +
                                  data.docs[index]['pondLocation'],
                              fontSize: 12,
                              color: Colors.grey),
                          TextRegular(
                              text: 'Personel: ' + data.docs[index]['name'],
                              fontSize: 12,
                              color: Colors.grey),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextRegular(
                                  text: 'Quantity of Fishes',
                                  fontSize: 12,
                                  color: Colors.black),
                              const SizedBox(height: 5),
                              TextRegular(
                                  text: data.docs[index]['description'],
                                  fontSize: 15,
                                  color: Colors.black),
                            ],
                          ),
                        ),
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
