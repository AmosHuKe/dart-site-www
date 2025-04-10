import 'dart:io';

int stopAfter = 10;
// #docregion process-requests
Future<void> main() async {
  final requests = await HttpServer.bind('localhost', 8888);
  // #enddocregion process-requests
  // ignore: no_leading_underscores_for_local_identifiers
  final _requests = requests.take(stopAfter);
  // #docregion process-requests
  await for (final request in _requests) {
    processRequest(request);
  }
}

void processRequest(HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = ContentType('text', 'plain')
      ..write('Hello from the server');
  } else {
    response.statusCode = HttpStatus.notFound;
  }
  response.close();
}

// #enddocregion process-requests
