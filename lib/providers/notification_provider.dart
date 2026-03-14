import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';

class NotificationsNotifier extends Notifier<List<NotificationModel>> {
  @override
  List<NotificationModel> build() {
    // Para a Fase 6, as notificações reais ainda serão implementadas
    // via Realtime do Supabase. Por enquanto, retornamos uma lista vazia.
    return [];
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id) n.copyWith(isRead: true) else n,
    ];
  }

  void markAllAsRead() {
    state = [
      for (final n in state) n.copyWith(isRead: true),
    ];
  }

  void removeNotification(String id) {
    state = state.where((n) => n.id != id).toList();
  }
}

final notificationsProvider = NotifierProvider<NotificationsNotifier, List<NotificationModel>>(NotificationsNotifier.new);

final unreadNotificationsCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).where((n) => !n.isRead).length;
});
