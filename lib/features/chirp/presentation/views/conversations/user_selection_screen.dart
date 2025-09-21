import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This is a placeholder user model - should be replaced with actual user entity
class User {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? email;
  final bool isOnline;

  const User({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.email,
    this.isOnline = false,
  });
}

class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  State<UserSelectionScreen> createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    
    // TODO: Replace with actual user fetching logic
    // This should integrate with your existing user data source
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading
    
    // Mock users - replace with actual data
    _allUsers = [
      const User(
        id: 'user_1',
        name: 'Alice Johnson',
        email: 'alice@example.com',
        isOnline: true,
      ),
      const User(
        id: 'user_2',
        name: 'Bob Smith',
        email: 'bob@example.com',
        isOnline: false,
      ),
      const User(
        id: 'user_3',
        name: 'Carol Wilson',
        email: 'carol@example.com',
        isOnline: true,
      ),
      const User(
        id: 'user_4',
        name: 'David Brown',
        email: 'david@example.com',
        isOnline: false,
      ),
      const User(
        id: 'user_5',
        name: 'Emma Davis',
        email: 'emma@example.com',
        isOnline: true,
      ),
    ];
    
    _filteredUsers = _allUsers;
    setState(() => _isLoading = false);
  }

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredUsers = _allUsers;
      } else {
        _filteredUsers = _allUsers.where((user) {
          final nameLower = user.name.toLowerCase();
          final emailLower = user.email?.toLowerCase() ?? '';
          final queryLower = query.toLowerCase();
          
          return nameLower.contains(queryLower) || 
                 emailLower.contains(queryLower);
        }).toList();
      }
    });
  }

  void _selectUser(User user) {
    context.pop({
      'userId': user.id,
      'userName': user.name,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterUsers('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Users list
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _filteredUsers.isEmpty
                    ? _EmptyUsersWidget(
                        searchQuery: _searchQuery,
                        onRefresh: _loadUsers,
                      )
                    : RefreshIndicator(
                        onRefresh: _loadUsers,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _filteredUsers.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            indent: 72,
                            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                          ),
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return UserTile(
                              user: user,
                              onTap: () => _selectUser(user),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Text(
                    user.name.isNotEmpty
                        ? user.name[0].toUpperCase()
                        : 'U',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                : null,
          ),
          
          // Online status indicator
          if (user.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: user.email != null
          ? Text(
              user.email!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: user.isOnline
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Online',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class _EmptyUsersWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onRefresh;

  const _EmptyUsersWidget({
    required this.searchQuery,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery.isNotEmpty;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearching ? Icons.search_off : Icons.people_outline,
              size: 96,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              isSearching ? 'No users found' : 'No users available',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isSearching
                  ? 'Try searching with different keywords'
                  : 'Check your connection and try again',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (!isSearching) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}