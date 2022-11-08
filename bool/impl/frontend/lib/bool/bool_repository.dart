import 'package:boolgen/boolgen.dart';

class BoolRepository {
  Boolgen boolApi = Boolgen(
      basePathOverride:
          'https://xnnguys9d0.execute-api.us-east-1.amazonaws.com/v1');

  Future<Bool> get() async {
    final response = boolApi.getBoolApi().getBool();
    final boolStateInbound = (await response).data;
    return boolStateInbound!;
  }

  Future<void> set(Bool arg) async {
    await boolApi.getBoolApi().setBool(bool_: arg);
  }
}
