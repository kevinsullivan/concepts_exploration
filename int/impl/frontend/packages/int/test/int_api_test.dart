import 'package:test/test.dart';
import 'package:intapi/intapi.dart';


/// tests for IntApi
void main() {
  final instance = Intapi().getIntApi();

  group(IntApi, () {
    // Get Int
    //
    // Get the integer 
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
    // Set the integer 
    //
    //Future<String> setInt({ Int int_ }) async
    test('test setInt', () async {
      // TODO
    });

  });
}
