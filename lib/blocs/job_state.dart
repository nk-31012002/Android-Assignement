import 'package:equatable/equatable.dart';
import '../models/job.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object?> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> jobs;
  final bool hasReachedMax;
  final int page;

  const JobLoaded({required this.jobs, required this.hasReachedMax, required this.page});

  JobLoaded copyWith({
    List<Job>? jobs,
    bool? hasReachedMax,
    int? page,
  }) {
    return JobLoaded(
      jobs: jobs ?? this.jobs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [jobs, hasReachedMax, page];
}

class JobError extends JobState {
  final String message;
  const JobError(this.message);

  @override
  List<Object?> get props => [message];
}
