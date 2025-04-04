import 'package:flutter_bloc/flutter_bloc.dart';
import 'job_event.dart';
import 'job_state.dart';
import '../services/job_service.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobService jobService = JobService();

  JobBloc() : super(JobInitial()) {
    on<FetchJobsEvent>(_onFetchJobs);
  }

  Future<void> _onFetchJobs(FetchJobsEvent event, Emitter<JobState> emit) async {
    final currentState = state;
    int nextPage = 1;
    if (currentState is JobLoaded) {
      nextPage = currentState.page + 1;
    } else {
      emit(JobLoading());
    }
    try {
      final jobs = await jobService.fetchJobs(nextPage);
      bool hasReachedMax = jobs.isEmpty;
      if (currentState is JobLoaded) {
        emit(JobLoaded(
          jobs: currentState.jobs + jobs,
          hasReachedMax: hasReachedMax,
          page: nextPage,
        ));
      } else {
        emit(JobLoaded(jobs: jobs, hasReachedMax: hasReachedMax, page: nextPage));
      }
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
