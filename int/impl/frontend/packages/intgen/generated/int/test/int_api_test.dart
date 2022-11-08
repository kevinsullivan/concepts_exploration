import 'package:test/test.dart';
import 'package:intgen/intgen.dart';


/// tests for IntApi
void main() {
  final instance = Intgen().getIntApi();

  group(IntApi, () {
    // Get Int
    //
    // Get the Integer 
    //
    //Future<Int> getInt() async
    test('test getInt', () async {
      // TODO
    });

    // getInt Cors
    //
    // Enable CORS  
    //
    //Future optionsGetInt() async
    test('test optionsGetInt', () async {
      // TODO
    });

    // CORS setInt support
    //
    // Enable CORS by returning correct headers 
    //
    //Future optionsSetInt() async
    test('test optionsSetInt', () async {
      // TODO
    });

    // Set Int
    //
    // Set the Integer 
    //
    //Future<String> setInt({ Int int_ }) async
    test('test setInt', () async {
      // TODO
    });

  });
}
