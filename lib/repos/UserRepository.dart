import 'package:test_app/models/User.dart';
import 'package:test_app/repos/StreamableRepository.dart';

/// StreamableRepository with [User]-specific functionality
abstract class UserRepository implements StreamableRepository<User>{

}