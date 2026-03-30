import 'package:expense_manager/Components/rounded_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constcolors.dart';
import 'create_account_controller.dart';

// class CreateAccountScreen extends GetView<CreateAccountController> {
//   const CreateAccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ConstColor.Secondaycolor,
//       appBar: AppBar(
//         backgroundColor: ConstColor.Secondaycolor,
//         elevation: 0,
//         title: const Text(
//           'Create account',
//           style: TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.w700,
//             color: ConstColor.Primarycolor,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Text(
//           'Add your form here',
//           style: TextStyle(
//             fontFamily: 'Montserrat',
//             fontSize: 14,
//             color: ConstColor.Primarycolor.withValues(alpha: 0.55),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString selectedType = 'bank'.obs;

    final List<String> accountTypes = [
      'bank',
      'cash',
      'debit',
      'credit',
    ];

    return Scaffold(
      backgroundColor: ConstColor.Secondaycolor,
      appBar: AppBar(
        backgroundColor: ConstColor.Secondaycolor,
        elevation: 0,
        title: const Text(
          'Create Account',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: ConstColor.Primarycolor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Account Name
            _buildField(
              hint: "Account Name",
            ),

            const SizedBox(height: 16),

            /// Opening Balance
            _buildField(
              hint: "Opening Balance",
              isNumber: true,
            ),

            const SizedBox(height: 24),

            /// Chips Title
            const Text(
              "Account Type",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: ConstColor.Primarycolor,
              ),
            ),

            const SizedBox(height: 12),

            /// Chips
            Obx(() => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: accountTypes.map((type) {
                    final isSelected = selectedType.value == type;

                    return GestureDetector(
                      onTap: () => selectedType.value = type,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ConstColor.Fourthcolor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected
                                ? ConstColor.Fourthcolor
                                : ConstColor.Primarycolor.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          type.capitalizeFirst!,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: isSelected
                                ? ConstColor.Primarycolor
                                : ConstColor.Primarycolor.withOpacity(0.6),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),

            const SizedBox(height: 24),
            RoundedPrimaryButton(
              label: 'Save Account',
              onPressed: () => {
                print('Save Account'),
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Minimal Field
  Widget _buildField({required String hint, bool isNumber = false}) {
    return TextField(
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        color: ConstColor.Primarycolor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: ConstColor.Primarycolor.withOpacity(0.4),
          fontFamily: 'Montserrat',
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: ConstColor.Primarycolor.withOpacity(0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: ConstColor.Primarycolor.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: ConstColor.Fourthcolor,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}