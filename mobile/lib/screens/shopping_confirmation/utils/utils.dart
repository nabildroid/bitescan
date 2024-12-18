import 'package:bitescan/services/local_notification_service.dart';

class SessionConfirmationNotification extends NotificationEvent<String?> {
  @override
  int get id => 1212;

  @override
  handlePayload(String? payload) => payload;
}
