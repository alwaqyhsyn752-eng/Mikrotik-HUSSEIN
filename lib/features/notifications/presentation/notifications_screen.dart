import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final bool unread;

  const NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    this.unread = false,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _items = [
    NotificationItem(
      title: 'تم تفعيل باقتك بنجاح',
      body: 'باقة 30 يوم - 10 ميجا. استمتع بالسرعة',
      time: 'قبل 5 دقائق',
      icon: Icons.check_circle,
      unread: true,
    ),
    NotificationItem(
      title: 'رصيدك على وشك الانتهاء',
      body: 'متبقٍ 2 جيجا فقط من الباقة الحالية',
      time: 'قبل ساعة',
      icon: Icons.warning_amber,
      unread: true,
    ),
    NotificationItem(
      title: 'عرض خاص',
      body: 'احصل على 50% خصم عند شحن 5000 ريال',
      time: 'أمس',
      icon: Icons.local_offer,
    ),
    NotificationItem(
      title: 'صيانة مجدولة',
      body: 'سيتم تحديث الشبكة يوم الجمعة 2-4 صباحاً',
      time: 'قبل 3 أيام',
      icon: Icons.build,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;

    if (_items.isEmpty) {
      return const Center(child: Text('لا توجد إشعارات'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final n = _items[i];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (n.unread ? seed : Colors.white)
                  .withOpacity(n.unread ? 0.5 : 0.15),
              width: 1,
            ),
            boxShadow: n.unread
                ? [
                    BoxShadow(
                      color: seed.withOpacity(0.25),
                      blurRadius: 14,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: seed.withOpacity(0.15),
                  border: Border.all(color: seed.withOpacity(0.4)),
                ),
                child: Icon(n.icon, color: seed, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (n.unread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: seed,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: seed, blurRadius: 6),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.body,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      n.time,
                      style: TextStyle(
                        color: seed.withOpacity(0.9),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
