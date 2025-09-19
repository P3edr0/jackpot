import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jackpot/domain/entities/address_entity.dart';
import 'package:jackpot/domain/entities/payment_card_entity.dart';
import 'package:jackpot/domain/entities/payment_order_entity.dart';
import 'package:jackpot/domain/entities/pix_entity.dart';
import 'package:jackpot/domain/entities/quick_purchase_user_entity.dart';
import 'package:jackpot/domain/entities/user_entity.dart';
import 'package:jackpot/domain/usecases/auth/login/check_credential_usecase.dart';
import 'package:jackpot/domain/usecases/payment/card_payment_usecase.dart';
import 'package:jackpot/domain/usecases/payment/get_payment_public_key_usecase.dart';
import 'package:jackpot/domain/usecases/payment/get_pix_usecase.dart';
import 'package:jackpot/services/cep_service/cep_service.dart';
import 'package:jackpot/shared/utils/enums/credential_type.dart';
import 'package:jackpot/shared/utils/enums/payment_type.dart';
import 'package:jackpot/shared/utils/formatters/cpf_formatter.dart';
import 'package:jackpot/shared/utils/validators/credential_validator.dart';
import 'package:pagseguro_card_encrypt/pagseguro_card_encrypt.dart';

class PaymentController extends ChangeNotifier {
  PaymentController({
    required this.cepService,
    required this.getPixUsecase,
    required this.cardPaymentUsecase,
    required this.getPaymentPublicKeyUsecase,
    required this.checkCredentialUsecase,
  });

  //////////////////////// VARS //////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cardFormKey = GlobalKey<FormState>();
  final CepService cepService;
  final GetPixUsecase getPixUsecase;
  final CheckCredentialUsecase checkCredentialUsecase;
  final CardPaymentUsecase cardPaymentUsecase;
  final GetPaymentPublicKeyUsecase getPaymentPublicKeyUsecase;

  final TextEditingController _cardCvv = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expireCardDate = TextEditingController();
  final TextEditingController _nameOwnerCard = TextEditingController();
  final TextEditingController _cpfOwnerCard = TextEditingController();
  // final TextEditingController _cardCvv = TextEditingController(text: '123');
  // final TextEditingController _cardNumber =
  //     TextEditingController(text: '4539620659922097');
  // final TextEditingController _expireCardDate =
  //     TextEditingController(text: '12/2030');
  // final TextEditingController _nameOwnerCard =
  //     TextEditingController(text: 'Pedro Neves alcantara');
  // final TextEditingController _cpfOwnerCard =
  //     TextEditingController(text: '12496747608');
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  Widget? _pageContent;
  String? _exception;
  String? _userName;
  String? _cardPaymentId;
  String? _tempBetPaymentId;
  String? _encryptedCard;
  String? _email;
  String? _phone;
  PixEntity? _pix;
  QuickPurchaseUserEntity? quickPurchaseUser;
  String? _itemPaymentDescription;
  String? _itemDescription;
  String? _userDocument;
  int? _couponsQuantity;
  int? _paymentCouponsQuantity;
  PaymentType _paymentType = PaymentType.pix;
  double? _totalValue;
  double? _unitValue;
  bool _showPaymentInfo = true;
  bool _isLoading = false;
  bool _showCardInfo = true;
  bool _showEditAddress = false;
  bool _acceptTerms = true;

  AddressEntity? _billingAddress;
  //////////////////////// GETS //////////////////////////////
  int? get couponsQuantity => _couponsQuantity;
  String? get exception => _exception;
  String get userDocument => _userDocument ?? quickPurchaseUser!.document;
  String? get encryptedCard => _encryptedCard;
  String? get itemDescription => _itemDescription;
  String? get cardPaymentId => _cardPaymentId;
  String? get tempBetPaymentId => _tempBetPaymentId;
  Widget? get pageContent => _pageContent;
  GlobalKey<FormState> get formKey => _formKey;
  GlobalKey<FormState> get cardFormKey => _cardFormKey;
  double? get totalValue => _totalValue;
  double? get paymentValue => _getPaymentValue();
  double? get unitValue => _unitValue;
  bool get acceptTerms => _acceptTerms;
  bool get haveQuickPurchaseUser => quickPurchaseUser != null;
  bool get showPaymentInfo => _showPaymentInfo;
  bool get showCardInfo => _showCardInfo;
  bool get showEditAddress => _showEditAddress;
  bool get hasError => _exception != null;
  bool get isLoading => _isLoading;
  PaymentType get paymentType => _paymentType;
  AddressEntity? get billingAddress => _billingAddress;

  TextEditingController get cepController => _cepController;
  TextEditingController get complementController => _complementController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  String? get paymentId => _paymentType.isPix
      ? (_pix?.id ?? _tempBetPaymentId)
      : (cardPaymentId ?? _tempBetPaymentId);
  TextEditingController get neighborhoodController => _neighborhoodController;
  TextEditingController get streetController => _streetController;
  TextEditingController get numberController => _numberController;
  TextEditingController get cardNumber => _cardNumber;
  TextEditingController get expireCardDate => _expireCardDate;
  TextEditingController get nameOwnerCard => _nameOwnerCard;
  TextEditingController get cpfOwnerCard => _cpfOwnerCard;
  TextEditingController get cardCvv => _cardCvv;

  //////////////////////// FUNCTIONS //////////////////////////////

  void saveEditAddress() {
    if (!_formKey.currentState!.validate()) return;
    final cep = cepController.text;
    final street = streetController.text;
    final neighborhood = neighborhoodController.text;
    final city = cityController.text;
    final state = stateController.text;
    final number = numberController.text;
    final complement = complementController.text;
    final newAddress = AddressEntity(
        cep: cep,
        street: street,
        neighborhood: neighborhood,
        city: city,
        state: state,
        number: number,
        complement: complement);
    setBillingAddress(newAddress);
    setControllersAddress(newAddress);
    setShowEditAddress();
  }

  void setPaymentData(
      {int? newCouponsQuantity,
      int? newPaymentCouponsQuantity,
      double? newTotalValue,
      double? newUnitValue,
      String? newUserName,
      String? newUserDocument,
      String? newItemDescription,
      String? newItemPaymentDescription,
      String? newEmail,
      String? newPhone}) {
    _couponsQuantity = newCouponsQuantity ?? _couponsQuantity;
    _paymentCouponsQuantity =
        newPaymentCouponsQuantity ?? _paymentCouponsQuantity;
    _totalValue = newTotalValue ?? _totalValue;
    _unitValue = newUnitValue ?? _unitValue;
    _userName = newUserName ?? _userName;
    _userDocument = newUserDocument ?? _userDocument;
    _itemDescription = newItemDescription ?? _itemDescription;
    _email = newEmail ?? _email;

    _itemPaymentDescription =
        newItemPaymentDescription ?? _itemPaymentDescription;
    _phone = newPhone ?? _phone;
    notifyListeners();
  }

  setPageContent(Widget newContent) {
    _pageContent = newContent;
    notifyListeners();
  }

  setTempPaymentId(String newPaymentId) {
    _tempBetPaymentId = newPaymentId;
    notifyListeners();
  }

  double? _getPaymentValue() {
    if (_paymentCouponsQuantity == null || _unitValue == null) {
      return null;
    }
    final payValue = _paymentCouponsQuantity! * _unitValue!;
    return payValue;
  }

  Future<void> getCepAddress() async {
    final String cep = cepController.text.replaceAll(RegExp('[.-]+'), '');
    final response = await cepService(cep);

    return response.fold((error) {
      _exception = error.message;
      cepController.clear();
      notifyListeners();
    }, (address) {
      _exception = null;
      setControllersAddress(address);
      notifyListeners();
    });
  }

  Future<void> getPaymentPublicKey() async {
    setLoading(true);
    final response = await getPaymentPublicKeyUsecase();

    return response.fold((error) {
      _exception = error.message;
      setLoading(false);
    }, (publicKey) async {
      final tempEncryptedCard = handledEncryptCard(publicKey);
      _encryptedCard = tempEncryptedCard;
      await cardPayment();
    });
  }

  Future<void> cardPayment() async {
    final name = _userName ?? quickPurchaseUser!.name;
    final document = _userDocument ?? quickPurchaseUser!.document;
    final email = _email ?? quickPurchaseUser!.email;
    final phone = _phone ?? quickPurchaseUser!.phone;
    final cardData = PaymentCard(
        name: _nameOwnerCard.text,
        token: encryptedCard!,
        type: _paymentType.paymentTypeLabel());

    final order = PaymentOrderEntity(
        name: name,
        document: document,
        description: _itemPaymentDescription!,
        email: email,
        phone: phone,
        itemQuantity: _paymentCouponsQuantity!,
        itemUnitValue: _unitValue!,
        cardData: cardData);

    final response = await cardPaymentUsecase(order);
    return response.fold((error) {
      _exception = error.message;
      setLoading(false);
    }, (newCardPaymentId) {
      _exception = null;
      _cardPaymentId = newCardPaymentId;
      setLoading(false);
    });
  }

  bool validCardForm() {
    if (_cardFormKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  String? handledEncryptCard(String publicKey) {
    try {
      final handledCardNumber = cardNumber.text.replaceAll(' ', '');
      final handledCardOwner = nameOwnerCard.text;
      final handledCardCvv = cardCvv.text;
      final cardExpireDate = expireCardDate.text;
      String yearExpire = cardExpireDate.split('/')[1];

      String monthExpire = cardExpireDate.split('/').first;

      final encryptedCardData = encryptCard(
        cardNumber: handledCardNumber,
        cardHolderName: handledCardOwner,
        cardSecurityCode: handledCardCvv,
        cardExpMonth: monthExpire,
        cardExpYear: yearExpire,
        publicKey: publicKey,
      );
      log(encryptedCardData, name: 'Cartão Criptografado');
      return encryptedCardData;
    } catch (e, stack) {
      if (e.runtimeType == FormatException) {
        final handledException = e as FormatException;

        log(handledException.message);
      } else {
        log('Falha ao criptografar cartão $e - $stack');
      }
      _exception = 'Falha no pagamento. Por favor tente mais tarde';

      return null;
    }
  }

  Future<UserEntity?> checkDocument() async {
    String document = _cpfOwnerCard.text.replaceAll(RegExp('[.-]+'), '');

    final response =
        await checkCredentialUsecase(document, CredentialType.document);

    return response.fold((error) {
      _exception = error.message;
      _cpfOwnerCard.clear();
      notifyListeners();
      return null;
    }, (user) {
      _exception = null;
      return user;
    });
  }

  //////////////////////// SETS //////////////////////////////
  String? validDocument() {
    final String content = _cpfOwnerCard.text;
    final validator = CredentialValidator();
    final response = validator(false, content);
    return response;
  }

  setDocumentMask() {
    _cpfOwnerCard.value =
        CpfFormatter.maskFormatter.updateMask(mask: "###.###.###-##");
  }

  void setLoading([bool? newLoading]) {
    if (newLoading == null) {
      _isLoading = !isLoading;
      notifyListeners();
    } else {
      if (_isLoading == newLoading) return;
      _isLoading = newLoading;
      notifyListeners();
    }
  }

  void setShowCardInfo([bool? value]) {
    if (value != null) {
      _showCardInfo = value;
      notifyListeners();
      return;
    }
    _showCardInfo = !_showCardInfo;
    notifyListeners();
  }

  void setShowPaymentInfo() {
    _showPaymentInfo = !_showPaymentInfo;
    notifyListeners();
  }

  void setQuickPurchaseUser(QuickPurchaseUserEntity? newQuickPurchaseUser) {
    quickPurchaseUser = newQuickPurchaseUser;
    notifyListeners();
  }

  void setShowEditAddress() {
    _showEditAddress = !_showEditAddress;
    if (_showEditAddress) {
      setShowCardInfo(false);
    }
    notifyListeners();
  }

  void setPaymentType(PaymentType newPaymentType) {
    _paymentType = newPaymentType;

    notifyListeners();
  }

  Future<void> setBillingAddress(AddressEntity newBillingAddress,
      [bool needGetCep = true]) async {
    cepController.text = newBillingAddress.cep;
    _billingAddress = newBillingAddress;

    if (needGetCep) {
      await getCepAddress();
    }
    notifyListeners();
  }

  void setAcceptTerms() {
    _acceptTerms = !_acceptTerms;
    notifyListeners();
  }

  void setControllersAddress(
    AddressEntity address,
  ) {
    streetController.text = address.street;
    neighborhoodController.text = address.neighborhood;
    stateController.text = address.state;
    cityController.text = address.city;
    stateController.text = address.state;
    cepController.text = address.cep;
    numberController.text = address.number ?? _billingAddress!.number ?? '';
    complementController.text =
        address.complement ?? _billingAddress!.complement ?? '';
  }

  Future<PixEntity?> generatePix() async {
    final name = _userName ?? quickPurchaseUser!.name;
    final document = _userDocument ?? quickPurchaseUser!.document;
    final email = _email ?? quickPurchaseUser!.email;
    final phone = _phone ?? quickPurchaseUser!.phone;
    final order = PaymentOrderEntity(
        name: name,
        document: document,
        description: _itemPaymentDescription!,
        email: email,
        phone: phone,
        itemQuantity: _paymentCouponsQuantity!,
        itemUnitValue: _unitValue!);

    // return Future.delayed(
    //   Durations.extralong4,
    //   () => PixEntity(
    //       id: 'cf673550-ae41-4060-8d57-e3d930600bb8',
    //       value: 6.99,
    //       qrCode: '',
    //       copyPaste: '',
    //       expireAt: DateTime(2026)),
    // );
    final response = await getPixUsecase(order);

    return response.fold(
      (error) {
        _exception = error.message;
        notifyListeners();
        return null;
      },
      (pix) {
        log(pix.value.toString(), name: 'Valor do Pix');
        _pix = pix;
        return pix;
      },
    );
  }
}
