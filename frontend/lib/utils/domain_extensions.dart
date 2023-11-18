import 'package:event_planr_app/data/network/event_planr_api/models/address_dto.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/coordinate_dto.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/currency.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/event_category.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/invitation_status.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/order_direction.dart';
import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/common/coordinate.dart';
import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';

extension CurrencyX on Currency {
  CurrencyEnum toDomainEnum() {
    return CurrencyEnum.values.byName(name);
  }
}

extension EventCategoryX on EventCategory {
  EventCategoryEnum toDomainEnum() {
    return EventCategoryEnum.values.byName(name);
  }
}

extension OrderDirectionX on OrderDirection {
  OrderDirectionEnum toDomainEnum() {
    return OrderDirectionEnum.values.byName(name);
  }
}

extension InvitationStatusX on InvitationStatus {
  InvitationStatusEnum toDomainEnum() {
    return InvitationStatusEnum.values.byName(name);
  }
}

extension AddressDtoX on AddressDto {
  Address toDomainModel() {
    return Address(
      country: country,
      zipCode: zipCode,
      city: city,
      addressLine: addressLine,
    );
  }
}

extension CoordinatesDtoX on CoordinateDto {
  Coordinate toDomainModel() {
    return Coordinate(
      latitude: latitude,
      longitude: longitude,
    );
  }
}

extension CurrencyEnumX on CurrencyEnum {
  Currency toNetworkEnum() {
    return Currency.values.byName(name);
  }
}

extension EventCategoryEnumX on EventCategoryEnum {
  EventCategory toNetworkEnum() {
    return EventCategory.values.byName(name);
  }
}

extension OrderDirectionEnumX on OrderDirectionEnum {
  OrderDirection toNetworkEnum() {
    return OrderDirection.values.byName(name);
  }
}

extension AddressX on Address {
  AddressDto toNetworkModel() {
    return AddressDto(
      country: country,
      zipCode: zipCode,
      city: city,
      addressLine: addressLine,
    );
  }

  String formatToString() {
    return '$country, $zipCode $city, $addressLine';
  }
}

extension CoordinatesX on Coordinate {
  CoordinateDto toNetworkModel() {
    return CoordinateDto(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
