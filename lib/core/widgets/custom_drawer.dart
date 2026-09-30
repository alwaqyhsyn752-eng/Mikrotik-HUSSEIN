import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final seed = theme.colorScheme.primary;
    final appName = const String.fromEnvironment('APP_NAME', defaultValue: 'HUSSEIN Net');

    return Drawer(
      backgroundColor: const Color(0xFF080A12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: seed.withOpacity(0.35), width: 1),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // رأس القائمة
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [seed, seed.withOpacity(0.4)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: seed.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(Icons.bolt,
                          color: Colors.black, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: seed,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: seed,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'متصل',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: seed,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      seed.withOpacity(0),
                      seed.withOpacity(0.6),
                      seed.withOpacity(0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // العناصر
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 4),
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
              // التذييل
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: seed.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'تصميم وتطوير',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    ShaderMask(
                      shaderCallback: (r) => LinearGradient(
                        colors: [seed, Colors.white, seed],
                      ).createShader(r),
                      child: const Text(
                        'حسين غلاب',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: seed.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: seed.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone, size: 12, color: seed),
                          const SizedBox(width: 4),
                          Text(
                            '738660998',
                            style: TextStyle(
                              fontSize: 11,
                              color: seed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatefulWidget {
  final IconData icon;
  final String title;
  const _DrawerItem({required this.icon, required this.title});

  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.title} - قريباً'),
              backgroundColor: const Color(0xFF0B0E18),
            ),
          );
        },
        onHover: (v) => setState(() => _hover = v),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _hover
                ? seed.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hover
                  ? seed.withOpacity(0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(widget.icon, size: 22, color: seed),
              const SizedBox(width: 14),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
