## Local Data Source

This package helps to painlessly integrate boilerplate-proof Hive-based local data source secured by
implementation of flutter_secure_storage.

## Features

Uses basic CRUD operations based on hive(noSql) for light database models mostly. Secured by
flutter_secure_storage. Uniquely type defined(every model entity / runtime type, corresponds to only
one entity in hive, defined by TypeAdapter).

## Getting started

You will still have to add dependencies(if you didn't) for build_runner and hive_generator and use
Hive annotations as you would basically using Hive. Example of class setup:

    import 'package:local_data_source/local_data_source.dart';

    part 'custom_model.g.dart';

    @HiveType(typeId: 0)
    class CustomModel extends Equatable { 
        @HiveField(0)
        final String first; 
        @HiveField(1)
        final double second;

        const CustomModel({required this.first,required this.second});

        @override
        List<Object?> get props => [first, second];

    }

Before initializing LocalDataSource make sure you have all Hive types with its' type adapters
generated with "flutter pub run build_runner build --delete-conflicting-issues". Adjust according to
an issue.

## Usage

Run LocalDataSource.builder where you pass onDone callback in which you additionally register all
TypeAdapters needed(type-defined) and you are ready to go.

Basic setup should look like this:

    void main() async { 
        await LocalDataSource.builder( (builder) async {
            builder.appendAdapter<CustomModel>(adapter: CustomModelAdapter());
            builder.appendAdapter<SecondModel>(adapter: SecondModelAdapter());
            await builder.build(); 
        });
        runApp(const MyApp());
    }

After this you can use CRUD-based methods from LocalDataSource anywhere you want.

## Additional information

Feel free to report any found bugs.

