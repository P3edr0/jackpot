import 'package:jackpot/domain/entities/payment_order_entity.dart';

class PaymentOrderEntityMapper {
  static Map<String, dynamic> toJson(PaymentOrderEntity order) {
    Map<String, dynamic> data = {
      "descricao": order.description,
      "items": [
        {
          "quantidade": order.itemQuantity,
          "valorUnitario": order.itemUnitValue,
          "cpfUtilizador": order.document,
          "nomeUtilizador": order.name,
          "emailUtilizador": order.email,
          "utilizadorIgualPagador": true,
          "betId": "",
        }
      ],
      "sistema": 1,
      "cpfPagador": order.document,
      "nomePagador": order.name,
      "emailPagador": order.email,
      "telefonePagador": order.phone
    };
    if (order.cardData != null) {
      final cardData = {
        "nome": order.cardData!.name,
        "token": order.cardData!.token,
        "tipoDoCartao": order.cardData!.type
      };
      data = {
        ...data,
        ...{"dadosCartao": cardData}
      };
    }
    return data;
  }
}
