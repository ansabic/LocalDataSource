import 'package:local_data_source/local_data_source.dart';

part 'second_model.g.dart';

@HiveType(typeId: 1)
class SecondModel extends Equatable {
  @HiveField(0)
  final String third;
  @HiveField(1)
  final double forth;

  const SecondModel({required this.third, required this.forth});

  @override
  List<Object?> get props => [third, forth];
}
