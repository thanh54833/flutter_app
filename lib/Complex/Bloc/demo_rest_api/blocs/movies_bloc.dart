import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    " _moviesFetcher.isClosed :.. ${_moviesFetcher.isClosed} ".Log();

    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
