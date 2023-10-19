import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/ticket/add_ticket_user_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order.freezed.dart';
part 'create_order.g.dart';

@freezed
class CreateOrder with _$CreateOrder {
  const factory CreateOrder({
    required String customerFirstName,
    required String customerLastName,
    required Address billingAddress,
    required List<AddTicketUserInfo> ticketUserInfos,
  }) = _CreateOrder;

  factory CreateOrder.fromJson(Map<String, Object?> json) =>
      _$CreateOrderFromJson(json);
}
