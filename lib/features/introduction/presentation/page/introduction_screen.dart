import 'package:aquanotes/theme/colors.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  static const routeName = "/introduction";

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<String> introductionImage = [
    'assets/images/introduction/1.png',
    'assets/images/introduction/2.png',
  ];

  final List<String> introductionTitle = [
    'Optimalkan Budidaya dengan Sistem Manajemen Aquanotes',
    'Dengan Aquanotes Manajemen Budidaya Kini Lebih Mudah',
  ];

  final List<String> introductionComment = [
    'Dengan teknologi sensor cerdas berbasis Internet of Things dan Kecerdasan Buatan, Petani dapat mengoptimalkan manajemen budidaya.',
    'Aquanotes hadir sebagai Sistem cerdas manajemen budidaya dalam satu genggaman dengan mobile app.',
  ];

  int introductionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          // Animated Image Transition
          Expanded(
            flex: 1,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SizedBox(
                key: ValueKey<int>(introductionIndex),
                width: double.infinity,
                child: Image(
                  image: AssetImage(introductionImage[introductionIndex]),
                  fit: BoxFit
                      .cover, // Ensures it fills the width while maintaining aspect ratio
                ),
              ),
            ),
          ),

          // Title, Comment, and Navigation Dots
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Navigation Dots
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              List.generate(introductionImage.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  introductionIndex = index;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: index == 1 ? 16.0 : 0.0,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == introductionIndex
                                        ? AppColors.primary
                                        : AppColors.mediumGray,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Title
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Text.rich(
                              key: ValueKey<int>(
                                  introductionIndex), // Ensure animation works per index
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: introductionTitle[introductionIndex]
                                        .split('Aquanotes')[0],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black, // Default color for surrounding text
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Aquanotes',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors
                                          .primary, // Blue color for "Aquanotes"
                                    ),
                                  ),
                                  TextSpan(
                                    text: introductionTitle[introductionIndex]
                                                .split('Aquanotes')
                                                .length >
                                            1
                                        ? introductionTitle[introductionIndex]
                                            .split('Aquanotes')[1]
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .black, // Default color for text after "Aquanotes"
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),

                        // Comment
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            introductionComment[introductionIndex],
                            key: ValueKey<int>(introductionIndex),
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mediumGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gradientEnd,
                        foregroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (introductionIndex <
                              introductionImage.length - 1) {
                            introductionIndex++;
                          } else {
                            // Navigate to the next screen
                            Navigator.of(context)
                                .pushReplacementNamed("/welcome");
                          }
                        });
                      },
                      child: Text(
                        introductionIndex < introductionImage.length - 1
                            ? 'Lanjut'
                            : 'Selesai',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
