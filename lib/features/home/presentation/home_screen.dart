import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_drawer.dart';
import '../widgets/speed_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appName = const String.fromEnvironment('APP_NAME', defaultValue: 'شبكتي');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.wifi, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(appName, style: theme.textTheme.titleLarge),
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
      body: _buildPage(_currentIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
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
            label: 'سرعة النت',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const _HomeTab();
      case 1:
        return const _EmptyTab(title: 'الإشعارات');
      case 2:
        return const _EmptyTab(title: 'الإدارة');
      case 3:
        return const _EmptyTab(title: 'قياس السرعة');
      default:
        return const _HomeTab();
    }
  }
}

class _EmptyTab extends StatelessWidget {
  final String title;
  const _EmptyTab({required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction,
              size: 64, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text('$title - قريباً',
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appName = const String.fromEnvironment('APP_NAME', defaultValue: 'شبكتي');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'أهلاً بك في تطبيق $appName',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // شاشة الإعلانات
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.campaign,
                      size: 48, color: theme.colorScheme.onPrimary),
                  const SizedBox(height: 8),
                  Text('الإعلانات والعروض',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // المحفظة
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('المحفظة الإلكترونية',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
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
          ),
          const SizedBox(height: 16),
          // زر تسجيل الدخول بكرت
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.credit_card),
              label: const Text('تسجيل الدخول بكرت'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('الخدمات',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 12),
          // شبكة الخدمات
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
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
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
        ),
        const SizedBox(height: 6),
        Text(label, style: theme.textTheme.labelSmall),
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
    final theme = Theme.of(context);
    return Card(
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(height: 8),
          Text(title,
              style: theme.textTheme.labelMedium,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
