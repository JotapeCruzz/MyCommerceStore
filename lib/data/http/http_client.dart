import 'package:http/http.dart' as http;

abstract class IHtppClient {
  Future get({required String url});
}

class HttpClient implements IHtppClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
}
