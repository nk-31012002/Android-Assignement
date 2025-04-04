import 'package:flutter/material.dart';
import '../models/job.dart';
import '../services/database_helper.dart';
import 'job_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Job> _bookmarkedJobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() async {
    final jobs = await DatabaseHelper.instance.getBookmarkedJobs();
    setState(() {
      _bookmarkedJobs = jobs;
      _isLoading = false;
    });
  }

  void _removeBookmark(int id) async {
    await DatabaseHelper.instance.removeBookmark(id);
    setState(() {
      _bookmarkedJobs.removeWhere((job) => job.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bookmark removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Jobs'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarkedJobs.isEmpty
          ? _buildEmptyState()
          : _buildJobList(),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text('No Bookmarked Jobs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Save jobs to access them later!',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildJobList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _bookmarkedJobs.length,
      itemBuilder: (context, index) {
        final job = _bookmarkedJobs[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              job.title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(job.location,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Salary: ${job.salary}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeBookmark(job.id),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)),
              );
            },
          ),
        );
      },
    );
  }
}
