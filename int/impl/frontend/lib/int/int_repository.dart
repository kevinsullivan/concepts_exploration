import 'package:intapi/intapi.dart';
import 'package:intapi/src/api.dart';
import 'package:intapi/src/model/int.dart' as int_state;

// nphair: read up on functors on category theories..
// nphair: take away - use a represetation that is convenient for layer
//   what is convenient in one isn't convenent in another..

class IntRepository {
  static var MockStore = 0;

  Intapi intApi = Intapi(
      basePathOverride:
          'https://v3d3edk9qe.execute-api.us-east-1.amazonaws.com/v1');

  IntRepository();

  Future<int_state.Int> get() async {
    final response = intApi.getIntApi().getInt();
    final intStateInbound = (await response).data;
    return intStateInbound!;

    // Testing.
    //final builder = int_state.IntBuilder();
    //builder.value = MockStore;
    //return builder.build();
  }

  // TODO: what/how do we propogate info about error (e.g., aws is down) back up
  // and the chain.
  Future<void> set(int_state.Int val) async {
    final response = await intApi.getIntApi().setInt(int_: val);

    // Testing.
    //MockStore = val.value!;
  }
}
