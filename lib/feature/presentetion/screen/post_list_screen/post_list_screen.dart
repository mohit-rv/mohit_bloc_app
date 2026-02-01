import 'package:bloclearnbyproject/feature/data/model/post_list_model/post_model.dart';
import 'package:bloclearnbyproject/feature/presentetion/post_list/post_block/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListScreen1 extends StatefulWidget {
  const PostListScreen1({super.key});

  @override
  State<PostListScreen1> createState() => _PostListScreen1State();
}

class _PostListScreen1State extends State<PostListScreen1> {
  @override
  void initState() {
    super.initState();
    // Trigger API call
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }

          if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No data found"));
        },
      ),
    );
  }
}




// FULL PROFESSIONAL POST LIST SCREEN (Retry + Refresh Included)

//✔️ Full screen loader
//✔️ Error screen with Retry button
//✔️ Pull-to-refresh
//✔️ Clean UI
//✔️ Production-ready structure




class PostListScreen2 extends StatefulWidget {
  const PostListScreen2({super.key});

  @override
  State<PostListScreen2> createState() => _PostListScreen2State();
}

class _PostListScreen2State extends State<PostListScreen2> {
  @override
  void initState() {
    super.initState();
    // Fetch data on screen load
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          // -----------------------
          // FULL SCREEN LOADER
          // -----------------------
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // -----------------------
          // ERROR + RETRY BUTTON
          // -----------------------
          if (state is PostError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 60, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostBloc>().add(FetchPostsEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // -----------------------
          // LOADED LIST VIEW + REFRESH
          // -----------------------
          if (state is PostLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(FetchPostsEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}



// paginetion

class PostListScreen3 extends StatefulWidget {
  const PostListScreen3({super.key});

  @override
  State<PostListScreen3> createState() => _PostListScreen3State();
}

class _PostListScreen3State extends State<PostListScreen3> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<PostBloc>().add(FetchPostsEvent());

    _scrollController.addListener(() {
      final bloc = context.read<PostBloc>();

      // Prevent extra calls
      if (bloc.isLoadingMore) return;
      if (bloc.state is PostNoMoreData) return;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        bloc.add(LoadMorePostsEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts Pagination")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          // FULL SCREEN LOADER
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ERROR STATE + RETRY BUTTON
          if (state is PostError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 60, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<PostBloc>().add(FetchPostsEvent()),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // LOADED + PAGINATION UI
          final bloc = context.read<PostBloc>();

          List<PostModel> posts = [];

          if (state is PostLoaded) {
            posts = state.posts;
          } else if (state is PostPaginationLoading) {
            posts = state.oldPosts;
          } else {
            posts = bloc.allPosts; // fallback
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostBloc>().add(FetchPostsEvent());
              await Future.delayed(const Duration(milliseconds: 800));
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  // Bottom Loader
                  if (state is PostPaginationLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // No More Data
                  if (state is PostNoMoreData) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "No more posts",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                }

                // NORMAL ITEM
                final post = posts[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(post.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(post.body),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


//





// ✔ Pagination
// ✔ Search bar with debounce (connected to BLoC)
// ✔ Pull-to-refresh
// ✔ Error screen
// ✔ Retry button
// ✔ Bottom loader
// ✔ No more data
// ✔ Clean structure

class PostListScreen4 extends StatefulWidget {
  const PostListScreen4({super.key});

  @override
  State<PostListScreen4> createState() => _PostListScreen4State();
}

class _PostListScreen4State extends State<PostListScreen4> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Fetch first page
    context.read<PostBloc>().add(FetchPostsEvent());

    // Pagination scroll listener
    _scrollController.addListener(() {
      final bloc = context.read<PostBloc>();

      if (bloc.isLoadingMore) return;
      if (bloc.state is PostNoMoreData) return;

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        bloc.add(LoadMorePostsEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts (Module-3 Complete)")),
      body: Column(
        children: [
          // 🔹 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<PostBloc>().add(SearchPostsEvent(value));
              },
              decoration: InputDecoration(
                hintText: "Search posts...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 🔹 MAIN UI
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                // FULL SCREEN LOADER
                if (state is PostLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ERROR UI
                if (state is PostError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error, size: 60, color: Colors.red),
                        const SizedBox(height: 12),
                        Text(state.message),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PostBloc>().add(FetchPostsEvent());
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                final bloc = context.read<PostBloc>();
                List<PostModel> posts = [];

                if (state is PostLoaded) {
                  posts = state.posts;
                } else if (state is PostPaginationLoading) {
                  posts = state.oldPosts;
                } else {
                  posts = bloc.allPosts;
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PostBloc>().add(RefreshPostsEvent());
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == posts.length) {
                        if (state is PostPaginationLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (state is PostNoMoreData) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "No more posts",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      }

                      final post = posts[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(post.body),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
