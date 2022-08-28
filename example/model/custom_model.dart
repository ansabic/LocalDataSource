import 'package:local_data_source/local_data_source.dart';

part 'custom_model.g.dart';

@HiveType(typeId: 0)
class CustomModel extends Equatable {
  @HiveField(0)
  final String first;
  @HiveField(1)
  final double second;

  const CustomModel({required this.first, required this.second});

  @override
  List<Object?> get props => [first, second];
}
