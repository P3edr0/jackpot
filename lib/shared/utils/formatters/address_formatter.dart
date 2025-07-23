import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/shared/utils/formatters/formatter.dart';

class AddressFormatter extends Formatter {
  static String format(AddressEntity? address) {
    if (address == null) {
      return 'Definir depois';
    }
    final cep = address.cep;
    final number = address.number;
    final street = address.street;

    final neighborhood = address.neighborhood;
    String city = address.city;
    String state = address.state;
    if (state.isEmpty && city.contains('/')) {
      final lists = city.split('/');
      if (lists.length == 2) {
        city = lists.first;
        state = '/${lists[1]}';
      }
    } else {
      state = '/$state';
    }

    return '$cep - $street $number, $neighborhood, $city$state';
  }

  @override
  String clearMask() {
    return '';
  }
}
