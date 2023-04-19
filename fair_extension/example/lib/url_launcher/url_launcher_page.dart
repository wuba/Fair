import 'package:fair/fair.dart';
import 'package:fair_extension/url_launcher/fair_url_launcher_plugin.dart';
import 'package:flutter/material.dart';

@FairPatch()
class UrlLauncherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UrlLauncherPageState();
}

class UrlLauncherPageState extends State<UrlLauncherPage> {
  String _phone = '18888888888';
  String _message = 'This is a message from 58';
  final String _url = 'https://m.58.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UrlLauncher Example'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Text('Input the phone number/email'),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: _onPhoneTextChanged,
                    decoration: const InputDecoration(
                      hintText: 'Input the phone number/email',
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Text('Input the message'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: TextField(
                  onChanged: _onMessageTextChanged,
                  decoration: const InputDecoration(
                    hintText: 'Input the message',
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _makePhoneCall,
                child: const Text('Make phone call'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _sendSMS,
                child: const Text('Send SMS'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _sendMail,
                child: const Text('Send Email'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_url),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _launchInBrowser,
                child: const Text('Launch in browser'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _launchInWebViewOrVC,
                child: const Text('Launch in app'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _launchInWebViewWithoutJavaScript,
                child: const Text('Launch in app (JavaScript OFF)'),
              ),
              MaterialButton(
                color: Colors.blue,
                onPressed: _launchInWebViewWithoutDomStorage,
                child: const Text('Launch in app (DOM storage OFF)'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: _launchUniversalLinkIos,
                  child: const Text(
                      'Launch a universal link in a native app, fallback to Safari'),
                ),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
            ],
          ),
        ],
      ),
    );
  }

  void _onPhoneTextChanged(String text) {
    _phone = text;
  }

  void _onMessageTextChanged(String text) {
    _message = text;
  }

  void _makePhoneCall() {
    FairUrlLauncher.makePhoneCall(_phone);
  }

  void _sendSMS() {
    FairUrlLauncher.sendSMS(phoneNumber: _phone, message: _message);
  }

  void _sendMail() {
    FairUrlLauncher.sendMail(email: _phone, message: _message);
  }

  void _launchInBrowser() {
    FairUrlLauncher.launchInBrowser(_url);
  }

  void _launchInWebViewOrVC() {
    FairUrlLauncher.launchInWebViewOrVC(_url);
  }

  void _launchInWebViewWithoutJavaScript() {
    FairUrlLauncher.launchInWebViewWithoutJavaScript(_url);
  }

  void _launchInWebViewWithoutDomStorage() {
    FairUrlLauncher.launchInWebViewWithoutDomStorage(_url);
  }

  void _launchUniversalLinkIos() {
    FairUrlLauncher.launchUniversalLinkIos(_url);
  }
}
