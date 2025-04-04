import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/job_bloc.dart';
import '../blocs/job_event.dart';
import '../blocs/job_state.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';
import '../models/job.dart';

class JobListScreen extends StatefulWidget {
  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final ScrollController _scrollController = ScrollController();
  late JobBloc _jobBloc;

  @override
  void initState() {
    super.initState();
    _jobBloc = BlocProvider.of<JobBloc>(context);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      if (_jobBloc.state is JobLoaded && !(_jobBloc.state as JobLoaded).hasReachedMax) {
        _jobBloc.add(FetchJobsEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading && state is! JobLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobError) {
            return Center(child: Text(state.message));
          } else if (state is JobLoaded) {
            if (state.jobs.isEmpty) {
              return const Center(child: Text('No Jobs Found'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax ? state.jobs.length : state.jobs.length + 1,
              itemBuilder: (context, index) {
                if (index < state.jobs.length) {
                  final Job job = state.jobs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)),
                      );
                    },
                    child: JobCard(job: job),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
