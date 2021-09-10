import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable{}

class SavedAsFavorite extends FavoriteState {
  @override
  List<Object?> get props => [];
}

class NotFavorite extends FavoriteState {
  @override
  List<Object?> get props => [];
}
