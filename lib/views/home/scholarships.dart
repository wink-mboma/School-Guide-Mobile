import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_guide/controllers/scholarship_controller.dart';
import 'package:school_guide/models/scholarship_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/scholarship_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:get/get.dart';

class Scholarships extends StatefulWidget {
  const Scholarships({Key? key}) : super(key: key);

  @override
  State<Scholarships> createState() => _ScholarshipsState();
}

class _ScholarshipsState extends State<Scholarships> {
  int? destinationSelectedIndex = 0;
  int? levelSelectedIndex = 0;
  final ScholarshipController scholarshipController = Get.find();

  List<ScholarshipDetails> selectedScholarships = [];
  void getScholarship({required String destination, required String level}) {
    selectedScholarships.clear();
    scholarshipController.allScholarships.forEach((scholarship) {
      if (destination.toLowerCase() == 'all' && scholarship.level.toLowerCase() == level.toLowerCase()) {
        setState(() {
          selectedScholarships.add(scholarship);
        });
      } else if (level.toLowerCase() == 'all' && scholarship.destination.toLowerCase() == destination.toLowerCase()) {
        setState(() {
          selectedScholarships.add(scholarship);
        });
      } else if (scholarship.destination.toLowerCase() == destination.toLowerCase() && scholarship.level.toLowerCase() == level.toLowerCase()) {
        setState(() {
          selectedScholarships.add(scholarship);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: scholarshipController.allScholarships.isEmpty
            ? Container(
                height: Get.size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
                    ),
                    CustomText('We do not have scholarships at present! Try again later.', textAlign: TextAlign.center, needsIcon: false, color: Colors.black38)
                  ],
                ),
              )
            : CustomBody(
                text: 'Scholarships',
                children: [
                  const TopBlackText(text: 'DESTINATION'),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: 38,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: destinations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 4.0,
                                      top: 4.0,
                                      bottom: 4.0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();
                                        setState(() {
                                          destinationSelectedIndex = index;
                                        });
                                        getScholarship(destination: destinations.elementAt(destinationSelectedIndex!), level: levels.elementAt(levelSelectedIndex!));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: destinationSelectedIndex == index ? AppColors.primaryColor : AppColors.white,
                                          border: Border.all(color: destinationSelectedIndex != index ? AppColors.primaryColor : Colors.transparent, width: 2),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Center(
                                            child: Text(
                                              destinations[index],
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: destinationSelectedIndex == index ? AppColors.white : AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                levelSelectedIndex = 0;
                                destinationSelectedIndex = 0;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: TopBlackText(text: 'LEVEL OF STUDY'),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: levels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 4.0,
                              top: 4.0,
                              bottom: 4.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.vibrate();
                                setState(() {
                                  levelSelectedIndex = index;
                                });
                                getScholarship(destination: destinations.elementAt(destinationSelectedIndex!), level: levels.elementAt(levelSelectedIndex!));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: levelSelectedIndex == index ? AppColors.primaryColor : AppColors.white,
                                  border: Border.all(color: levelSelectedIndex != index ? AppColors.primaryColor : Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Center(
                                    child: Text(
                                      levels[index],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: levelSelectedIndex == index ? AppColors.white : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: destinationSelectedIndex == 0 && levelSelectedIndex == 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: scholarshipController.allScholarships.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ScholarshipCard(
                                scholarship: scholarshipController.allScholarships[index],
                              );
                            })
                        : selectedScholarships.isEmpty
                            ? Container(
                                height: Get.size.height / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: AssetImage(AppImages.logo))),
                                    ),
                                    CustomText('No items match your filter!', needsIcon: false, color: Colors.black38)
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: selectedScholarships.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ScholarshipCard(
                                    scholarship: selectedScholarships[index],
                                  );
                                },
                              ),
                  ),
                ],
              ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}

List<String> destinations = [
  'All',
  'Local',
  'International',
];
List<String> levels = ['All', 'Primary', 'High School', 'Tertiary'];
