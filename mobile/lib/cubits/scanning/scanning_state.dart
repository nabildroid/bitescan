import 'package:bitescan/models/shoppingSession.dart';
import 'package:equatable/equatable.dart';

class ScanningState extends Equatable {
  final Set<Shoppingsession> shoppings;
  final Shoppingsession? session;

  const ScanningState({
    this.shoppings = const {},
    this.session,
  });

  ScanningState copyWith({
    Set<Shoppingsession>? shoppings,
    Shoppingsession? session,
  }) {
    return ScanningState(
      shoppings: removeEmptyShopping(shoppings ?? this.shoppings),
      session: session ?? this.session,
    );
  }

  static removeEmptyShopping(Set<Shoppingsession> shoppings) => shoppings
      .where((e) => e.duration.inSeconds > 3 && e.visitedFoodCodes.length > 2)
      .toSet();

  @override
  List<Object?> get props => [...shoppings, session];
}
