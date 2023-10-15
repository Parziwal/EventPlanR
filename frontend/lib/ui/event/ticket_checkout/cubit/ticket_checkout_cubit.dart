import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_checkout_state.dart';
part 'ticket_checkout_cubit.freezed.dart';

class TicketCheckoutCubit extends Cubit<TicketCheckoutState> {
  TicketCheckoutCubit() : super(const TicketCheckoutState.initial());
}
