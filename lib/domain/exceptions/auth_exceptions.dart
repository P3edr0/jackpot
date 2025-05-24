abstract class IJackExceptions implements Exception {
  String message = "Falha na autenticação.";
  IJackExceptions({required this.message});
}

class EmailAlreadyExistsException extends IJackExceptions {
  @override
  EmailAlreadyExistsException({super.message = "E-mail já cadastrado."});
}

class TooManyAttemptsException extends IJackExceptions {
  @override
  TooManyAttemptsException(
      {super.message = 'Acesso bloqueado temporariamente. Tente mais tarde.'});
}

class DataException extends IJackExceptions {
  @override
  DataException({super.message = "Dado inválido."});
}

class BadRequestJackException extends IJackExceptions {
  @override
  BadRequestJackException(
      {super.message = "Falha ao tentar acessar. Por favor tente mais tarde"});
}

class EmailOrPasswordException extends IJackExceptions {
  @override
  EmailOrPasswordException({super.message = "Email ou senha estão incorretos"});
}

class InvalidPasswordException extends IJackExceptions {
  @override
  InvalidPasswordException({super.message = "Senha informada não confere"});
}

class DisabledUserException extends IJackExceptions {
  @override
  DisabledUserException(
      {super.message =
          "A conta do usuário foi desativada pelo administrador."});
}

class InactiveUserException extends IJackExceptions {
  @override
  InactiveUserException(
      {super.message =
          "A conta do usuário ainda não foi ativada pelo administrador."});
}

class DisabledClientException extends IJackExceptions {
  @override
  DisabledClientException(
      {super.message = "A sua empresa está inativa. Fale com o administrador"});
}
