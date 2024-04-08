import 'package:equatable/equatable.dart';

abstract class BaseUseCase<Params, Response> {
  Future<Response> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
