import 'package:mwwm/mwwm.dart';

/// Authorize in github
class AuthorizeInGithub extends FutureChange<bool> {}

/// Get access token
class GetAccessToken extends FutureChange<String> {}

/// Check is user auth
class IsUserAuthorize extends FutureChange<bool> {}
