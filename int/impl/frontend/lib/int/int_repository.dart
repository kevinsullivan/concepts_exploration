import 'package:intgen/intgen.dart';

class IntRepository {
  Intgen intApi = Intgen(
      basePathOverride:
          'https://p4m0eoydoi.execute-api.us-east-1.amazonaws.com/v1');

  Future<Int> get() async {
    final response = intApi.getIntApi().getInt();
    final intStateInbound = (await response).data;
    return intStateInbound!;
  }

  Future<void> set(Int arg) async {
    await intApi.getIntApi().setInt(int_: arg);
  }
}
