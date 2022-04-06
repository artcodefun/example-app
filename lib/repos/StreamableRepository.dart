import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/repos/Repository.dart';


/// A Repository that provides [stream] to listen for data updates
abstract class StreamableRepository<T extends Model> implements Repository<T>, Streamable<T>{

}