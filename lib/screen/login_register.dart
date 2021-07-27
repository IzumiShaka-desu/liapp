import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/consts/utils.dart';
import 'package:liapp/model/profile.dart';
import 'package:liapp/provider/main_provider.dart';
import 'package:liapp/screen/page_container.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  Map<String, TextEditingController> controller = {
    'emailLogin': TextEditingController(),
    'emailRegister': TextEditingController(),
    'fullname': TextEditingController(),
    'passwordLogin': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'password': TextEditingController(),
  };
  setControllerEmpty() {
    for (String i in controller.keys) {
      controller[i].text = '';
    }
  }

  bool isSuccessfull = false;
  PageController _pageController = PageController();
  double currentPageValue = 0;
  bool isLoading = false;
  GlobalKey<ScaffoldState> sk = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return SafeArea(
      child: Stack(children: [
        Positioned.fill(
          child: Container(),
        ),
        Container(
          child: Scaffold(
            key: sk,
            body: ChangeNotifierProvider<MainProvider>(
              create: (BuildContext context) => MainProvider(),
              child: Container(
                child: Stack(children: [
                  Positioned.fill(
                      child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          color: ColorPalette.mainWhite,
                        ),
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DotsIndicator(
                                dotsCount: 2,
                                position: currentPageValue,
                                decorator: DotsDecorator(
                                  size: const Size.square(9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: ColorPalette.secondary,
                            child: PageView(
                              controller: _pageController,
                              physics: (isLoading)
                                  ? NeverScrollableScrollPhysics()
                                  : AlwaysScrollableScrollPhysics(),
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    child: Consumer<MainProvider>(
                                      builder: (ctx, provider, _) => LoginForm(
                                        size: size,
                                        controller: controller,
                                        currentPageValue: currentPageValue,
                                        button: InkWell(
                                          onTap: () => (!isLoading)
                                              ? exectLogin(
                                                  controller['emailLogin'].text,
                                                  controller['passwordLogin']
                                                      .text,
                                                  provider)
                                              : null,
                                          child: AnimatedContainer(
                                            decoration: BoxDecoration(
                                              color: ColorPalette.altBlue,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 50,
                                            width: size.width * 0.6,
                                            child: Center(
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    color:
                                                        ColorPalette.secondary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            curve: Curves.bounceOut,
                                            transform: Matrix4.identity()
                                              ..scale((currentPageValue == 0)
                                                  ? 1.0
                                                  : 0.00000001),
                                            duration:
                                                Duration(milliseconds: 250),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    child: Consumer<MainProvider>(
                                      builder: (context, provider, _) =>
                                          RegisterForm(
                                        size: size,
                                        controller: controller,
                                        isLoading: isLoading,
                                        currentPageValue: currentPageValue,
                                        button: InkWell(
                                          onTap: () => (!isLoading)
                                              ? exectRegister(
                                                  controller['fullname'].text,
                                                  controller['password'].text,
                                                  controller['confirmPassword']
                                                      .text,
                                                  controller['emailRegister']
                                                      .text,
                                                  provider)
                                              : null,
                                          child: AnimatedContainer(
                                            decoration: BoxDecoration(
                                              color: ColorPalette.altBlue,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 50,
                                            width: size.width * 0.6,
                                            child: Center(
                                              child: Text(
                                                'Register',
                                                style: TextStyle(
                                                    color:
                                                        ColorPalette.secondary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            curve: Curves.bounceOut,
                                            transform: Matrix4.identity()
                                              ..scale((currentPageValue == 1)
                                                  ? 1.0
                                                  : 0.00000001),
                                            duration:
                                                Duration(milliseconds: 250),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ]),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: (isSuccessfull) ? -size.height : -2,
          right: (isSuccessfull) ? -size.width : -2,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            height: (isSuccessfull) ? size.height * 3 : 0,
            width: (isSuccessfull) ? size.width * 3 : 0,
            onEnd: () => goToDashboard(),
          ),
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.topCenter,
            height: 100,
            color: Colors.white,
            child: Padding(
              child: Image.asset('images/icon.png'),
              padding: EdgeInsets.all(8),
            ),
          ),
        ),
        (!isLoading)
            ? SizedBox()
            : Container(
                color: Colors.white70,
                child: Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: (isSuccessfull) ? -size.height : -2,
          right: (isSuccessfull) ? -size.width : -2,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            height: (isSuccessfull) ? size.height * 3 : 0,
            width: (isSuccessfull) ? size.width * 3 : 0,
            onEnd: () => goToDashboard(),
          ),
        )
      ]),
    );
  }

  animate() {
    setState(() {
      isSuccessfull = true;
    });
  }

  exectLogin(String email, String password, MainProvider provider) async {
    setState(() {
      isLoading = true;
    });
    var result;
    if (email.isEmpty || password.isEmpty) {
      showSnackbar('email and password is required');
    } else if (emailValidator(email)) {
      result = provider.login(email, password);
    } else {
      showSnackbar('please input a valid email');
    }
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => PageContainer(user: result,),
        ),
      );
    } else {
      showSnackbar('email or password not match');
    }
  }

  exectRegister(String fullname, String password, String confirmpassword,
      String email, MainProvider provider) async {
    setState(() {
      isLoading = true;
    });

    if (email.isEmpty || password.isEmpty) {
      showSnackbar('email and password is required');
    } else if (emailValidator(email)) {
      var user = ProfileModel(email: email, password: password, name: fullname);
      provider.register(user);
      showSnackbar('register success, now you can login');
    } else {
      showSnackbar('please input a valid email');
    }
    setState(() {
      isLoading = false;
    });
  }

  goToDashboard() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Home(),
    ));
  }

  showSnackbar(String _msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
        content: Material(
          type: MaterialType.transparency,
          child: Container(
            height: 50,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _msg,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key key,
    @required this.size,
    @required this.controller,
    @required this.isLoading,
    @required this.currentPageValue,
    @required this.button,
  }) : super(key: key);

  final Size size;
  final Map<String, TextEditingController> controller;
  final bool isLoading;
  final double currentPageValue;
  final Widget button;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: size.width * 0.7,
        child: createTextForm(
            controller['fullname'], "nama", Icons.account_circle),
      ),
      Container(
        width: size.width * 0.7,
        child: createTextForm(
            controller['emailRegister'], "email", Icons.alternate_email),
      ),
      Container(
        width: size.width * 0.7,
        child: createTextForm(
            controller['password'], "password", Icons.lock_outline,
            isObscure: true),
      ),
      Container(
        width: size.width * 0.7,
        child: createTextForm(controller['confirmPassword'],
            "konfirmasi password", Icons.lock_outline,
            isObscure: true),
      ),
      SizedBox(height: 20),
      Center(
        child: Material(
          type: MaterialType.transparency,
          child: button,
        ),
      )
    ]);
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required this.size,
    @required this.controller,
    @required this.currentPageValue,
    @required this.button,
  }) : super(key: key);

  final Size size;
  final Map<String, TextEditingController> controller;
  final double currentPageValue;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Container(
        width: size.width * 0.7,
        child: createTextForm(
            controller['emailLogin'], "email", Icons.alternate_email),
      ),
      SizedBox(height: 15),
      Container(
        width: size.width * 0.7,
        child: createTextForm(
            controller['passwordLogin'], "password", Icons.lock_outline,
            isObscure: true),
      ),
      SizedBox(height: 20),
      Material(
        type: MaterialType.transparency,
        child: button,
      )
    ]);
  }
}
