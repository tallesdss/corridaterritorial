import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../providers/notification_provider.dart';
import '../theme/app_colors.dart';
import '../models/notification_model.dart';
import '../widgets/common/app_empty_state.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text(
          'Notificações',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          if (notifications.any((n) => !n.isRead))
            TextButton(
              onPressed: () => ref.read(notificationsProvider.notifier).markAllAsRead(),
              child: const Text('Ler todas'),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? const AppEmptyState(
              title: 'Tudo limpo por aqui',
              message: 'Você não tem notificações no momento. Continue conquistando territórios!',
              icon: Icons.notifications_none_outlined,
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(context, ref, notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, WidgetRef ref, NotificationModel notification) {
    IconData icon;
    Color color;

    switch (notification.type) {
      case NotificationType.conquest:
        icon = Icons.emoji_events;
        color = Colors.amber;
        break;
      case NotificationType.challenge:
        icon = Icons.flash_on;
        color = Colors.orange;
        break;
      case NotificationType.social:
        icon = Icons.people;
        color = Colors.blue;
        break;
      case NotificationType.system:
        icon = Icons.info_outline;
        color = Colors.purple;
        break;
    }

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(notificationsProvider.notifier).removeNotification(notification.id);
      },
      background: Container(
        color: AppColors.error.withValues(alpha: 0.8),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          ref.read(notificationsProvider.notifier).markAsRead(notification.id);
          // Potential navigation based on type
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: notification.isRead ? Colors.transparent : AppColors.primary.withValues(alpha: 0.05),
            border: const Border(
              bottom: BorderSide(color: AppColors.borderDefault, width: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.title,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          timeago.format(notification.timestamp, locale: 'pt_BR'),
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
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
