import '../models/notification_model.dart';

class MockNotificationService {
  static List<NotificationModel> getNotifications() {
    return [
      NotificationModel(
        id: '1',
        title: 'Nova Conquista!',
        message: 'Você desbloqueou o badge "Velocista". Parabéns!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        type: NotificationType.conquest,
        relatedId: '2',
      ),
      NotificationModel(
        id: '2',
        title: 'Desafio Proposto',
        message: 'Complete 10km nesta semana para ganhar o badge "Resistência".',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.challenge,
      ),
      NotificationModel(
        id: '3',
        title: 'Território em Perigo',
        message: 'Rafael S. está correndo perto da sua área no Parque Ibirapuera.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        type: NotificationType.social,
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Atualização do Sistema',
        message: 'Novos territórios foram adicionados na zona sul. Explore agora!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.system,
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Ranking Semanal',
        message: 'Você subiu para a 5ª posição no ranking de SP!',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.social,
        isRead: true,
      ),
    ];
  }
}
