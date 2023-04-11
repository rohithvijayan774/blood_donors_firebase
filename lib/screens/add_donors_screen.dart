import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDonorsScreen extends StatefulWidget {
  const AddDonorsScreen({super.key});

  @override
  State<AddDonorsScreen> createState() => _AddDonorsScreenState();
}

class _AddDonorsScreenState extends State<AddDonorsScreen> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorNameController = TextEditingController();
  TextEditingController donorPhoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addDonor() {
    final data = {
      'name': donorNameController.text,
      'phone': donorPhoneController.text,
      'bloodGroup': selectedGroup,
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Donors'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Donor name required';
                  } else {
                    return null;
                  }
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number required';
                  } else {
                    return null;
                  }
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Blood group required';
                  } else {
                    return null;
                  }
                },
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
                  if (formKey.currentState!.validate()) {
                    addDonor();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
