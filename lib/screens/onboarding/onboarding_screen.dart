import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "icon": Icons.local_hospital,
      "title": "Find Trusted Doctors",
      "subtitle":
          "Consult experienced doctors anytime, anywhere with Carefinity.",
      "color": Colors.blue,
    },
    {
      "icon": Icons.biotech,
      "title": "Book Lab Tests",
      "subtitle":
          "Schedule diagnostic tests from trusted laboratories near you.",
      "color": Colors.teal,
    },
    {
      "icon": Icons.smart_toy,
      "title": "AI Health Assistant",
      "subtitle":
          "Get AI-powered health guidance and symptom assistance instantly.",
      "color": Colors.deepPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Login screen later
                },
                child: const Text("Skip"),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              (page["color"] as Color).withOpacity(0.1),
                          child: Icon(
                            page["icon"],
                            size: 70,
                            color: page["color"],
                          ),
                        ),

                        const SizedBox(height: 40),

                        Text(
                          page["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          page["subtitle"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 25 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Colors.blue
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage < pages.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const LoginScreen(),
  ),
);
                  }
                },
                child: Text(
                  currentPage == pages.length - 1
                      ? "Get Started"
                      : "Next",
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}