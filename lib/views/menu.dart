import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/menu/about_us.dart';
import 'package:school_guide/views/menu/advertise_school.dart';
import 'package:school_guide/views/menu/become_a_tutor.dart';
import 'package:school_guide/views/menu/become_an_agent.dart';
import 'package:school_guide/views/menu/curricula.dart';
import 'package:school_guide/views/menu/premium.dart';
import 'package:school_guide/views/widgets/back_exit.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/menu_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Exitable(
      child: Scaffold(
        appBar: CustomAppBar(
          backIconAvailable: false,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Menu',
          children: [
            SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    MenuCardItem(
                      onTap: () {
                        Get.to(() => Curricula());
                      },
                      icon: Icons.book,
                      text: 'Curricula',
                    ),
                    MenuCardItem(
                      onTap: () {
                        Get.to(() => Premium());
                      },
                      text: 'Premium',
                      icon: Icons.workspace_premium_outlined,
                    ),
                    MenuCardItem(
                        onTap: () {
                          String link = "https://play.google.com/store/apps/details?id=com.school.guide.malawi&hl=en&gl=US&pli=1";
                          Share.share(
                            'Hello there!! did you know you can access the best schools to enroll into and view latest scholarships using the School Guide App? Tap on this link $link to download the app.',
                            subject: 'Share School Guide App',
                          );
                        },
                        icon: Icons.share,
                        text: 'Share app'),
                    MenuCardItem(
                        onTap: () {
                          Get.to(() => AboutUs());
                        },
                        icon: Icons.info_outline,
                        text: 'About us'),
                    SizedBox(height: 20),
                    TopText(text: 'Tutoring', fontSize: 16),
                    SizedBox(height: 10),
                    MenuCardItem(
                        onTap: () {
                          Get.to(() => BecomeATutor());
                        },
                        icon: Icons.person_add_sharp,
                        text: 'Become a tutor.'),
                    SizedBox(height: 20),
                    TopText(text: 'Advertisement', fontSize: 16),
                    SizedBox(height: 10),
                    MenuCardItem(
                        onTap: () {
                          Get.to(() => AdvertiseBusiness());
                        },
                        icon: Icons.branding_watermark,
                        text: 'Advertise your business with us.'),
                    SizedBox(height: 20),
                    TopText(text: 'Agents', fontSize: 16),
                    SizedBox(height: 10),
                    MenuCardItem(
                      onTap: () {
                        Get.to(() => BecomeAnAgent());
                      },
                      text: 'Become an agent',
                      icon: Icons.support_agent,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          String link = "https://play.google.com/store/apps/details?id=com.school.guide.malawi&hl=en&gl=US&pli=1";

                          launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
                        },
                        child: CustomText('v2.0.23+7', pLeft: 0, pTop: 0, pBottom: 0, mainAxisAlignment: MainAxisAlignment.center, icon: Icons.phone_android, color: AppColors.primaryColor)),
                  ],
                ),
                SizedBox(height: 16),
              ]),
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
      ),
    );
  }

  void displayDialog() {
    Get.defaultDialog(
      title: 'Talk to us',
      confirm: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.vibrate();
              launchUrl(Uri.parse(''), mode: LaunchMode.externalApplication);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'WhatsApp',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.vibrate();
              launchUrl(Uri.parse('tel:+265996372203'));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: Icon(
                        FontAwesomeIcons.phone,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    ),
                    Text(
                      'Phone Call',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              FontAwesomeIcons.headset,
              color: AppColors.primaryColor,
              size: 50,
            ),
          ),
          const Text(
            'Click any button below to get in touch with us now.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
