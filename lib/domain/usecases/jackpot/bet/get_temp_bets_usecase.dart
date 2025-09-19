import 'package:dartz/dartz.dart';
import 'package:jackpot/domain/entities/temporary_bet_entity.dart';
import 'package:jackpot/domain/exceptions/auth_exceptions.dart';
import 'package:jackpot/domain/repositories/jackpot/jackpot_repository.dart';
import 'package:jackpot/domain/repositories/payment/payment_repository.dart';
import 'package:jackpot/shared/utils/enums/bet_status.dart';

class GetTempBetsUsecase {
  GetTempBetsUsecase({
    required this.repository,
    required this.pixStatusRepository,
    required this.deleteTempBetRepository,
  });
  IGetTempBetRepository repository;
  IGetPixStatusRepository pixStatusRepository;
  IDeleteTempBetRepository deleteTempBetRepository;

  Future<Either<IJackExceptions, List<TemporaryBetEntity>>> call(
      String userDocument) async {
    final response = await repository(userDocument);
    return response.fold(
      (l) => Left(l),
      (tempBets) async {
        final waitingPaymentBets =
            tempBets.where((bet) => bet.status.isWaitingPayment).toList();
        final calls = waitingPaymentBets
            .map((waitPaymentBet) =>
                pixStatusRepository(waitPaymentBet.paymentId!))
            .toList();
        final pixStatusResponse = await Future.wait(calls);
        for (int index = 0; index < pixStatusResponse.length; index++) {
          pixStatusResponse[index].fold((l) {}, (paymentStatus) {
            if (paymentStatus.isSuccess) {
              waitingPaymentBets[index].status = BetStatus.waitingAnswer;
            }
          });
        }

        final expiredBetsBets = tempBets
            .where((bet) => bet.status.isWaitingPayment)
            .toList()
            //CORRETO é IS AFTER ou seja hoje é depois da data de expiração
            .where((waitPaymentBet) => DateTime.now().isAfter(
                waitPaymentBet.createdAt!.add(const Duration(hours: 24))))
            .toList();
        final deleteBetCalls = expiredBetsBets.map((waitPaymentBet) =>
            deleteTempBetRepository(userDocument, waitPaymentBet.paymentId!,
                waitPaymentBet.jackpotId));
        final deleteBetResponse = await Future.wait(deleteBetCalls);
        final Set<String> idsToDelete = {};
        for (int index = 0; index < deleteBetResponse.length; index++) {
          deleteBetResponse[index].fold((l) {}, (deleted) {
            if (deleted) {
              idsToDelete.add(expiredBetsBets[index].paymentId!);
            }
          });
        }
        for (var id in idsToDelete) {
          tempBets.removeWhere((element) => element.paymentId == id);
        }

        return Right(tempBets);
      },
    );
  }
}
