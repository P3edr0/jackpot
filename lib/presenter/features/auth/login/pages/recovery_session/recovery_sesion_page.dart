import 'package:flutter/material.dart';
import 'package:jackpot/components/buttons/circular_button.dart';
import 'package:jackpot/components/loadings/loading_button.dart';
import 'package:jackpot/core/store/core_controller.dart';
import 'package:jackpot/presenter/features/auth/login/pages/recovery_session/widgets/keyboard.dart';
import 'package:jackpot/presenter/features/auth/login/pages/recovery_session/widgets/password_icon.dart';
import 'package:jackpot/responsiveness/responsive.dart';
import 'package:jackpot/shared/utils/app_assets.dart';
import 'package:jackpot/shared/utils/routes/app_routes.dart';
import 'package:jackpot/theme/colors.dart';
import 'package:provider/provider.dart';

class RecoverySessionPage extends StatefulWidget {
  const RecoverySessionPage({super.key});
  @override
  RecoverySessionPageState createState() => RecoverySessionPageState();
}

class RecoverySessionPageState extends State<RecoverySessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: SafeArea(
            child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: constraints.maxHeight,
                          color: secondaryColor,
                          child: Image.asset(
                            AppAssets.faceIdAnimation,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: JackCircularButton(
                                onTap: () async {
                                  final coreController =
                                      Provider.of<CoreController>(context,
                                          listen: false);
                                  coreController
                                      .clearRecovererPasswordContent();
                                  Navigator.popAndPushNamed(
                                      context, AppRoutes.login);
                                },
                                size: 50,
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: secondaryColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Consumer<CoreController>(
                      builder: (context, controller, child) => Column(
                        children: [
                          SizedBox(
                            height: Responsive.getHeightValue(60),
                          ),
                          PasswordIcon(
                            passwordLength:
                                controller.recovererPasswordContent.length,
                          ),
                          SizedBox(
                              height: Responsive.getHeightValue(300),
                              child: const Keyboard()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<CoreController>(
                builder: (context, coreController, child) => Positioned(
                  bottom: Responsive.getHeightValue(340),
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      const Spacer(),
                      coreController.isLoading
                          ? CircleAvatar(
                              backgroundColor: darkBlue,
                              radius: Responsive.getHeightValue(50),
                              child: const LoadingButton(
                                color: secondaryColor,
                              ))
                          : CircleAvatar(
                              radius: Responsive.getHeightValue(50),
                              backgroundImage: NetworkImage(
                                  coreController.currentSession!.image),
                            ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
