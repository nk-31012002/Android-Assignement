import 'package:equatable/equatable.dart';
import '../models/job.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object?> get props => [];
}

class FetchJobsEvent extends JobEvent {}

class RefreshJobsEvent extends JobEvent {}

class BookmarkJobEvent extends JobEvent {
  final Job job;

  const BookmarkJobEvent(this.job);

  @override
  List<Object?> get props => [job];
}
