part of 'feed_bloc.dart';


abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}
