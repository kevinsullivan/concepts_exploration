# Functions

## Build
This project uses the openapi maven plugin to generate models to be used by our
lambda. If you want to generate the models before compiling the project, say,
for autocompletion in your IDE, then use the `generate-sources` lifecycle phase
of maven.
```bash
mvn generate-sources
```

With the models generated your IDE should have the source it needs for
code completion.

To build the project you must remember to still call,
```bash
mvn package
```

## Adding Ts
If we want to add support for a new collection item, we need 2 things.
1. A model/pojo the jackson can serialize the data into.
2. An entry in the StateMapper.

This is how we reestablish strong types after the data is transmitted.