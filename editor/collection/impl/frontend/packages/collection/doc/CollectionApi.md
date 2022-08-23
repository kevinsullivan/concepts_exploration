# collectionapi.api.CollectionApi

## Load the API package
```dart
import 'package:collectionapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**callGet**](CollectionApi.md#callget) | **GET** /Collection/get | Get Collection
[**create**](CollectionApi.md#create) | **PUT** /Collection/create | insert an object into the collection
[**optionsGetCollection**](CollectionApi.md#optionsgetcollection) | **OPTIONS** /Collection/get | getCollection Cors
[**optionsSetCollection**](CollectionApi.md#optionssetcollection) | **OPTIONS** /Collection/create | CORS setCollection support


# **callGet**
> Collection callGet(folder)

Get Collection

Get the collection 

### Example
```dart
import 'package:collectionapi/api.dart';

final api = Collectionapi().getCollectionApi();
final String folder = folder_example; // String | 

try {
    final response = api.callGet(folder);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->callGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folder** | **String**|  | 

### Return type

[**Collection**](Collection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **create**
> String create(item, folder, contentType, collection)

insert an object into the collection

insert an object into the collection 

### Example
```dart
import 'package:collectionapi/api.dart';

final api = Collectionapi().getCollectionApi();
final String item = item_example; // String | 
final String folder = folder_example; // String | 
final String contentType = contentType_example; // String | 
final Collection collection = ; // Collection | 

try {
    final response = api.create(item, folder, contentType, collection);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->create: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **item** | **String**|  | 
 **folder** | **String**|  | 
 **contentType** | **String**|  | [optional] 
 **collection** | [**Collection**](Collection.md)|  | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsGetCollection**
> optionsGetCollection()

getCollection Cors

Enable CORS  

### Example
```dart
import 'package:collectionapi/api.dart';

final api = Collectionapi().getCollectionApi();

try {
    api.optionsGetCollection();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsGetCollection: $e\n');
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

# **optionsSetCollection**
> optionsSetCollection()

CORS setCollection support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:collectionapi/api.dart';

final api = Collectionapi().getCollectionApi();

try {
    api.optionsSetCollection();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsSetCollection: $e\n');
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
