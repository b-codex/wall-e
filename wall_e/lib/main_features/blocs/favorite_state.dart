import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SavedAsFavorite extends FavoriteState {}

class NotFavorite extends FavoriteState {}
