import 'package:mwwm/mwwm.dart';

/// Authorize in github
class AuthorizeInGithub extends FutureChange<bool> {}

/// Disconnect from github
class DisconnectGithub extends FutureChange<void> {}

/// Get access token
class GetAccessToken extends FutureChange<String> {}

/// Check is user auth
class IsUserAuthorize extends FutureChange<bool> {}
