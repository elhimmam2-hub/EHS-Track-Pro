import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EHSTrackProApp());
}

class EHSTrackProApp extends StatefulWidget {
  const EHSTrackProApp({super.key});

  @override
  State<EHSTrackProApp> createState() => _EHSTrackProAppState();
}

class _EHSTrackProAppState extends State<EHSTrackProApp> {
  Locale _currentLocale = const Locale('ar'); // Arabic Primary
  ThemeMode _themeMode = ThemeMode.light;

  void setLocale(Locale newLocale) {
    setState(() {
      _currentLocale = newLocale;
    });
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EHS Track Pro',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      supportedLocales: const [
        Locale('ar'), // Arabic RTL (Primary)
        Locale('en'), // English LTR
        Locale('fr'), // French LTR
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme(_currentLocale.languageCode),
      darkTheme: AppTheme.darkTheme(_currentLocale.languageCode),
      themeMode: _themeMode,
      home: HomeScreen(
        currentLocale: _currentLocale,
        onLocaleChange: setLocale,
        onThemeToggle: toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChange;
  final VoidCallback onThemeToggle;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChange,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isAr = widget.currentLocale.languageCode == 'ar';

    final screens = [
      _buildDashboardView(isAr),
      _buildIncidentPlaceholder(isAr),
      _buildCAPAPlaceholder(isAr),
      _buildAuditPlaceholder(isAr),
      _buildFormsPlaceholder(isAr),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primaryEcoGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.verified_user, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              isAr ? 'إي إتش إس تراك برو' : 'EHS Track Pro',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          // Language switcher
          PopupMenuButton<String>(
            icon: const Icon(Icons.translate),
            onSelected: (lang) => widget.onLocaleChange(Locale(lang)),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'ar', child: Text('العربية (Arabic RTL)')),
              const PopupMenuItem(value: 'en', child: Text('English (LTR)')),
              const PopupMenuItem(value: 'fr', child: Text('Français (LTR)')),
            ],
          ),
          // Visual comfort theme switcher
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: 'Visual Comfort Mode',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: isAr ? 'الرئيسية' : 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.report_problem_outlined),
            activeIcon: const Icon(Icons.report_problem),
            label: isAr ? 'الحوادث' : 'Incidents',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_turned_in_outlined),
            activeIcon: const Icon(Icons.assignment_turned_in),
            label: isAr ? 'CAPA' : 'CAPA',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fact_check_outlined),
            activeIcon: const Icon(Icons.fact_check),
            label: isAr ? 'التدقيق' : 'Audits',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description_outlined),
            activeIcon: const Icon(Icons.description),
            label: isAr ? 'النماذج' : 'Forms/PTW',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardView(bool isAr) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Welcome Card
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAr ? 'مرحباً بعودتك' : 'Welcome back',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        Text(
                          isAr ? 'م. سارة المنصور' : 'Eng. Sarah Al-Mansoor',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          isAr ? 'مفتش معتمد للصحة والسلامة (Lead Auditor)' : 'Lead EHS Auditor',
                          style: const TextStyle(fontSize: 12, color: AppTheme.secondaryLight),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppTheme.primaryLight,
                      child: Icon(Icons.person, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 8,
                    backgroundColor: Color(0xFFE0E9F2),
                    color: AppTheme.primaryEcoGreen,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isAr ? '80% اكتمال مهام اليوم الميدانية' : '80% of daily field tasks completed',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Offline Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.tertiaryAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.sync, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAr ? 'الوضع الميداني نشط (Offline Ready)' : 'Offline Mode Active',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Text(
                      isAr ? '3 تقارير تفتيش محفوظة محلياً بانتظار المزامنة' : '3 inspection logs cached locally',
                      style: const TextStyle(color: Color(0xFFC7E7FF), fontSize: 11),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC7E7FF),
                  foregroundColor: const Color(0xFF001E2E),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                ),
                child: Text(isAr ? 'مزامنة' : 'Sync', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),

        // KPI 2x2 Grid
        Text(
          isAr ? 'مؤشرات الأداء الرئيسية (KPIs)' : 'Key Performance Indicators',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.35,
          children: [
            _kpiCard(isAr ? 'معدل تكرار الإصابات (LTIFR)' : 'LTIFR Rate', '0.18', '-14%', Icons.trending_down, Colors.green),
            _kpiCard(isAr ? 'نسبة الامتثال (ISO 45001)' : 'Compliance Score', '96.4%', 'ممتاز', Icons.gavel, Colors.blue),
            _kpiCard(isAr ? 'ساعات عمل آمنة' : 'Safe Man-Hours', '1.84M', '+250k', Icons.timer, Colors.amber),
            _kpiCard(isAr ? 'سرعة إغلاق الإجراءات' : 'CAPA Velocity', '92.8%', '2.1 d', Icons.speed, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _kpiCard(String title, String value, String badge, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 22),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: Text(badge, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentPlaceholder(bool isAr) => Center(child: Text(isAr ? 'وحدة الإبلاغ عن الحوادث والمخاطر' : 'Incident & Hazard Tracker'));
  Widget _buildCAPAPlaceholder(bool isAr) => Center(child: Text(isAr ? 'وحدة إدارة الإجراءات التصحيحية CAPA' : 'CAPA Management'));
  Widget _buildAuditPlaceholder(bool isAr) => Center(child: Text(isAr ? 'وحدة جولات التفتيش والتدقيق الميداني' : 'Audit & Field Inspections'));
  Widget _buildFormsPlaceholder(bool isAr) => Center(child: Text(isAr ? 'وحدة النماذج الذكية وتصاريح PTW والتوقيع الرقمي' : 'Smart Forms & E-Permits'));
}
