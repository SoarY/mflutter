import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginRoute(),
    );
  }
}

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {

  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;
  var tip="tip";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("login"),
      ),
      body: Padding(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
          autovalidateMode:AutovalidateMode.onUserInteraction,
          child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person)
                  ),
                  validator: (v) {
                    return v==null||v.trim().isNotEmpty ? null : "userNameRequired";
                  }
                ),
                TextFormField(
                    autofocus: !_nameAutoFocus,
                    controller: _pwdController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(pwdShow?Icons.visibility_off:Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow=!pwdShow;
                            });
                          },
                        )
                    ),
                    obscureText: !pwdShow,
                    validator: (v) {
                      return v==null||v.trim().isNotEmpty ? null : "passwordRequired";
                    }
                ),
                Padding(
                    padding: EdgeInsets.only(top:25),

                    child: Column(
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55),
                          child: ElevatedButton(
                            onPressed: () { _onLogin(); },
                            child: const Text("login"),
                          ),
                        ),
                        Text(tip)
                      ],
                    ),
                ),
              ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async{
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      setState(() {
        tip="success";
      });
    }
  }
}
