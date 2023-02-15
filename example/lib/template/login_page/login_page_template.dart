import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String pwd = '';
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://pic3.58cdn.com.cn/nowater/frs/n_v3d3d6d8fe3a6a4212b8d40aca6b343012.jpg'),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Image.network(
                'https://pic1.58cdn.com.cn/nowater/frs/n_v3862a7fea83c746b78a46a16e00812310.png',
                height: 50,
                width: 50,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                '登录页',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: _emailChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email Address',
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: _pwdChanged,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            GestureDetector(
              onTap: _onLogin,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                alignment: Alignment.center,
                height: 60,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Forget Password?',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                'Or use a social account to login',
                style: TextStyle(
                  fontSize: 13,
                  color: Sugar.colorsWithOpacity(Colors.white, 0.8),
                ),
              ),
            ),
            Sugar.ifEqualBool(isLogin,
                trueValue: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Click Login >>> Email >>> $email PWD >>> $pwd',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                falseValue: Container()),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://pic8.58cdn.com.cn/nowater/frs/n_v3858e1e07b41147329939e41903a444cc.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    'https://pic5.58cdn.com.cn/nowater/frs/n_v3d139c179b97946458a1abd1d9598659f.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    'https://pic2.58cdn.com.cn/nowater/frs/n_v3730125696e36437da2921e8506477bf8.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    'https://pic4.58cdn.com.cn/nowater/frs/n_v37cda806f6e7448089b880888447f89c8.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _emailChanged(String value) {
    email = value;
  }

  void _pwdChanged(String value) {
    pwd = value;
  }

  void _onLogin() {
    isLogin = true;
    setState(() {});
  }
}
