import 'package:flutter/material.dart';

import '../../controller/userProfileController.dart';
import '../../model/userProfileModel.dart';
import '../components/appbarWithArrow.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  UserProfileModel? _userProfile;
  bool _isEditing = false;
  final _userProfileController = UserProfileController();

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    try {
      final userProfile = await _userProfileController.getUserProfile();
      setState(() {
        _userProfile = userProfile;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil bilgileri alınamadı.')),
      );
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await _userProfileController.updateUserProfile(_userProfile!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil başarıyla güncellendi.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil güncellenirken hata oluştu.')),
      );
    }
  }

  Future<void> _pickImage() async {
    if (_userProfile != null) {
      await _userProfileController.pickImage(_userProfile!);
      setState(() {});
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (_userProfile != null) {
      await _userProfileController.selectDate(context, _userProfile!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userProfile == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const AppbarWithArrow(
              appbarText: "PROFİLİ DÜZENLE", detailPage: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _isEditing ? _pickImage : null,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            _userProfile!.profileImage.path.isNotEmpty
                                ? FileImage(_userProfile!.profileImage)
                                : null,
                        child: _userProfile!.profileImage.path.isEmpty
                            ? const Icon(Icons.camera_alt,
                                size: 60, color: Colors.grey)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      initialValue: _userProfile!.name,
                      readOnly: !_isEditing,
                      onChanged: (value) {
                        setState(() {
                          _userProfile!.name = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Surname',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      initialValue: _userProfile!.surname,
                      readOnly: !_isEditing,
                      onChanged: (value) {
                        setState(() {
                          _userProfile!.surname = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      initialValue: _userProfile!.email,
                      readOnly: !_isEditing,
                      onChanged: (value) {
                        setState(() {
                          _userProfile!.email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _userProfile!.gender.isNotEmpty
                          ? _userProfile!.gender
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      items: <String>['Male', 'Female', 'Other']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: _isEditing
                          ? (newValue) {
                              setState(() {
                                _userProfile!.gender = newValue!;
                              });
                            }
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        "Birth Date: ${DateFormat('yyyy-MM-dd').format(_userProfile!.birthDate.toLocal())}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing:
                          const Icon(Icons.calendar_today, color: Colors.grey),
                      onTap: _isEditing ? () => _selectDate(context) : null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_isEditing) {
                            if (_formKey.currentState!.validate()) {
                              _updateUserProfile();
                            }
                          }
                          _isEditing = !_isEditing;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        // padding: const EdgeInsets.symmetric(vertical: 5),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Text(_isEditing ? 'Save' : 'Edit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
