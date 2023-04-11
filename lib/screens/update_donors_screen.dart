import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonorsScreen extends StatefulWidget {
  const UpdateDonorsScreen({super.key});

  @override
  State<UpdateDonorsScreen> createState() => _UpdateDonorsScreenState();
}

class _UpdateDonorsScreenState extends State<UpdateDonorsScreen> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorNameController = TextEditingController();
  TextEditingController donorPhoneController = TextEditingController();

  void updateDonor(docID) {
    final data = {
      'name': donorNameController.text,
      'phone': donorPhoneController.text,
      'bloodGroup': selectedGroup,
    };
    donor.doc(docID).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorNameController.text = args['name'];
    donorPhoneController.text = args['phone'];
    selectedGroup = args['bloodGroup'];
    final docID = args['id'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Donors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: donorNameController,
              decoration: const InputDecoration(
                labelText: 'Donor Name',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: donorPhoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(
              height: 40,
            ),
            DropdownButtonFormField(
              value: selectedGroup,
              hint: const Text('Select Blood Group'),
              items: bloodGroups
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 50),
                ),
              ),
              onPressed: () {
                updateDonor(docID);
                // Navigator.pop(context);
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
