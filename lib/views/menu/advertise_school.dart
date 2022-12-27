import 'package:flutter/material.dart';
import 'package:school_guide/services/automated_email_service.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_dialog.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/submit_button.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:school_guide/style/app_styles.dart';

class AdvertiseSchool extends StatefulWidget {
  const AdvertiseSchool({super.key});

  @override
  State<AdvertiseSchool> createState() => _AdvertiseSchoolState();
}

class _AdvertiseSchoolState extends State<AdvertiseSchool> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Advertising request form',
        needsHeader: true,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Card(
                    margin: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        color: AppColors.primaryColor,
                        size: 35,
                      ),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Text(
                  'Need to advertise your business on the app? Send us details of what we can do, for you to increase exposure to the app users.',
                ),
              ),
            ],
          ),
          Divider(),
          CustomFormField(controller: nameController, hintText: 'Full name', keyboardType: TextInputType.name, labelText: 'Full name'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.phone, labelText: 'Phone number'),
          CustomFormField(controller: emailController, hintText: 'Email address', keyboardType: TextInputType.emailAddress, labelText: 'Email address'),
          CustomDescFormField(hintText: 'Describe your banner idea', controller: descController, labelText: 'Description'),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(top: 0, bottom: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Checkbox(value: true, onChanged: (val) {}),
                  ),
                  Expanded(
                    flex: 4,
                    child: TopBlackText(text: 'Banner - K50,000/month'),
                  ),
                ],
              ),
            ),
          ),
          SubmitButton(
              onTap: () {
                String br = '<br/>';
                String message =
                    'Dear Sir/Madam,$br$br Thank you for choosing School Guide.$br$br You have applied to have the item with the following description to be advertised on the School Guide Platform:$br$br ${descController.text.trim()}$br$br For any inquiries, please contact us on this same email address or on our mobile phone number +265 880 01 26 74.$br$br Best Regards.';
                CustomDialog.showCustomDialog();

                EmailService.sendEmail(email: emailController.text.trim(), message: message, subject: 'APPLICATION FOR ADVERTISEMENT');
              },
              controllers: [nameController, emailController, descController, phoneController])
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }

  buildItem(value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 0, bottom: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Checkbox(value: true, onChanged: (val) {}),
            ),
            Expanded(
              flex: 4,
              child: TopBlackText(text: 'Banner - K50,000/month'),
            ),
          ],
        ),
      ),
    );
  }
}
