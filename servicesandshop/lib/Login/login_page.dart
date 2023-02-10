import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:servicesandshop/Login/auth.dart';
import 'package:servicesandshop/Login/auth_provider.dart';
import 'package:servicesandshop/components/constants.dart';


class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        showSpinner = true;
      });
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId =
              await auth.signInWithEmailAndPassword(email, _password);
          print('Signed in: $userId');
        } else {
          final String userId =
              await auth.createUserWithEmailAndPassword(email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
        setState(() {
          showSpinner = false;
        });
      } catch (e) {
        print(e);
        kErrorMsgAlert(context).show();
      } finally {
        setState(() {
          showSpinner = false;
        });
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  List<Color> _colors = [
    //Get list of colors
    Colors.black54,
    Colors.white,
  ];

  int _currentIndex = 0;
  int _currentIndex1 = 1;

  _onChanged() {
    //update with a new color when the user taps button
    int _colorCount = _colors.length;

    setState(() {
      if (_currentIndex == _colorCount - 1) {
        _currentIndex = 0;
        _currentIndex1 = 1;
      } else {
        _currentIndex += 1;
        _currentIndex1 -= 1;
      }
    });
  }

  bool showSpinner = false;
  bool _obscureTextLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: 850,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff43cea2), Color(0xff185a9d)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Image(
                          width: 200.0,
                          height: 191.0,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/img/logo.png')),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.black,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  child: Text(
                                    'Existing',
                                    style: TextStyle(
                                      color: _colors[_currentIndex],
                                    ),
                                  ),
                                  onPressed: () {
                                    _onChanged();
                                    moveToLogin();
                                  },
                                  color: _colors[
                                      _currentIndex1], //specify background color  of button from our list of colors
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                  ),
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                      color: _colors[_currentIndex1],
                                    ),
                                  ),
                                  onPressed: () {
                                    _onChanged();
                                    moveToRegister();
                                  },
                                  color: _colors[
                                      _currentIndex], //specify background color  of button from our list of colors
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: buildInputs() + buildSubmitButtons(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.0),
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: "WorkSansMedium"),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.white10,
                                    Colors.white,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            width: 100.0,
                            height: 1.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white10,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            width: 100.0,
                            height: 1.0,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    title: new Text(
                                      "Warning",
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: Image.asset(
                                          "assets/img/warning.png",
                                          width: 100.0,
                                          height: 80.0,
                                        ),
                                      ),
                                      Text(""),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "This features will add soon . so please support us by using this app.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("assets/img/google-logo.png",
                                  width: 90, height: 90),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: TextFormField(
          key: Key('email'),
          decoration: InputDecoration(
              icon: Icon(
                FontAwesomeIcons.envelope,
                size: 22.0,
                color: Colors.black,
              ),
              labelText: 'Email'),
          validator: EmailFieldValidator.validate,
          onSaved: (String value) => email = value,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: TextFormField(
          key: Key('password'),
          decoration: InputDecoration(
              icon: Icon(
                FontAwesomeIcons.lock,
                size: 22.0,
                color: Colors.black,
              ),
              suffixIcon: GestureDetector(
                onTap: _toggleLogin,
                child: Icon(
                  _obscureTextLogin
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  size: 15.0,
                  color: Colors.black,
                ),
              ),
              labelText: 'Password'),
          obscureText: _obscureTextLogin,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            key: Key('signIn'),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onPressed: () {
              validateAndSubmit();
            },
          ),
        ),
      ];
    } else {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          child: Column(
            children: <Widget>[


                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.lock,
                            size: 22.0,
                            color: Colors.black,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _toggleLogin,
                            child: Icon(
                              _obscureTextLogin
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              size: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Reenter the Password'),
                      obscureText: _obscureTextLogin,

                    ),



              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Create An Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    validateAndSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ];
    }
  }  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

}
