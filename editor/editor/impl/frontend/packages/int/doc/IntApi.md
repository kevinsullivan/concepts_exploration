# intapi.api.IntApi

## Load the API package
```dart
import 'package:intapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getInt**](IntApi.md#getint) | **GET** /Int/get | Get Int
[**optionsGetInt**](IntApi.md#optionsgetint) | **OPTIONS** /Int/get | getInt Cors
[**optionsSetInt**](IntApi.md#optionssetint) | **OPTIONS** /Int/set | CORS setInt support
[**setInt**](IntApi.md#setint) | **PUT** /Int/set | Set Int


# **getInt**
> Int getInt()

Get Int

Get the integer 

### Example
```dart
import 'package:intapi/api.dart';

final api = Intapi().getIntApi();

try {
    final response = api.getInt();
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntApi->getInt: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Int**](Int.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsGetInt**
> optionsGetInt()

getInt Cors

Enable CORS  

### Example
```dart
import 'package:intapi/api.dart';

final api = Intapi().getIntApi();

try {
    api.optionsGetInt();
} catch on DioError (e) {
    print('Exception when calling IntApi->optionsGetInt: $e\n');
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

# **optionsSetInt**
> optionsSetInt()

CORS setInt support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:intapi/api.dart';

final api = Intapi().getIntApi();

try {
    api.optionsSetInt();
} catch on DioError (e) {
    print('Exception when calling IntApi->optionsSetInt: $e\n');
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

# **setInt**
> String setInt(int_)

Set Int

Set the integer 

### Example
```dart
import 'package:intapi/api.dart';

final api = Intapi().getIntApi();
final Int int_ = ; // Int | 

try {
    final response = api.setInt(int_);
    print(response);
} catch on DioError (e) {
    print('Exception when calling IntApi->setInt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **int_** | [**Int**](Int.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

