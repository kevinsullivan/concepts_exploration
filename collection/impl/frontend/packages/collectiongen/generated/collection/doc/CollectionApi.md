# collectiongen.api.CollectionApi

## Load the API package
```dart
import 'package:collectiongen/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**init**](CollectionApi.md#init) | **POST** /Collection/init | initialize a collection
[**insert**](CollectionApi.md#insert) | **POST** /Collection/insert | insert an item into the collection
[**member**](CollectionApi.md#member) | **GET** /Collection/member | Boolean-returning membership predicate function
[**optionsInit**](CollectionApi.md#optionsinit) | **OPTIONS** /Collection/init | CORS init support
[**optionsInsert**](CollectionApi.md#optionsinsert) | **OPTIONS** /Collection/insert | CORS insert support
[**optionsMember**](CollectionApi.md#optionsmember) | **OPTIONS** /Collection/member | CORS member support
[**optionsRemove**](CollectionApi.md#optionsremove) | **OPTIONS** /Collection/remove | CORS remove support
[**remove**](CollectionApi.md#remove) | **POST** /Collection/remove | remove an item from the collection


# **init**
> Collection init(bucket, prefix)

initialize a collection

initialize a collection 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();
final String bucket = bucket_example; // String | 
final String prefix = prefix_example; // String | 

try {
    final response = api.init(bucket, prefix);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->init: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bucket** | **String**|  | [default to 'jackson-concepts-concepts']
 **prefix** | **String**|  | [default to 'collection/Collection/']

### Return type

[**Collection**](Collection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **insert**
> Collection insert(bucket, prefix, contentType, collectionItemPair)

insert an item into the collection

insert an item into the collection 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();
final String bucket = bucket_example; // String | 
final String prefix = prefix_example; // String | 
final String contentType = contentType_example; // String | 
final CollectionItemPair collectionItemPair = ; // CollectionItemPair | A request including a collection X item pair to modify.

try {
    final response = api.insert(bucket, prefix, contentType, collectionItemPair);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->insert: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bucket** | **String**|  | [default to 'jackson-concepts-concepts']
 **prefix** | **String**|  | [default to 'collection/Collection/']
 **contentType** | **String**|  | [optional] 
 **collectionItemPair** | [**CollectionItemPair**](CollectionItemPair.md)| A request including a collection X item pair to modify. | [optional] 

### Return type

[**Collection**](Collection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **member**
> bool member(bucket, prefix, contentType, collectionItemPair)

Boolean-returning membership predicate function

Boolean-returning membership predicate function 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();
final String bucket = bucket_example; // String | 
final String prefix = prefix_example; // String | 
final String contentType = contentType_example; // String | 
final CollectionItemPair collectionItemPair = ; // CollectionItemPair | A request including a collection X item pair to modify.

try {
    final response = api.member(bucket, prefix, contentType, collectionItemPair);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->member: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bucket** | **String**|  | [default to 'jackson-concepts-concepts']
 **prefix** | **String**|  | [default to 'collection/Collection/']
 **contentType** | **String**|  | [optional] 
 **collectionItemPair** | [**CollectionItemPair**](CollectionItemPair.md)| A request including a collection X item pair to modify. | [optional] 

### Return type

**bool**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **optionsInit**
> optionsInit()

CORS init support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();

try {
    api.optionsInit();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsInit: $e\n');
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

# **optionsInsert**
> optionsInsert()

CORS insert support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();

try {
    api.optionsInsert();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsInsert: $e\n');
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

# **optionsMember**
> optionsMember()

CORS member support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();

try {
    api.optionsMember();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsMember: $e\n');
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

# **optionsRemove**
> optionsRemove()

CORS remove support

Enable CORS by returning correct headers 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();

try {
    api.optionsRemove();
} catch on DioError (e) {
    print('Exception when calling CollectionApi->optionsRemove: $e\n');
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

# **remove**
> Collection remove(bucket, prefix, contentType, collectionItemPair)

remove an item from the collection

remove an item from the collection 

### Example
```dart
import 'package:collectiongen/api.dart';

final api = Collectiongen().getCollectionApi();
final String bucket = bucket_example; // String | 
final String prefix = prefix_example; // String | 
final String contentType = contentType_example; // String | 
final CollectionItemPair collectionItemPair = ; // CollectionItemPair | A request including a collection X item pair to modify.

try {
    final response = api.remove(bucket, prefix, contentType, collectionItemPair);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CollectionApi->remove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bucket** | **String**|  | [default to 'jackson-concepts-concepts']
 **prefix** | **String**|  | [default to 'collection/Collection/']
 **contentType** | **String**|  | [optional] 
 **collectionItemPair** | [**CollectionItemPair**](CollectionItemPair.md)| A request including a collection X item pair to modify. | [optional] 

### Return type

[**Collection**](Collection.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

