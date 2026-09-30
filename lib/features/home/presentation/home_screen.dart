import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/aurora_background.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../../../core/widgets/glass_card.dart';
import '../widgets/speed_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final appName =
        const String.fromEnvironment('APP_NAME', defaultValue: 'HUSSEIN Net');

    return AuroraBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              ShaderMask(
                shaderCallback: (r) => LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Colors.white,
                  ],
                ).createShader(r),
                child: Text(
                  appName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: NetworkSpeedIndicator(),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: _buildPage(_idx),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.2),
                blurRadius: 20,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: NavigationBar(
              selectedIndex: _idx,
              onDestinationSelected: (i) => setState(() => _idx = i),
              backgroundColor: const Color(0xFF0B0E18).withValues(alpha: 0.92),
              height: 68,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'الرئيسية',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_outlined),
                  selectedIcon: Icon(Icons.notifications),
                  label: 'الإشعارات',
                ),
                NavigationDestination(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                  selectedIcon: Icon(Icons.admin_panel_settings),
                  label: 'الإدارة',
                ),
                NavigationDestination(
                  icon: Icon(Icons.speed_outlined),
                  selectedIcon: Icon(Icons.speed),
                  label: 'السرعة',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int i) {
    switch (i) {
      case 0:
        return const _HomeTab();
      default:
        return const _EmptyTab();
    }
  }
}

class _EmptyTab extends StatelessWidget {
  const _EmptyTab();
  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: seed.withValues(alpha: 0.4), width: 2),
              boxShadow: [
                BoxShadow(color: seed.withValues(alpha: 0.4), blurRadius: 30),
              ],
            ),
            child: Icon(Icons.construction, size: 56, color: seed),
          ),
          const SizedBox(height: 20),
          Text(
            'قريباً',
            style: TextStyle(
              fontSize: 18,
              color: seed,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    final appName =
        const String.fromEnvironment('APP_NAME', defaultValue: 'HUSSEIN Net');

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رسالة الترحيب
          Text(
            'أهلاً بك في',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.6),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          ShaderMask(
            shaderCallback: (r) => LinearGradient(
              colors: [seed, Colors.white, seed],
            ).createShader(r),
            child: Text(
              appName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // شاشة الإعلانات
          GlassCard(
            padding: EdgeInsets.zero,
            radius: 22,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    seed.withValues(alpha: 0.35),
                    const Color(0xFF7C4DFF).withValues(alpha: 0.25),
                    seed.withValues(alpha: 0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: seed.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: seed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'عرض جديد',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'باقات إنترنت فائقة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'سرعات تصل إلى 100 Mbps',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // المحفظة
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: seed.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: seed.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Icon(Icons.account_balance_wallet,
                          color: seed, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'المحفظة الإلكترونية',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _WalletAction(icon: Icons.swap_horiz, label: 'حول'),
                    _WalletAction(icon: Icons.shopping_cart, label: 'اشتري'),
                    _WalletAction(icon: Icons.add_card, label: 'اشحن'),
                    _WalletAction(icon: Icons.people, label: 'أصدقاء'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // زر تسجيل بكرت
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            onTap: () {},
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [seed, seed.withValues(alpha: 0.5)]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: seed.withValues(alpha: 0.5),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.credit_card,
                      color: Colors.black, size: 22),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تسجيل الدخول بكرت',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'ادخل بيانات الكرت للاتصال',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14, color: seed),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // الخدمات
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: seed,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(color: seed, blurRadius: 8),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'الخدمات',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
            children: const [
              _ServiceCard(icon: Icons.hourglass_empty, title: 'قريباً'),
              _ServiceCard(icon: Icons.live_tv, title: 'البث المباشر'),
              _ServiceCard(icon: Icons.smart_toy, title: 'Net AI'),
              _ServiceCard(icon: Icons.emoji_events, title: 'البطولات'),
              _ServiceCard(icon: Icons.handshake, title: 'سلفني'),
              _ServiceCard(icon: Icons.card_giftcard, title: 'تسجيل بكرت'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _WalletAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: seed.withValues(alpha: 0.1),
            border: Border.all(color: seed.withValues(alpha: 0.5), width: 1),
            boxShadow: [
              BoxShadow(color: seed.withValues(alpha: 0.3), blurRadius: 12),
            ],
          ),
          child: Icon(icon, color: seed, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ServiceCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return GlassCard(
      padding: const EdgeInsets.all(10),
      radius: 18,
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: seed.withValues(alpha: 0.12),
              border: Border.all(color: seed.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: seed.withValues(alpha: 0.25),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: seed),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
