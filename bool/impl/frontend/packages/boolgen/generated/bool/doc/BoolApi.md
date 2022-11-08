# boolgen.api.BoolApi

## Load the API package
```dart
import 'package:boolgen/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getBool**](BoolApi.md#getbool) | **GET** /Bool/get | Get Bool
[**optionsGetBool**](BoolApi.md#optionsgetbool) | **OPTIONS** /Bool/get | getBool Cors
[**optionsSetBool**](BoolApi.md#optionssetbool) | **OPTIONS** /Bool/set | CORS setBool support
[**setBool**](BoolApi.md#setbool) | **PUT** /Bool/set | Set Bool


# **getBool**
> Bool getBool()

Get Bool

Get the Boolean 

### Example
```dart
import 'package:boolgen/api.dart';

final api = Boolgen().getBoolApi();

try {
    final response = api.getBool();
    print(response);
} catch on DioError (e) {
    print('Exception when calling BoolApi->getBool: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Bool**](Bool.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsGetBool**
> optionsGetBool()

getBool Cors

Enable CORS  

### Example
```dart
import 'package:boolgen/api.dart';

final api = Boolgen().getBoolApi();

try {
    api.optionsGetBool();
} catch on DioError (e) {
    print('Exception when calling BoolApi->optionsGetBool: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsSetBool**
> optionsSetBool()

CORS setBool support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:boolgen/api.dart';

final api = Boolgen().getBoolApi();

try {
    api.optionsSetBool();
} catch on DioError (e) {
    print('Exception when calling BoolApi->optionsSetBool: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setBool**
> String setBool(bool_)

Set Bool

Set the boolean 

### Example
```dart
import 'package:boolgen/api.dart';

final api = Boolgen().getBoolApi();
final Bool bool_ = ; // Bool | 

try {
    final response = api.setBool(bool_);
    print(response);
} catch on DioError (e) {
    print('Exception when calling BoolApi->setBool: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bool_** | [**Bool**](Bool.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

