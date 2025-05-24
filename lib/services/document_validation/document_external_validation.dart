import 'package:dio/dio.dart';
import 'package:jackpot/services/token_service/generate_generic_token_service.dart';
import 'package:jackpot/shared/framework/jack_environment.dart';

Future<bool> validaExistente(
  String documento,
  int idPais,
  int idTipoDocumento,
  String email,
) async {
  final GenerateGenericTokenService tokenGenerator =
      GenerateGenericTokenService.instance();

  if (tokenGenerator.bearerToken == null) {
    await tokenGenerator();
  }
  String query = '';
  final dio = Dio();
  if (documento != '') {
    if (query != '') {
      query =
          '$query&documento=${documento.replaceAll('.', '').replaceAll('-', '')}';
    } else {
      query =
          '${query}documento=${documento.replaceAll('.', '').replaceAll('-', '')}';
    }
  }
  if (idPais > 0) {
    if (query != '') {
      query = '$query&idPais=$idPais';
    } else {
      query = '${query}idPais=$idPais';
    }
  }
  if (idTipoDocumento > 0) {
    if (query != '') {
      query = '$query&idTipoDocumento=$idTipoDocumento';
    } else {
      query = '${query}idTipoDocumento=$idTipoDocumento';
    }
  }
  if (email != '') {
    if (query != '') {
      query = '$query&email=$email';
    } else {
      query = '${query}email=$email';
    }
  }
  try {
    final response = await dio.get(
        '${JackEnvironment.apiUzerpass}rest/v1/usuarios/existente?$query',
        options: Options(headers: {
          "Content-type": "application/json; charset=UTF-8",
          "Authorization": tokenGenerator.bearerToken!.generate()
        }));
    // final response = await http.get(
    //   Uri.parse('${ApiUzerTicket.pessoaExistente}?$query'),
    //   headers: {
    //     "Content-type": "application/json; charset=UTF-8",
    //     "Authorization": "Bearer ${await recuperarTokenLogin()}"
    // },
    // );
    if (response.statusCode == 200) {
      // var dadosJson = json.decode(utf8.decode(response.bodyBytes));

      // print('======registerClient #C ok:$dadosJson');
      // if (dadosJson["usuario"] != null) {
      //   pessoaExistente = pexistente.PessoaExistente.fromJson(
      //       json.decode(utf8.decode(response.bodyBytes)));
      //   if (pessoaExistente!.usuario!.dataNascimento != null) {
      //     datanascto = DateTime.parse(pessoaExistente!.usuario!.dataNascimento!);
      //   }
      //   existente = dadosJson["existente"];
      //   if (documento != '') {
      //     cadastroUsuario!.nome = dadosJson["usuario"]["nome"];
      //     nomepessoa = dadosJson["usuario"]["nome"];
      //     if (pessoaExistente!.usuario!.dataNascimento != null) {
      //       datanascto =
      //           DateTime.tryParse(dadosJson["usuario"]["dataNascimento"]);
      //     }
      //   }
    }
  } catch (e) {}

  return false;
}
