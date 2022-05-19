import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

var sign_in_with_apple_component = {
  'AuthorizationCredentialAppleID': (props) => AuthorizationCredentialAppleID(
        userIdentifier: props['userIdentifier'],
        givenName: props['givenName'],
        familyName: props['familyName'],
        email: props['email'],
        authorizationCode: props['authorizationCode'],
        identityToken: props['identityToken'],
        state: props['state'],
      ),
  'AuthorizationCredentialPassword': (props) => AuthorizationCredentialPassword(
        username: props['username'],
        password: props['password'],
      ),
  'AppleIDAuthorizationRequest': (props) => AppleIDAuthorizationRequest(
        scopes:
            List<AppleIDAuthorizationScopes>.from(props['scopes'] ?? const []),
        nonce: props['nonce'],
        state: props['state'],
      ),
  'PasswordAuthorizationRequest': (props) => PasswordAuthorizationRequest(),
  'AppleIDAuthorizationScopes': {
    'values': AppleIDAuthorizationScopes.values,
    'email': AppleIDAuthorizationScopes.email,
    'fullName': AppleIDAuthorizationScopes.fullName,
  },
  'CredentialState': {
    'values': CredentialState.values,
    'authorized': CredentialState.authorized,
    'revoked': CredentialState.revoked,
    'notFound': CredentialState.notFound,
  },
  'UnknownSignInWithAppleException': (props) => UnknownSignInWithAppleException(
        platformException: props['platformException'],
      ),
  'SignInWithAppleNotSupportedException': (props) =>
      SignInWithAppleNotSupportedException(
        message: props['message'],
      ),
  'SignInWithAppleAuthorizationException': (props) =>
      SignInWithAppleAuthorizationException(
        code: props['code'],
        message: props['message'],
      ),
  'SignInWithAppleCredentialsException': (props) =>
      SignInWithAppleCredentialsException(
        message: props['message'],
      ),
  'AuthorizationErrorCode': {
    'values': AuthorizationErrorCode.values,
    'canceled': AuthorizationErrorCode.canceled,
    'failed': AuthorizationErrorCode.failed,
    'invalidResponse': AuthorizationErrorCode.invalidResponse,
    'notHandled': AuthorizationErrorCode.notHandled,
    'unknown': AuthorizationErrorCode.unknown,
  },
  'SignInWithApple': (props) => SignInWithApple(),
  'SignInWithApple.getKeychainCredential': (props) =>
      SignInWithApple.getKeychainCredential(),
  'SignInWithApple.getAppleIDCredential': (props) =>
      SignInWithApple.getAppleIDCredential(
        scopes: props['scopes'],
        webAuthenticationOptions: props['webAuthenticationOptions'],
        nonce: props['nonce'],
        state: props['state'],
      ),
  'SignInWithApple.getCredentialState': (props) =>
      SignInWithApple.getCredentialState(
        props['pa'][0],
      ),
  'SignInWithApple.isAvailable': (props) => SignInWithApple.isAvailable(),
  'WebAuthenticationOptions': (props) => WebAuthenticationOptions(
        clientId: props['clientId'],
        redirectUri: props['redirectUri'],
      ),
  'AppleLogoPainter': (props) => AppleLogoPainter(
        color: props['color'],
      ),
  'SignInWithAppleBuilder': (props) => SignInWithAppleBuilder(
        key: props['key'],
        builder: props['builder'],
        fallbackBuilder: props['fallbackBuilder'],
      ),
  'SignInWithAppleButton': (props) => SignInWithAppleButton(
        key: props['key'],
        onPressed: props['onPressed'],
        text: props['text'] ?? 'Sign in with Apple',
        height: props['height']?.toDouble() ?? 44,
        style: props['style'] ?? SignInWithAppleButtonStyle.black,
        borderRadius: props['borderRadius'] ??
            const BorderRadius.all(Radius.circular(8.0)),
        iconAlignment: props['iconAlignment'] ?? IconAlignment.center,
      ),
  'SignInWithAppleButtonStyle': {
    'values': SignInWithAppleButtonStyle.values,
    'black': SignInWithAppleButtonStyle.black,
    'white': SignInWithAppleButtonStyle.white,
    'whiteOutlined': SignInWithAppleButtonStyle.whiteOutlined,
  },
  'IconAlignment': {
    'values': IconAlignment.values,
    'center': IconAlignment.center,
    'left': IconAlignment.left,
  },
};

