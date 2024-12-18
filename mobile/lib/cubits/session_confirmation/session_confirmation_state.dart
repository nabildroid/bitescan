import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/shoppingSession.dart';
import 'package:equatable/equatable.dart';

class SessionConfirmationState extends Equatable {
  final List<Food> foods;
  final List<Shoppingsession> sessions;

  final List<Shoppingsession> sessionsUnderReview;

  List<Food> get queue {
    final codes = <String>{}
      ..addAll(sessionsUnderReview.fold<List<String>>([], (acc, v) {
        return acc..addAll(v.visitedFoodCodes);
      }));

    final q = codes.map((code) {
      try {
        final isAlreadyConfirmed = sessionsUnderReview.any((s) =>
            s.confirmedFoodCodes != null &&
            s.confirmedFoodCodes!.any((e) => e.code == code));

        if (isAlreadyConfirmed) return null;

        return foods.firstWhere((e) => e.code == code);
      } catch (e) {
        return null;
      }
    }).toList();

    q.removeWhere((e) => e == null);

    return q.cast();
  }

  const SessionConfirmationState({
    required this.foods,
    required this.sessions,
    required this.sessionsUnderReview,
  });

  const SessionConfirmationState.inital()
      : foods = const [],
        sessionsUnderReview = const [],
        sessions = const [];

  SessionConfirmationState copyWith({
    List<Food>? foods,
    List<Shoppingsession>? sessions,
    List<Shoppingsession>? sessionsUnderReview,
  }) {
    return SessionConfirmationState(
      foods: foods ?? this.foods,
      sessions: sessions ?? this.sessions,
      sessionsUnderReview: sessionsUnderReview ?? this.sessionsUnderReview,
    );
  }

  @override
  List<Object?> get props => [...foods, ...sessionsUnderReview, ...sessions];
}
