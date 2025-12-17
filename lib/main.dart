import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio - AFNAN',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFFF5F0),
      ),
      debugShowCheckedModeBanner: false,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHeroSection(context),
            _buildStatsSection(context),
            _buildServicesSection(context),
            _buildExperienceSection(context),
            _buildPortfolioSection(context),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Launch URL helper
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Show contact info toast
  void _showContactInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Contact Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactRow(Icons.email, 'Email:', 'asnuafnan@example.com'),
              const SizedBox(height: 16),
              _buildContactRow(Icons.phone, 'Phone:', '+91 9778368160'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 18),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$label copied to clipboard'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.orange,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'AFNXN0099_',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          if (isDesktop)
            Row(
              children: [
                _buildNavItem('Home', true, null),
                _buildNavItem('Linked-in', false, 'https://www.linkedin.com/in/afnan-asnu0099/'),
                _buildNavItem('Github', false, 'https://github.com/afnxn099'),
                _buildNavItem('Figma', false, 'https://https://www.figma.com/files/team/1218130360177908757/recents-and-sharing?fuid=1218130346032510957'),
                _buildNavItem('Contact', false, null, isContact: true),
              ],
            )
          else
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, bool isActive, String? url, {bool isContact = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          if (isContact) {
            _showContactInfo();
          } else if (url != null) {
            _launchURL(url);
          }
        },
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.orange : const Color(0xFF64748B),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: isDesktop
          ? Row(
        children: [
          Expanded(child: _buildHeroContent()),
          const SizedBox(width: 60),
          Expanded(child: _buildHeroImage()),
        ],
      )
          : Column(
        children: [
          _buildHeroImage(),
          const SizedBox(height: 40),
          _buildHeroContent(),
        ],
      ),
    );
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HI, I\'m',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'AFNAN A',
          style: TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Flutter & Ui Designer',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Flutter Developer and UI Designer with a passion for building responsive, scalable, and user-focused mobile applications. I combine clean UI design with efficient Flutter development to deliver smooth and engaging user experiences.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF64748B),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('CV download will start soon!'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Download CV'),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: _showContactInfo,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Contact'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 400,
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 380,
          height: 480,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            'assets/images/pro.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 40,
      ),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.emoji_events, '3 years', 'UI/UX Design'),
          _buildStatItem(Icons.description, '5+ Projects', 'Completed'),
          _buildStatItem(Icons.support_agent, 'Online 24/7', 'Support'),
        ],
      )
          : Column(
        children: [
          _buildStatItem(Icons.emoji_events, '8 years job', 'Experience'),
          const SizedBox(height: 30),
          _buildStatItem(Icons.description, '500+ Projects', 'Completed'),
          const SizedBox(height: 30),
          _buildStatItem(Icons.support_agent, 'Online 24/7', 'Support'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            'Services',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'I Provide Wide Range\nOf Services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 60),
          isDesktop
              ? Row(
            children: [
              Expanded(child: _buildServiceCard('UI/UX Design', Colors.purple, Icons.brush)),
              const SizedBox(width: 24),
              Expanded(child: _buildServiceCard('Web Design', Colors.amber, Icons.language)),
              const SizedBox(width: 24),
              Expanded(child: _buildServiceCard('Design to code', Colors.pink, Icons.code)),
              const SizedBox(width: 24),
              Expanded(child: _buildServiceCard('Flutter Development', Colors.cyan, Icons.phone_android)),
            ],
          )
              : Column(
            children: [
              _buildServiceCard('UI/UX Design', Colors.purple, Icons.brush),
              const SizedBox(height: 24),
              _buildServiceCard('Web Design', Colors.amber, Icons.language),
              const SizedBox(height: 24),
              _buildServiceCard('Design to code', Colors.pink, Icons.campaign),
              const SizedBox(height: 24),
              _buildServiceCard('Flutter Development', Colors.cyan, Icons.phone_android),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Flutter Developer & UI Designer with hands-on experience in building responsive, user-focused mobile applications.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            'Why Choose Me',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'My Experience Area',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 60),
          isDesktop
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildSkillBar('Ui Designing', 0.99),
                    _buildSkillBar('Mobile App Designing', 0.99),
                    _buildSkillBar('Product Designing', 0.99),
                    _buildSkillBar('Flutter Development', 0.92),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: Column(
                  children: [
                    _buildSkillBar('Dart Programming', 0.90),
                    _buildSkillBar('Graphic Design', 0.75),
                    _buildSkillBar('Web UI Design', 0.89),
                    _buildSkillBar('Web Development', 0.70),
                  ],
                ),
              ),
            ],
          )
              : Column(
            children: [
              _buildSkillBar('Facebook Marketing', 0.99),
              _buildSkillBar('Search Engine Optimization', 0.90),
              _buildSkillBar('Content Writing', 0.99),
              _buildSkillBar('Youtube Marketing', 0.72),
              _buildSkillBar('Affiliate Marketing', 0.90),
              _buildSkillBar('Graphic Design', 0.85),
              _buildSkillBar('Web UI Design', 0.49),
              _buildSkillBar('Web Design', 0.70),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBar(String skill, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    // Filter projects based on selected filter
    List<Map<String, String>> allProjects = [
      {
        'image': 'assets/images/pet.jpg',
        'title': 'Mobile grooming\npet care',
        'category': 'Flutter Development Project',
        'type': 'Flutter',
      },
      {
        'image': 'assets/images/slice.jpg',
        'title': 'Money Management\nApp',
        'category': 'Clone Project',
        'type': 'Flutter',
      },
      {
        'image': 'assets/images/salon.jpg',
        'title': 'Salon Appointment\nApp',
        'category': 'Flutter Development Project',
        'type': 'Flutter',
      },
      {
        'image': 'assets/images/ui1.jpg',
        'title': 'Ui concept\nApp',
        'category': 'Ui/Ux Design Project',
        'type': 'Ui/Ux',
      },
      {
        'image': 'assets/images/iii.jpg',
        'title': 'Ui concept\nPet care',
        'category': 'Ui/Ux Design Concept',
        'type': 'Ui/Ux',
      },
      {
        'image': 'assets/images/port.png',
        'title': 'Ui concept\nPortfolio',
        'category': 'Ui/Ux Design Concept',
        'type': 'Ui/Ux',
      },
    ];

    List<Map<String, String>> filteredProjects = selectedFilter == 'All'
        ? allProjects
        : allProjects.where((project) {
      if (selectedFilter == 'Ui/Ux') {
        return project['type'] == 'Ui/Ux';
      } else if (selectedFilter == 'Flutter') {
        return project['type'] == 'Flutter';
      }
      return false;
    }).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          const Text(
            'Portfolio',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'My Amazing Works',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFilterButton('All', selectedFilter == 'All'),
              _buildFilterButton('Ui/Ux', selectedFilter == 'Ui/Ux'),
              _buildFilterButton('Flutter', selectedFilter == 'Flutter'),
            ],
          ),
          const SizedBox(height: 60),
          filteredProjects.isEmpty
              ? Container(
            padding: const EdgeInsets.all(40),
            child: const Text(
              'No projects found for this category',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
          )
              : GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: isDesktop ? 1.0 : 1.2,
            children: filteredProjects
                .map((project) => _buildPortfolioItem(
              project['image']!,
              title: project['title'],
              category: project['category'],
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedFilter = text;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.orange : const Color(0xFF64748B),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioItem(String imagePath, {String? title, String? category}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            if (title != null || category != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (category != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}