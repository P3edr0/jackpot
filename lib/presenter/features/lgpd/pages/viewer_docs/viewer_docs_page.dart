import 'dart:io';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/loadings/loading.dart';
import 'package:jackpot/presenter/features/lgpd/pages/viewer_docs/store/viewer_docs_controller.dart';
import 'package:jackpot/responsiveness/leg_font_style.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../theme/colors.dart';

class ViewerDocsPage extends StatefulWidget {
  const ViewerDocsPage({super.key});

  @override
  State<ViewerDocsPage> createState() => _ViewerDocsPageState();
}

class _ViewerDocsPageState extends State<ViewerDocsPage> {
  @override
  void initState() {
    super.initState();

    final controller =
        Provider.of<ViewerDocsController>(context, listen: false);
    if (!controller.selectedDoc!.isLgpd) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.loadPdfFile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: secondaryColor),
        child: Selector<ViewerDocsController, bool>(
          selector: (_, controller) => controller.isLoading,
          builder: (context, loading, child) => loading
              ? const Loading()
              : LayoutBuilder(
                  builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: constraints.maxWidth,
                            height: Responsive.getHeightValue(60),
                            decoration: BoxDecoration(
                                gradient: primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                      color: darkBlue.withOpacity(0.3),
                                      offset: const Offset(0, 1),
                                      blurRadius: 0.8,
                                      spreadRadius: 0.8)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: JackCircularButton(
                                      onTap: () => Navigator.pop(context),
                                      size: 50,
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: secondaryColor,
                                      )),
                                ),
                                Selector<ViewerDocsController, String>(
                                    selector: (_, controller) =>
                                        controller.pageTitle(),
                                    builder: (context, title, child) => Text(
                                          title,
                                          style: JackFontStyle.titleBold
                                              .copyWith(color: secondaryColor),
                                        )),
                                const SizedBox(
                                  width: 50,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Responsive.getHeightValue(10),
                          ),
                          Expanded(child: Consumer<ViewerDocsController>(
                              builder: (context, controller, child) {
                            if (!controller.selectedDoc!.isLgpd) {
                              return Column(children: [
                                SizedBox(
                                  height: Responsive.getHeightValue(16),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: SfPdfViewer.file(
                                      File(controller.filePath),
                                      controller: PdfViewerController(),
                                      initialZoomLevel:
                                          1.00, // Define o nível de zoom inicial aqui
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]);
                            }

                            return SingleChildScrollView(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: lgpdContent,
                            ));
                          }))
                        ],
                      )),
        ),
      ),
    ));
  }
}

final lgpdContent = EasyRichText(
  scrollPhysics: const BouncingScrollPhysics(),
  "LGPD / POLÍTICA PRIVACIDADE\n\n"
          "A Uzer Tecnologia respeita a sua privacidade. Quando conectam-se a nós, queremos que nossos clientes saibam que seus dados pessoais e informações estão em segurança. Assim como nós nos dedicamos em levar-lhes os melhores serviços, estamos igualmente comprometidos em proporcionar-lhes uma experiência única de forma fácil e segura. As informações pessoais armazenadas pelo nosso site nos ajudam a compreender melhor os interesses de nossos clientes, sendo que o nosso esforço em atendê-los com o melhor serviço possível nunca cessa. Quaisquer perguntas ou sugestões acerca de nossos padrões de privacidade devem ser encaminhadas ao e-mail contato@uzer.com.br\n"
          "Referente aos dados pessoais e sensíveis cadastrados pelo usuário, a Uzer Tecnologia se encaixa como controladora e operadora de tais dados, e tomamos as decisões referentes ao tratamento de dados pessoais de forma segura. Não há coleta ou uso desses dados por parte da Uzer Tecnologia que saiam do escopo da operação de controle de acesso e venda de ingresso. Nos reservamos ao papel também de operar estes dados sistemicamente dentro da estrutura da plataforma para oferecer a experiência em tempo real integrada do uso do aplicativo.\n"
          "A Uzer Tecnologia pode coletar regularmente dados genéricos, não pessoais e não sensíveis (que não identificam a pessoa) para fins estatísticos e eventualmente dados de uso (tempo na página, cliques na interface, telas ativas) do nosso site, aplicativo e software para melhoria da solução. Todo e qualquer dado ou opinião pessoal que viermos a coletar futuramente, será com a autorização prévia e expressa do usuário.\n"
          "Fontes de Dados Pessoais\n"
          "Nós podemos coletar seus Dados Pessoais através das seguintes fontes:\n"
          "●     Site  Uzer Tecnologia:\n"
          "Nosso site pode ser utilizados para coleta de dados pessoais. Isso inclui tanto site que operamos diretamente através dos nossos domínios e endereços IPs, quanto sites ou páginas que nós estabelecemos em serviços de terceiros, como Facebook, Linkedin, e demais terceiros que ofertam esse tipo de serviço.\n"
          "●     Aplicativos ou sistemas da Uzer Tecnologia:\n"
          "Aplicativos ou sistemas fornecidos diretamente pela Uzer Tecnologia ou através de serviços de terceiros como Google ou Apple.\n"
          "●     Atendimento ao consumidor e central de vendas:\n"
          "Comunicações realizadas com Você através das nossas centrais de atendimento e vendas.\n"
          "●     Anúncios, propagandas e formulários online:\n"
          "Interações com qualquer tipo de anúncios, propagandas e formulários online da Uzer Tecnologia.\n"
          "●     Registros offline:\n"
          "Registros preenchidos offline, distribuídos durante eventos e outras interações com a Uzer Tecnologia.\n"
          "Quais são seus de Dados Pessoais que coletamos e como estes são coletados\n"
          "Durante sua interação junto a Uzer Tecnologia, usando uma das fontes de coleta previamente mencionadas, podemos coletar vários tipos de dados pessoais sobre Você, conforme exposto a seguir:\n"
          "●     Informações de Contato:\n"
          "Inclui qualquer tipo de informação que possa facilitar nosso contato com Você, incluindo números de telefone, endereços de correio eletrônico, sites e perfis em redes sociais.\n"
          "●     Informações técnicas sobre seus equipamentos computacionais ou dispositivos móveis:\n"
          "Detalhes sobre o seu computador ou outro dispositivo portátil que foi utilizado para acessar um de nossos sites, serviços ou aplicativos, incluindo o registro do endereço IP utilizado para conectar seu computador ou dispositivo à internet, incluindo sua localização geográfica, o tipo e a versão de sistema operacional e o tipo e a versão do navegador da web. Se Você acessar um site ou aplicativo da Uzer Tecnologia usando um dispositivo móvel, como um celular inteligente ou tablet, as informações coletadas também incluirão, sempre que permitido, o ID de dispositivo exclusivo de seu telefone, a localização geográfica e outros dados similares do dispositivo móvel.\n"
          "●     Informações sobre como Você utiliza nossos sites e serviços.\n"
          "Durante sua interação com nossos sites e serviços, Nós utilizamos tecnologias de coleta automática de dados para capturar informações sobre as ações que Você tomou. Isso pode incluir detalhes como em quais links Você clica, quais páginas ou conteúdos Você visualiza e por quanto tempo, e outras informações e estatísticas semelhantes sobre suas interações, como tempos de resposta a conteúdo, erros de download e duração das visitas a determinadas páginas. Essas informações são capturadas por meio de tecnologias automatizadas, como Cookies (Cookies de navegador, Cookies Flash e similares) e web beacons, e também via rastreamento de terceiros. Você possui total liberdade para se opor à utilização de tais tecnologias, para isso consulte os detalhes, na Seção “Sobre seus direitos referentes a Dados Pessoais”.\n"
          "●     Pesquisas de mercado e feedback de consumidores:\n"
          "São informações que Você compartilha voluntariamente com a Uzer Tecnologia sobre sua experiência de uso de nossos produtos e serviços.\n"
          "●     Contatos com nosso Serviço de Atendimento ao Consumidor e Central de Vendas:\n"
          "Suas interações com nossos Serviço de Atendimento ao Consumidor e Central de Vendas podem ser gravadas ou ouvidas, de acordo com as leis aplicáveis, para necessidades operacionais da Uzer Tecnologia. Detalhes de informações financeiras e de pagamentos não são gravados. Quando exigido por lei, Você será informado sobre tal gravação ainda no início de sua chamada.\n"
          "●     Dados Pessoais Sensíveis:\n"
          "A Uzer Tecnologia opera os dados pessoais sensíveis de biometria facial coletados pelo portal ou App, com objetivo exclusivo de segurança (promover a identificação da pessoa). Esses dados biométricos são de responsabilidade do Uzer Tecnologia e ficam alocados em servidor na nuvem não havendo compartilhamento com nenhuma fonte externa. Quando houver legítimo interesse ou for necessário processar seus dados pessoais sensíveis, por qualquer motivo, nós obteremos seu prévio, expresso e formal consentimento para qualquer processamento que for voluntário (por exemplo, para finalidades de marketing). Se processamos seus dados pessoais sensíveis para outras finalidades, Nós nos apoiamos nas seguintes bases legais: detecção e prevenção de crime; e cumprimento da lei aplicável.\n"
          "Sobre o uso de seus Dados Pessoais\n"
          "Os itens a seguir descrevem as finalidades para as quais a Uzer Tecnologia coleta seus Dados Pessoais, e os diferentes tipos de Dados Pessoais que coletamos para cada finalidade. Note, por favor, que nem todos os usos abaixo serão relevantes para todos os indivíduos e podem se aplicar apenas a situações específicas.\n"
          "●     Serviços ao consumidor:\n"
          "Seus Dados Pessoais são utilizados para finalidade de prestar serviços ao consumidor, incluindo responder a suas dúvidas, questionamentos e sugestões. Usualmente, isso requer certas informações pessoais de contato e informações sobre o motivo de seu questionamento, dúvida ou sugestão, por exemplo, qual foi o seu pedido, se existe um problema técnico, questão ou reclamação sobre produto, questionamento em geral.\n"
          "○     Motivo para uso dos seus dados pessoais nessa situação:\n"
          "■     Cumprir obrigações contratuais;\n"
          "■     Cumprir obrigações legais;\n" +
      "■     Nossos interesses legítimos.\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Melhorar continuamente produtos e serviços da Uzer Tecnologia;\n" +
      "■     Melhorar continuamente a efetividade do nosso atendimento ao consumidor.\n" +
      "●     Realização de concursos, promoções e demais ações de marketing:\n" +
      "Com seu consentimento (quando necessário conforme legislação vigente), a Uzer Tecnologia utiliza seus Dados Pessoais para fornecer informações sobre produtos ou serviços como, por exemplo, comunicações de marketing, campanhas publicitárias e promoções. Isso pode ser feito por diversos meios de comunicação, incluindo o e-mail, anúncios, envio de mensagens por SMS, ligações telefônicas e correspondências postais (conforme permitido pela legislação vigente), além de nossos próprios sites e/ou sites e redes sociais de terceiros. Nesta situação, o uso de seus Dados Pessoais é completamente voluntário, o que significa que Você pode se opor, ou mesmo retirar seu consentimento a qualquer momento, ao processamento de seus Dados Pessoais para estas finalidades. Para obter maiores detalhes sobre como alterar suas preferências sobre comunicações de marketing, veja a seção “Sobre seus direitos referentes a Dados Pessoais” nessa política. Para mais informações sobre nossos concursos e outras Promoções, veja os regulamentos ou detalhes postados sobre cada concurso/promoção.\n" +
      "○     Motivo para uso dos seus dados pessoais nessa situação:\n" +
      "■     Cumprir obrigações contratuais;\n" +
      "■     Nossos interesses legítimos;\n" +
      "■     Obtivemos o seu consentimento (quando necessário).\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Entender quais de nossos produtos e serviços podem interessar a Você e fornecer informações sobre eles;\n" +
      "■     Definir consumidores para novos produtos ou serviços.\n" +
      "●     Redes sociais e sites de terceiros:\n" +
      "Usamos seus Dados Pessoais quando Você interage com funções de redes sociais e sites de terceiros, como “curtir”, para fornecer anúncios e interagir com Você em redes sociais de terceiros. A forma como essas interações funcionam, os dados de perfil que a Uzer Tecnologia obtém sobre Você, e como cancelá-los (“opt-out”) podem ser entendidas revisando as políticas de privacidade diretamente nas respectivas redes sociais e sites de terceiros.\n" +
      "○     Motivo para uso dos seus dados pessoais nessa situação:\n" +
      "■     Cumprir obrigações contratuais;\n" +
      "■     Nossos interesses legítimos;\n" +
      "■     Obtivemos o seu consentimento (quando necessário).\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Entender quais de nossos produtos e serviços podem interessar a Você e fornecer informações sobre eles;\n" +
      "■     Definir consumidores para novos produtos ou serviços.\n" +
      "●     Personalização (offline e online):\n" +
      "Com base em seu consentimento (quando exigido conforme legislação vigente), a Uzer Tecnologia utiliza seus Dados Pessoais para entender suas preferências e hábitos, para antecipar suas necessidades, baseadas em nosso entendimento do seu perfil, para melhorar e personalizar sua experiência em nossos sites e aplicativos; para assegurar que o conteúdo de nossos sites e aplicativos seja otimizado para Você e para seu computador ou dispositivo; para enviar a Você publicidade e conteúdo dirigidos, e para permitir que Você participe de funções interativas, sempre que decidir fazê-lo. Nesta situação, o uso de seus Dados Pessoais é completamente voluntário, o que significa que Você pode se opor, ou mesmo retirar seu consentimento a qualquer momento, ao processamento de seus Dados Pessoais para estas finalidades. Para obter maiores detalhes, veja a seção “Sobre seus direitos referentes a Dados Pessoais” nessa política.\n" +
      "○     Motivo para uso dos seus dados pessoais nessa situação:\n" +
      "■     Cumprir obrigações contratuais;\n" +
      "■     Nossos interesses legítimos;\n" +
      "■     Obtivemos o seu consentimento (quando necessário).\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Entender quais de nossos produtos e serviços podem interessar a Você e fornecer informações sobre eles;\n" +
      "■     Definir consumidores para novos produtos ou serviços.\n" +
      "●     Motivos legais ou fusão/aquisição:\n" +
      "Caso a Uzer Tecnologia ou seus bens sejam adquiridos por, ou fundidos com, outra empresa, incluindo por motivo de falência, compartilharemos seus Dados Pessoais com nossos sucessores legais, respeitando as exigências da legislação vigente. Também divulgaremos seus Dados Pessoais a terceiros quando requerido pela lei aplicável; em resposta a procedimentos legais; em resposta a um pedido da autoridade legal competente; para proteger nossos direitos, privacidade, segurança ou propriedade; ou para fazer cumprir os termos de qualquer acordo ou os termos do nosso site, produtos e serviços, conforme a legislação vigente.\n" +
      "○     Motivo para uso dos seus dados pessoais nessa situação:\n" +
      "■     Cumprir obrigações contratuais;\n" +
      "■     Nossos interesses legítimos;\n" +
      "■     Obtivemos o seu consentimento (quando necessário).\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Entender quais de nossos produtos e serviços podem interessar a Você e fornecer informações sobre eles;\n" +
      "■     Definir consumidores para novos produtos ou serviços.\n" +
      "●     Outras finalidades e situações em geral:\n" +
      "De acordo com a legislação vigente, a Uzer Tecnologia utiliza seus Dados Pessoais para outras finalidades gerais de negócio, como fazer manutenção em sua conta, conduzir pesquisas internas ou de mercado e medir a efetividade de nossas campanhas publicitárias. Nós nos reservamos o direito, se Você tiver contas Uzer Tecnologia, de integrar estas contas em uma conta única. Nós também usamos seus Dados Pessoais para gerenciamento e operação de nossas comunicações, TI e sistemas de segurança e proteção de dados.\n" +
      "○     Motivo para uso dos seus dados pessoais nessa situação:\n" +
      "■     Cumprir obrigações contratuais;\n" +
      "■     Nossos interesses legítimos;\n" +
      "■     Obtivemos o seu consentimento (quando necessário).\n" +
      "○     Nossos interesses legítimos nessa situação:\n" +
      "■     Entender quais de nossos produtos e serviços podem interessar a Você e fornecer informações sobre eles;\n" +
      "■     Definir consumidores para novos produtos ou serviços.\n" +
      "Sobre a divulgação de seus Dados Pessoais\n" +
      "Por parte da Uzer Tecnologia, seus dados pessoais não serão divulgados em contextos fora do escopo das plataformas em questão, ficando limitado, sistematicamente, ao software de  controle de acesso e venda de ingressos.\n" +
      "Sobre a retenção e término do tratamento de seus Dados Pessoais\n" +
      "De acordo com a legislação vigente, A Uzer Tecnologia utiliza seus Dados Pessoais por quanto tempo for necessário para satisfazer as finalidades para as quais seus Dados Pessoais foram coletados, conforme descrito nesta política, ou para cumprir com os requerimentos legais aplicáveis.\n" +
      "Dados Pessoais usados para fornecer uma experiência personalizada a Você serão mantidos exclusivamente pelo tempo permitido, de acordo com a legislação vigente.\n" +
      "Você pode obter maiores detalhes sobre a retenção dos seus Dados Pessoais através dos canais de comunicação detalhados nesta política.\n" +
      "Quando no término do tratamento de seus Dados Pessoais, estes serão eliminados no âmbito e nos limites técnicos das atividades, autorizada a conservação nas situações previstas na legislação vigente.\n" +
      "Sobre a divulgação, o armazenamento ou transferência de seus Dados Pessoais\n" +
      "A Uzer Tecnologia adota medidas adequadas para garantir que seus Dados Pessoais sejam mantidos de forma confidencial e segura. Entretanto, que estas proteções não se aplicam a informações que Você tenha escolhido compartilhar em áreas públicas, como redes sociais de terceiros.\n" +
      "●     Pessoas que podem acessar seus Dados Pessoais:\n" +
      "Seus Dados Pessoais e dados sensíveis serão processados na maioria das vezes ocasionalmente por alguns de nossos colaboradores para fins de suporte ao cliente. Os dados estatísticos e de uso das ferramentas (anonimizados), serão processados por nossos colaboradores desde que estes precisem ter acesso a tais informações, dependendo dos propósitos específicos para os quais seus Dados Pessoais tenham sido coletados.\n" +
      "●     Medidas tomadas em ambientes operacionais:\n" +
      "Seus Dados Pessoais são armazenados em ambientes operacionais interno, em base de dados criptografada, que usam medidas de segurança razoáveis, tanto técnicas quanto administrativas, para prevenir qualquer tipo de acesso não autorizado. Seguimos protocolos razoáveis para proteger Dados Pessoais.\n" +
      "●     Medidas que a Uzer Tecnologia espera que Você tome:\n" +
      "É importante que Você também tenha um papel em manter seus Dados Pessoais seguros. Quando criar uma conta online, por favor, assegure-se de escolher uma senha que seja forte para evitar que partes não autorizadas a adivinhem. Recomendamos que Você nunca revele ou compartilhe sua senha com outras pessoas. Você é o único responsável por manter esta senha confidencial e por qualquer ação realizada através de sua conta nos sites e serviços compatíveis da Uzer Tecnologia. Se Você usar um computador compartilhado ou público, nunca escolha a opção de lembrar seu nome de login, endereço de e-mail ou senha, e certifique-se que Você saiu da sua conta (realizou o logout) sempre que deixar o computador. Você também deve usar quaisquer configurações de privacidade ou controles que a Uzer Tecnologia fornece em nosso site, serviços ou aplicativos, inclusive aquelas consideradas opcionais.\n" +
      "●     Transferência de seus Dados Pessoais:\n" +
      "A Uzer Tecnologia não efetua a transferência de seus dados pessoais para terceiros, limitando-se a operá-los somente dentro do âmbito da empresa.\n" +
      "Sobre seus direitos referentes a Dados Pessoais\n" +
      "Você tem direito de confirmar a existência, acessar, revisar, modificar e/ou requisitar uma cópia eletrônica da informação dos seus Dados Pessoais que são tratados pela Uzer Tecnologia.\n" +
      "Você também tem direito de requisitar detalhes sobre a origem de seus Dados Pessoais ou o compartilhamento destes dados com terceiros.\n" +
      "A qualquer momento, Você também poderá limitar o uso e divulgação, ou revogar o consentimento a qualquer uma de nossas atividades de processamento de seus Dados Pessoais, excetuando-se em situações previstas na legislação vigente.\n" +
      "Estes direitos podem ser exercidos através dos canais de comunicação detalhados nesta política, sendo necessário à validação da sua identidade através do fornecimento de uma cópia de seu RG ou meios equivalentes de identificação, em conformidade com a legislação vigente.\n" +
      "Sempre que um pedido for submetido sem o fornecimento das provas necessárias à comprovação da legitimidade do titular dos dados, o pedido será automaticamente rejeitado. Ressaltamos que qualquer informação de identificação fornecida a Uzer Tecnologia somente será processada de acordo com, e na medida permitida pelas leis vigentes.\n" +
      "Ressaltamos que em determinados casos, não podermos excluir seus Dados Pessoais sem também excluir sua conta de usuário. Adicionalmente, algumas situações requerem a retenção de seus Dados Pessoais depois que Você pedir sua exclusão, para satisfazer obrigações legais ou contratuais.\n" +
      "Quando disponíveis, nossos sites, aplicativos e serviços online podem ter uma função dedicada onde será possível Você revisar e editar os seus Dados Pessoais. Ressaltamos que a Uzer Tecnologia solicita a validação de sua identidade usando, por exemplo, um sistema de login com senha de acesso ou recurso similar, antes de permitir o acesso ou a modificação de seus Dados Pessoais, dessa forma garantindo que não exista acesso não autorizado à sua conta e dados pessoais associados.\n" +
      "A Uzer Tecnologia faz o máximo possível para poder atender todas as questões que Você possa ter sobre a forma a qual processamos seus Dados Pessoais. Contudo, se Você tiver preocupações não resolvidas, Você tem o direito de reclamar às autoridades de proteção de dados competentes.\n" +
      "Quais são suas escolhas sobre como utilizamos e divulgamos seus Dados Pessoais\n" +
      "A Uzer Tecnologia faz o máximo para dar a Você liberdade de escolha sobre os Dados Pessoais que Você nos fornece. Os seguintes mecanismos dão a Você o controle sobre o tratamento de seus Dados Pessoais:\n" +
      "●     Cookies/Tecnologias Similares:\n" +
      "Você pode gerenciar o seu consentimento usando:\n" +
      "○     Nossas soluções de gerenciamento de consentimento;\n" +
      "○     As configurações do seu navegador para recusar alguns ou todos os Cookies e tecnologias similares, ou para alertá-lo quando estão sendo usados.\n" +
      "●     Publicidade, marketing e promoções:\n" +
      "Você pode consentir para que seus Dados Pessoais sejam usados pela Uzer Tecnologia para promover nossos produtos ou serviços por meio de caixas de verificação localizadas nos formulários de registro ou respondendo questões apresentadas pelos nossos representantes. Se Você decidir que não deseja mais receber tais comunicações, Você pode cancelar sua subscrição para receber comunicações relacionadas a marketing a em qualquer momento, seguindo as instruções fornecidas em tais comunicações. Para cancelar a subscrição de comunicações de marketing enviadas por qualquer meio, incluindo redes sociais de terceiros, Você pode optar por sair a qualquer tempo, cancelando sua subscrição, pelos links disponíveis em nossas comunicações, fazendo login em nossos sites, aplicativos, serviços online compatíveis ou redes sociais de terceiros, e ajustando suas preferências de usuário ou ligando diretamente para nosso serviço de atendimento ao consumidor. É importante lembrar que, mesmo com o seu cancelamento de subscrição às nossas comunicações de marketing, Você continuará a receber comunicações administrativas da Uzer Tecnologia, como pedidos, confirmações de transação, notificações sobre suas atividades de conta em nossos sites e serviços compatíveis, e outros anúncios importantes não relacionados a marketing.\n" +
      "●     Personalização (offline e online):\n" +
      "Sempre que permitido por lei, se Você quiser que seus Dados Pessoais sejam usados pela Uzer Tecnologia para fornecer-lhe uma experiência personalizada ou publicidade e conteúdo dirigidos, Você pode indicar isso por meio das caixas de checagem relevantes localizadas no formulário de registro ou respondendo a perguntas apresentadas pelos nosso representantes. Se Você decidir que não quer mais se beneficiar desta personalização, Você pode optar por sair a qualquer tempo, fazendo login nos nossos sites, aplicativos e serviços compatíveis, e selecionando as preferências de usuário no perfil da sua conta ou ligando diretamente para nosso serviço de atendimento ao consumidor.\n" +
      "●     Publicidade direcionada:\n" +
      "A Uzer Tecnologia pode realizar parcerias com redes de anúncios e outros provedores de serviços ou anúncios, que apresentam propagandas e demais anúncios em nosso nome ou no nome de outras empresas não-afiliadas a Uzer Tecnologia. Alguns destes anúncios podem ser ajustados aos seus interesses, com base nas informações coletadas nos sites e demais serviços compatíveis da Uzer Tecnologia ou em sites de organizações não-filiadas a Uzer Tecnologia. Você pode entrar em contato usando os canais de comunicação detalhados nesta política para obter mais informações sobre como gerenciar ou cancelar sua participação em publicidade direcionada.\n" +
      "Alterações em nossa Política de Privacidade\n" +
      "Sempre que a Uzer Tecnologia decidir mudar a forma que tratamos seus Dados Pessoais, esta Política será atualizada. Nos reservamos o direito de fazer alterações às nossas práticas e a esta Política a qualquer tempo, desde que mantida a conformidade com a legislação vigente. Recomendamos que Você a acesse frequentemente, ou sempre que tiver dúvidas, para ver quaisquer atualizações ou mudanças à nossa Política de Privacidade.\n" +
      "Como entrar em contato\n" +
      "Você pode entrar em contato para:\n" +
      "●     Fazer perguntas ou comentários sobre esta Política e nossas práticas de privacidade e proteção de Dados Pessoais;\n" +
      "●     Fazer uma reclamação;\n" +
      "●     Confirmação da existência de tratamento de seus Dados Pessoais;\n" +
      "●     Obter informações sobre como acessar seus Dados Pessoais;\n" +
      "●     Realizar a correção de dados pessoais incompletos, inexatos ou desatualizados;\n" +
      "●     Obter informações sobre a anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com o disposto na legislação vigente;\n" +
      "●     Obter informações sobre a portabilidade dos seus dados pessoais a outro fornecedor de serviço ou produto, mediante requisição expressa, em conformidade com a legislação vigente;\n" +
      "●     Solicitar a eliminação dos dados pessoais tratados com o seu consentimento, excetuando-se as hipóteses previstas na legislação vigente;\n" +
      "●     Solicitar detalhes das entidades públicas e privadas com as quais realizamos o compartilhamento de seus Dados Pessoais;\n" +
      "●     Obter informações sobre a possibilidade de não fornecer consentimento e sobre as consequências dessa negativa;\n" +
      "●     Realizar a revogação do consentimento para o tratamento dos seus Dados Pessoais, excetuando-se as hipóteses previstas na legislação vigente;\n" +
      "●     Demais direitos do titular dos dados pessoais, conforme legislação vigente.\n" +
      "●     Para isso, solicitamos que Você entre em contato conosco usando os seguintes canais:\n" +
      "Site Uzer Tecnologia:\n" +
      "https://www.uzer.com.br/\n" +
      "E-mail responsável:\n" +
      "contato@uzer.com.br\n" +
      "A Uzer Tecnologia receberá, investigará e responderá, dentro de um prazo considerado razoável, qualquer solicitação ou reclamação sobre a forma como Nós tratamos seus Dados Pessoais, incluindo reclamações sobre desrespeito aos seus direitos sob as leis de privacidade e proteção de Dados Pessoais vigentes.\n",
  patternList: const [
    EasyRichTextPattern(
      targetString: 'Política de Privacidade',
      //matchOption: 'all'
      matchOption: [0, 1, 'last'],
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ],
);
