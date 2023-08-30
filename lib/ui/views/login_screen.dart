// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami_acad/services/models/result.dart';
import 'package:gami_acad/ui/controllers/login_controller.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';
import 'package:gami_acad/ui/utils/app_colors.dart';
import 'package:gami_acad/ui/utils/dimensions.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/validators.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:gami_acad/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode _registrationFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  static const TextStyle style = TextStyle(fontSize: 20.0);

  final String EMAIL_NOT_FOUND = 'user-not-found';
  final String ERROR_WRONG_PASSWORD = 'wrong-password';
  final String ACCOUNT_EXISTS = 'account-already-exists';

  @override
  void initState() {
    _registrationFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _registrationFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      child: Consumer<LoginController>(builder: (context, loginController, _) {
        return Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
            ),
          ),
          child: WillPopScope(
            onWillPop: () async {
              if (loginController.loginState != LoginState.login) {
                loginController.loginState = LoginState.login;
                return false;
              } else {
                return true;
              }
            },
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
              child: Scaffold(
                backgroundColor: AppColors.detailsScreensBackground,
                body: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.topPadding * 2,
                            left: Dimensions.sidePadding,
                            right: Dimensions.sidePadding),
                        child: Form(
                          key: loginController.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Image(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    'assets/images/logo_poli.png',
                                  ),
                                ),
                              ),
                              Dimensions.heightSpacer(
                                  Dimensions.inBetweenItensPadding * 2.5),
                              Card(
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: Dimensions.screenHeight(context) *
                                          0.06,
                                      width: Dimensions.screenWidth(context),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              loginController.loginState ==
                                                      LoginState.login
                                                  ? 'Login'
                                                  : 'Cadastrar',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: SizedBox(
                                          height:
                                              Dimensions.screenHeight(context) *
                                                  0.01),
                                    ),
                                    Column(
                                      children: _buildLoginInputs(
                                          loginController, context),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    Dimensions.screenHeight(context) * 0.015,
                              ),
                              ..._buildButtons(loginController, context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    loginController.loginState == LoginState.login
                        ? Container()
                        : SafeArea(
                            child: Container(
                              alignment: Alignment.topLeft,
                              color: Colors.transparent,
                              height: 46,
                              width: 46,
                              child: IconButton(
                                color: Colors.grey[600],
                                onPressed: () {
                                  loginController.loginState = LoginState.login;
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildLoginInputs(
      LoginController loginController, BuildContext context) {
    List<Widget> registrationPasswordInputs = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'CPF',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateRegistration,
          onSaved: (value) => loginController.registration = value,
          focusNode: _registrationFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          obscureText: true,
          labelText: 'Senha',
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: FieldValidators.validatePwd,
          onSaved: (value) => loginController.password = value,
          focusNode: _passwordFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            if (loginController.loginState == LoginState.login) {
              _signInSignUp(loginController);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
    ];

    List<Widget> signUpInputs = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'Nome',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onSaved: (value) => loginController.name = value,
          focusNode: _nameFocus,
          validator: FieldValidators.validateName,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_emailFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateEmail,
          onSaved: (value) => loginController.email = value,
          focusNode: _emailFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_registrationFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DefaultTextField(
          labelText: 'CPF',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: FieldValidators.validateRegistration,
          onSaved: (value) => loginController.registration = value,
          focusNode: _registrationFocus,
          style: style,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          style: style,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          obscureText: true,
          focusNode: _passwordFocus,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_confirmPasswordFocus);
          },
          controller: _pass,
          validator: FieldValidators.validatePwd,
          onSaved: (value) => loginController.password = value,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Senha',
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            errorStyle: const TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          style: style,
          textAlign: TextAlign.start,
          obscureText: true,
          focusNode: _confirmPasswordFocus,
          controller: _confirmPass,
          onSaved: (value) => loginController.confirmPassword = value,
          validator: (val) {
            if (FieldValidators.validatePwd(val) != null) {
              return 'Senha deve ter entre 6 e 12 caracteres';
            }
            if (val != _pass.text) return 'Senhas não são iguais';
            return null;
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            _signInSignUp(loginController);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: 'Confirmar Senha',
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            errorStyle: const TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
    ];

    return loginController.loginState == LoginState.login
        ? registrationPasswordInputs
        : [
            Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
            ...signUpInputs
          ];
  }

  List<Widget> _buildButtons(
      LoginController loginController, BuildContext context) {
    Material signButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          _signInSignUp(loginController);
        },
        child: loginController.state == ViewState.idle
            ? Text(
                loginController.loginState == LoginState.login
                    ? "Entrar"
                    : "Cadastrar",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox(
                height: Dimensions.screenHeight(context) * 0.04,
                width: Dimensions.screenHeight(context) * 0.04,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
      ),
    );

    if (loginController.loginState == LoginState.login) {
      return [
        //Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.02),
        SizedBox(
          height: Dimensions.screenHeight(context) * 0.07,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: signButton,
          ),
        ),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.005),
        SizedBox(
          height: Dimensions.screenHeight(context) * 0.09,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Não tem uma conta?',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  loginController.loginState = LoginState.signUp;
                },
                child: Text(
                  "Inscreva-se",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.02),
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
        Dimensions.heightSpacer(Dimensions.inBetweenItensPadding * 2),
      ];
    } else {
      return [
        Dimensions.heightSpacer(Dimensions.screenHeight(context) * 0.01),
        SizedBox(
          //alignment: Alignment.centerRight,
          height: Dimensions.screenHeight(context) * 0.07,
          width: Dimensions.screenWidth(context) / 0.15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: signButton,
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ];
    }
  }

  void _signInSignUp(LoginController loginController) {
    loginController.handleSignInSignUp().then(
      (result) {
        if (result.status) {
          Navigator.pushNamedAndRemoveUntil(
              context, GenericRouter.homeRoute, (Route<dynamic> route) => false,
              arguments: loginController.email);
          return;
        }
        if (!result.status && result.errorCode == ErrorMessages.invalidInputs) {
          return;
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildErrorDialog(context, loginController, result);
          },
        );
        return;
      },
    );
  }

  Widget _buildErrorDialog(
      BuildContext context, LoginController loginController, Result result) {
    return AlertDialog(
      title: Center(
        child: result.errorCode == '201'
            ? const Text(
                "Alerta",
                style: TextStyle(color: Colors.grey),
              )
            : const Text("Erro", style: TextStyle(color: Colors.grey)),
      ),
      content: Text(
        _getDialogErrorMessage(result),
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Fechar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  String _getDialogErrorMessage(Result result) {
    if (result.errorCode == ACCOUNT_EXISTS) {
      return ErrorMessages.alreadyRegistered;
    }
    if (result.errorCode == EMAIL_NOT_FOUND ||
        result.errorCode == ERROR_WRONG_PASSWORD) {
      return ErrorMessages.failedLoginAttempt;
    }
    return ErrorMessages.unknownError;
  }
}
