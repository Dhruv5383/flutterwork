// lib/screens/home_screen.dart

import 'package:flutter/material.dart';

import 'Api service.dart';
import 'App drawer.dart';
import 'Auth service.dart';
import 'Constants.dart';
import 'Service card.dart';
import 'Service provider.dart';
// import '../models/service_provider.dart';
// import '../services/api_service.dart';
// import '../services/auth_service.dart';
// import '../utils/constants.dart';
// import '../widgets/app_drawer.dart';
// import '../widgets/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  List<ServiceProvider> _allProviders = [];
  List<ServiceProvider> _filtered = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';
  bool _isGridView = false;
  String _userName = 'User';
  final TextEditingController _searchCtrl = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    final user = await _authService.getCurrentUser();
    final providers = await _apiService.fetchServiceProviders();
    if (mounted) {
      setState(() {
        _userName = user['name'] ?? 'User';
        _allProviders = providers;
        _filtered = providers;
        _isLoading = false;
      });
    }
  }

  void _filterByCategory(String cat) {
    setState(() {
      _selectedCategory = cat;
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<ServiceProvider> result = _allProviders;
    if (_selectedCategory != 'All') {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }
    final query = _searchCtrl.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query);
      }).toList();
    }
    _filtered = result;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 180,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 52, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, $_userName! 👋',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    'Find services in your city',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.notifications_outlined,
                                        color: Colors.white),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('No new notifications'),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.accent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Search Bar
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: TextField(
                              controller: _searchCtrl,
                              onChanged: (_) {
                                setState(() => _applyFilters());
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search services, providers...',
                                hintStyle:
                                TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                prefixIcon:
                                Icon(Icons.search, color: AppColors.primary),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                                fillColor: Colors.transparent,
                                filled: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              leading: Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    _isGridView ? Icons.view_list : Icons.grid_view,
                    color: Colors.white,
                  ),
                  tooltip: _isGridView ? 'List View' : 'Grid View',
                  onPressed: () => setState(() => _isGridView = !_isGridView),
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                tabs: const [
                  Tab(text: 'All Services'),
                  Tab(text: 'Top Rated'),
                ],
              ),
            ),

            // Category Chips
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        itemCount: MockData.categories.length,
                        itemBuilder: (_, i) {
                          final cat = MockData.categories[i];
                          final isSelected = _selectedCategory == cat['name'];
                          return GestureDetector(
                            onTap: () => _filterByCategory(cat['name']!),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(cat['icon']!,
                                      style: const TextStyle(fontSize: 14)),
                                  const SizedBox(width: 6),
                                  Text(
                                    cat['name']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(height: 1, color: AppColors.divider),
                  ],
                ),
              ),
            ),

            // Stats Banner
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.9),
                      AppColors.accent.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statItem('${_allProviders.length}+', 'Providers'),
                    _dividerV(),
                    _statItem('8', 'Categories'),
                    _dividerV(),
                    _statItem('4.6★', 'Avg Rating'),
                  ],
                ),
              ),
            ),

            // Content
            if (_isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (_, __) => const ShimmerCard(),
                  childCount: 5,
                ),
              )
            else if (_filtered.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 16),
                        const Text(
                          'No services found',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search or category',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (_isGridView)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (ctx, i) {
                        final p = _filtered[i];
                        return ServiceCard(
                          provider: p,
                          isGridView: true,
                          onTap: () => Navigator.pushNamed(
                            ctx,
                            AppRoutes.serviceDetail,
                            arguments: p,
                          ),
                        );
                      },
                      childCount: _filtered.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (ctx, i) {
                      final p = _filtered[i];
                      return ServiceCard(
                        provider: p,
                        onTap: () => Navigator.pushNamed(
                          ctx,
                          AppRoutes.serviceDetail,
                          arguments: p,
                        ),
                      );
                    },
                    childCount: _filtered.length,
                  ),
                ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(val,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _dividerV() {
    return Container(width: 1, height: 36, color: Colors.white30);
  }
}