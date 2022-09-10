# contributingfactorgen.api.ContributingFactorApi

## Load the API package
```dart
import 'package:contributingfactorgen/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**category**](ContributingFactorApi.md#category) | **GET** /contributing-factor/category | Get the contributing factor&#39;s category
[**description**](ContributingFactorApi.md#description) | **GET** /contributing-factor/description | Get the contributing factor&#39;s description
[**descriptionInsert**](ContributingFactorApi.md#descriptioninsert) | **OPTIONS** /contributing-factor/description | CORS description support


# **category**
> Category category(contributingFactor)

Get the contributing factor's category

Get the contributing factor's category 

### Example
```dart
import 'package:contributingfactorgen/api.dart';

final api = Contributingfactorgen().getContributingFactorApi();
final String contributingFactor = contributingFactor_example; // String | 

try {
    final response = api.category(contributingFactor);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ContributingFactorApi->category: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contributingFactor** | **String**|  | 

### Return type

[**Category**](Category.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **description**
> String description(contributingFactor)

Get the contributing factor's description

Get the contributing factor's description 

### Example
```dart
import 'package:contributingfactorgen/api.dart';

final api = Contributingfactorgen().getContributingFactorApi();
final String contributingFactor = contributingFactor_example; // String | 

try {
    final response = api.description(contributingFactor);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ContributingFactorApi->description: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contributingFactor** | **String**|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **descriptionInsert**
> descriptionInsert()

CORS description support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:contributingfactorgen/api.dart';

final api = Contributingfactorgen().getContributingFactorApi();

try {
    api.descriptionInsert();
} catch on DioError (e) {
    print('Exception when calling ContributingFactorApi->descriptionInsert: $e\n');
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

