import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController(
    text: 'admin',
  ); // dev 默认值
  final TextEditingController _password = TextEditingController(
    text: 'admin123',
  );
  final TextEditingController _code = TextEditingController();

  String uuid = '';
  String codeImgBase64 = '';

  @override
  void initState() {
    super.initState();
    getCode();
  }

  Future<void> getCode() async {
    // 替换成你自己的接口地址
    final response = await http.get(
      Uri.parse('http://vue.ruoyi.vip/prod-api/captchaImage'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        codeImgBase64 = data['img'];
        uuid = data['uuid'];
      });
    } else {
      print('验证码获取失败');
    }
  }

  Future<void> submit() async {
    final username = _username.text.trim();
    final password = _password.text.trim();
    final code = _code.text.trim();

    if (username.isEmpty || password.isEmpty || code.isEmpty) {
      showMessage('请填写完整信息');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await http.post(
        Uri.parse('http://vue.ruoyi.vip/prod-api/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
          'code': code,
          'uuid': uuid,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      Navigator.of(context).pop(); // 关闭 loading

      if (response.statusCode == 200) {
        showMessage('登录成功');
        // TODO: 跳转主页
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        showMessage('登录失败，请重试');
        getCode(); // 刷新验证码
      }
    } catch (e) {
      Navigator.of(context).pop(); // 关闭 loading
      showMessage('请求出错：$e');
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('登录')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 100,
                height: 100,
              ), // 替换你的 logo
              const SizedBox(height: 20),
              const Text(
                '欢迎使用 Flutter App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 40),
              TextField(
                controller: _username,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: '用户名',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: '密码',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _code,
                      decoration: const InputDecoration(
                        labelText: '验证码',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: getCode,
                    child:
                        codeImgBase64.isNotEmpty
                            ? Image.memory(
                              base64Decode(codeImgBase64.split(',').last),
                              width: 100,
                              height: 40,
                            )
                            : const SizedBox(width: 100, height: 40),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed:
                    (_username.text.isEmpty || _password.text.isEmpty)
                        ? null
                        : submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
