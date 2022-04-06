import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/repos/StreamableRepository.dart';

/// Listen for [StreamableRepository] updates and handles them with [onUpdateFromRepo] method
abstract class RepoListeningCubit<State, RepoModel extends Model> extends Cubit<State>{

  RepoListeningCubit({required State initial, required StreamableRepository<RepoModel> repo})
      :super(initial){
    _repoStreamSubscription = repo.stream.listen(onUpdateFromRepo);
  }

  late final StreamSubscription<RepoModel> _repoStreamSubscription;

  onUpdateFromRepo(RepoModel model);

  @mustCallSuper
  @override
  Future<void> close() {
    _repoStreamSubscription.cancel();
    return super.close();
  }

}