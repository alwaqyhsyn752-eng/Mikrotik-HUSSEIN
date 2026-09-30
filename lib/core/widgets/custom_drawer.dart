import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appName = const String.fromEnvironment('APP_NAME', defaultValue: 'شبكتي');

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(Icons.wifi,
                        color: theme.colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('مرحباً بك',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: const [
                  _DrawerItem(icon: Icons.credit_card, title: 'الدخول بكرت'),
                  _DrawerItem(icon: Icons.manage_accounts, title: 'إدارة الكرت'),
                  _DrawerItem(icon: Icons.live_tv, title: 'البث المباشر'),
                  _DrawerItem(icon: Icons.speed, title: 'اختبر سرعتك'),
                  _DrawerItem(icon: Icons.location_on, title: 'نقاط الخدمة'),
                  _DrawerItem(icon: Icons.inventory_2, title: 'الباقات'),
                  _DrawerItem(icon: Icons.menu_book, title: 'القرآن الكريم'),
                  _DrawerItem(icon: Icons.support_agent, title: 'أنا هنا للمساعدة'),
                  _DrawerItem(icon: Icons.handshake, title: 'سلفني'),
                  _DrawerItem(icon: Icons.refresh, title: 'تحديث الواجهة'),
                  _DrawerItem(icon: Icons.info_outline, title: 'حول التطبيق'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('تصميم وتطوير',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      )),
                  Text('حسين غلاب',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  Text('738660998',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      )),
                  const SizedBox(height: 4),
                  Text('الإصدار 1.0.0',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _DrawerItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        title: Text(title, style: theme.textTheme.bodyLarge),
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title - قريباً')),
          );
        },
      ),
    );
  }
}
