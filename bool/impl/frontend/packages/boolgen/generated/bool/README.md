# boolgen (EXPERIMENTAL)
TODO

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Build package: org.openapitools.codegen.languages.DartDioClientCodegen

## Requirements

* Dart 2.12.0 or later OR Flutter 1.26.0 or later
* Dio 4.0.0+

## Installation & Usage

### pub.dev
To use the package from [pub.dev](https://pub.dev), please include the following in pubspec.yaml
```yaml
dependencies:
  boolgen: 1.0.0
```

### Github
If this Dart package is published to Github, please include the following in pubspec.yaml
```yaml
dependencies:
  boolgen:
    git:
      url: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
      #ref: main
```

### Local development
To use the package from your local drive, please include the following in pubspec.yaml
```yaml
dependencies:
  boolgen:
    path: /path/to/boolgen
```

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:boolgen/boolgen.dart';


final api = Boolgen().getBoolApi();

try {
    final response = await api.getBool();
    print(response);
} catch on DioError (e) {
    print("Exception when calling BoolApi->getBool: $e\n");
}

```

## Documentation for API Endpoints

All URIs are relative to *http://localhost*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
[*BoolApi*](doc/BoolApi.md) | [**getBool**](doc/BoolApi.md#getbool) | **GET** /Bool/get | Get Bool
[*BoolApi*](doc/BoolApi.md) | [**optionsGetBool**](doc/BoolApi.md#optionsgetbool) | **OPTIONS** /Bool/get | getBool Cors
[*BoolApi*](doc/BoolApi.md) | [**optionsSetBool**](doc/BoolApi.md#optionssetbool) | **OPTIONS** /Bool/set | CORS setBool support
[*BoolApi*](doc/BoolApi.md) | [**setBool**](doc/BoolApi.md#setbool) | **PUT** /Bool/set | Set Bool


## Documentation For Models

 - [Bool](doc/Bool.md)


## Documentation For Authorization

 All endpoints do not require authorization.


## Author


