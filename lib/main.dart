import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF007AFF), // iOS Blue
              brightness: Brightness.light,
            ).copyWith(
              primary: const Color(0xFF007AFF),
              secondary: const Color(0xFF5856D6),
              tertiary: const Color(0xFFFF9500),
              surface: const Color(0xFFF2F2F7),
              surfaceContainerHighest: const Color(0xFFFFFFFF),
              onSurface: const Color(0xFF1C1C1E),
              onSurfaceVariant: const Color(0xFF3A3A3C),
              primaryContainer: const Color(0xFFE5F4FF),
              onPrimaryContainer: const Color(0xFF003A6B),
            ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            height: 1.1,
            letterSpacing: -0.5,
          ),
          headlineMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.3,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.3,
            letterSpacing: -0.2,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.1,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.1,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const ModernHomePage(),
    );
  }
}

class ModernHomePage extends StatefulWidget {
  const ModernHomePage({super.key});

  @override
  State<ModernHomePage> createState() => _ModernHomePageState();
}

class _ModernHomePageState extends State<ModernHomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildHeroSection(context),
            _buildFeaturesSection(context),
            _buildStatsSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        child: isMobile
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ModernApp',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Add drawer functionality here
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Features'),
                      ),
                      TextButton(onPressed: () {}, child: const Text('About')),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007AFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text('Get Started'),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ModernApp',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Features'),
                      ),
                      const SizedBox(width: 16),
                      TextButton(onPressed: () {}, child: const Text('About')),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Get Started'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 16
            : isTablet
            ? 32
            : 48,
        vertical: isMobile ? 40 : 80,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  '✨ Welcome to the Future',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF007AFF),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              Text(
                isMobile
                    ? 'Build Amazing Experiences'
                    : 'Build Amazing\nExperiences',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile
                      ? 32
                      : isTablet
                      ? 40
                      : 48,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Text(
                isMobile
                    ? 'Create beautiful, modern applications with our powerful and intuitive development platform.'
                    : 'Create beautiful, modern applications with our powerful\nand intuitive development platform.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: isMobile ? 16 : 18,
                ),
              ),
              SizedBox(height: isMobile ? 32 : 40),
              isMobile
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style:
                                ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007AFF),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ).copyWith(
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.white.withOpacity(0.1),
                                  ),
                                ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF007AFF),
                              backgroundColor: Colors.white.withOpacity(0.8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              side: BorderSide(
                                color: const Color(0xFF007AFF).withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              'Learn More',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style:
                              ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007AFF),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ).copyWith(
                                overlayColor: WidgetStateProperty.all(
                                  Colors.white.withOpacity(0.1),
                                ),
                              ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF007AFF),
                            backgroundColor: Colors.white.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: const Color(0xFF007AFF).withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final features = [
      {
        'icon': Icons.rocket_launch,
        'title': 'Fast Performance',
        'description':
            'Lightning-fast performance with optimized rendering and efficient memory usage.',
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Reliable',
        'description':
            'Built with security in mind, ensuring your data is always protected.',
      },
      {
        'icon': Icons.palette,
        'title': 'Beautiful Design',
        'description':
            'Modern, clean interface that provides an exceptional user experience.',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 16
            : isTablet
            ? 32
            : 48,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Why Choose Us?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 24 : 32,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Discover the features that make us stand out',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: isMobile ? 16 : 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 32 : 64),
          isMobile
              ? Column(
                  children: features.map((feature) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF007AFF).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              feature['icon'] as IconData,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            feature['title'] as String,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 20,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            feature['description'] as String,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : isTablet
              ? Column(
                  children: [
                    Row(
                      children: features.take(2).map((feature) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    feature['icon'] as IconData,
                                    size: 28,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  feature['title'] as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        fontSize: 18,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  feature['description'] as String,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                        fontSize: 14,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF007AFF).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              features[2]['icon'] as IconData,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            features[2]['title'] as String,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 18,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            features[2]['description'] as String,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  children: features.map((feature) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                feature['icon'] as IconData,
                                size: 32,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              feature['title'] as String,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              feature['description'] as String,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    final stats = [
      {'value': '10K+', 'label': 'Happy Users'},
      {'value': '99.9%', 'label': 'Uptime'},
      {'value': '24/7', 'label': 'Support'},
      {'value': '50+', 'label': 'Features'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 16
            : isTablet
            ? 32
            : 48,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF007AFF).withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.05), width: 0.5),
          bottom: BorderSide(color: Colors.black.withOpacity(0.05), width: 0.5),
        ),
      ),
      child: isMobile
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats.take(2).map((stat) {
                    return Expanded(
                      child: _buildStatItem(
                        context,
                        stat['value']!,
                        stat['label']!,
                        isMobile: true,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats.skip(2).map((stat) {
                    return Expanded(
                      child: _buildStatItem(
                        context,
                        stat['value']!,
                        stat['label']!,
                        isMobile: true,
                      ),
                    );
                  }).toList(),
                ),
              ],
            )
          : isTablet
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats.take(2).map((stat) {
                    return Expanded(
                      child: _buildStatItem(
                        context,
                        stat['value']!,
                        stat['label']!,
                        isMobile: false,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats.skip(2).map((stat) {
                    return Expanded(
                      child: _buildStatItem(
                        context,
                        stat['value']!,
                        stat['label']!,
                        isMobile: false,
                      ),
                    );
                  }).toList(),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: stats.map((stat) {
                return Expanded(
                  child: _buildStatItem(
                    context,
                    stat['value']!,
                    stat['label']!,
                    isMobile: false,
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label, {
    required bool isMobile,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 24 : 32,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 12 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 24 : 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.1), width: 0.5),
        ),
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    Text(
                      'ModernApp',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.facebook),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.alternate_email),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.work),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ModernApp',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.facebook),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.alternate_email),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.work),
                        ),
                      ],
                    ),
                  ],
                ),
          SizedBox(height: isMobile ? 16 : 24),
          const Divider(),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            '© 2025 ModernApp. All rights reserved.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: isMobile ? 12 : 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
