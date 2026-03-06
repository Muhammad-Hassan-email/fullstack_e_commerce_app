import 'package:e_commerce_app/constants/primary_button.dart';
import 'package:e_commerce_app/features/auth/common_feature/fields.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'aashifa@gmail.com');
  final _passwordController = TextEditingController(text: '**********');
  final _pincodeController = TextEditingController(text: '450116');
  final _addressController = TextEditingController(text: "216 St Paul's Rd,");
  final _cityController = TextEditingController(text: 'London');
  final _stateController = TextEditingController(text: 'N1 2LL,');
  final _countryController = TextEditingController(text: 'United Kingdom');
  final _bankAccountController = TextEditingController(text: '204356XXXXXXX');
  final _accountHolderController = TextEditingController(text: 'Abhiraj Sisodiya');
  final _ifscController = TextEditingController(text: 'SBIN00428');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pincodeController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _bankAccountController.dispose();
    _accountHolderController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.shade400,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 64,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.lightBlue.shade200,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Personal Details
                _sectionTitle('Personal Details'),
                const SizedBox(height: 12),
                _labeledField(
                  label: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                ),

                _labeledField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  trailing: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFE24A69),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Business Address Details
                _sectionTitle('Business Address Details'),
                const SizedBox(height: 12),
                _labeledField(
                  label: 'Pincode',
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.pin_drop,
                ),

                _labeledField(
                  label: 'Address',
                  controller: _addressController,
                  prefixIcon: Icons.home,
                ),

                _labeledField(
                  label: 'City',
                  controller: _cityController,
                  prefixIcon: Icons.location_city,
                ),

                _labeledField(
                  label: 'State',
                  controller: _stateController,
                  prefixIcon: Icons.map,
                ),

                _labeledField(
                  label: 'Country',
                  controller: _countryController,
                  prefixIcon: Icons.public,
                ),
                const SizedBox(height: 28),

                // Bank Account Details
                _sectionTitle('Bank Account Details'),
                const SizedBox(height: 12),
                _labeledField(
                  label: 'Bank Account Number',
                  controller: _bankAccountController,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.account_balance,
                ),

                _labeledField(
                  label: "Account Holder's Name",
                  controller: _accountHolderController,
                  prefixIcon: Icons.person,
                ),

                _labeledField(
                  label: 'IFSC Code',
                  controller: _ifscController,
                  prefixIcon: Icons.code,
                ),
                const SizedBox(height: 32),

                PrimaryButton(
                  text: 'Save',
                  onPressed: _onSave,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _labeledField({
    required String label,
    required TextEditingController controller,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              //AppTextField Called for pre made text field template
              child: AppTextField(
                hintText: label,
                prefixIcon: prefixIcon,
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                },
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing,
            ],
          ],
        ),
      ],
    );
  }
}
