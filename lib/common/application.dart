part 'gitignore.dart';

class Application {
  factory Application() => _instance;
  static final _instance = Application._();
  Application._();

  final _Client client = const _Client(id:_ClientId, secret: _ClientSecret);
}

class _Client {
  const _Client({this.id, this.secret});

  final String id;
  final String secret;
}
