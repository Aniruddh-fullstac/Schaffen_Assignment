import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool _isExpanded = false;
  bool _isSearching = false;
  bool _showImagePlaceholder = true;
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _showCircle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 200 && _showImagePlaceholder) {
      setState(() {
        _showImagePlaceholder = false;
      });
    } else if (_scrollController.offset < 200 && !_showImagePlaceholder) {
      setState(() {
        _showImagePlaceholder = true;
      });
    }

    setState(() {
      _showCircle = _scrollController.offset >= 200;
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            _scrollListener();
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            if (_showImagePlaceholder)
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Image.asset(
                        'assets/image.jpeg',
                        width: 400,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                collapsedHeight: kToolbarHeight,
              ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 56.0,
                maxHeight: 56.0,
                child: Container(
                  color: Colors.red,
                  child: Row(
                    children: [
                      Visibility(
                       
                        visible: _showCircle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundImage: AssetImage('assets/image.jpeg'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'The Weeknd',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      4.0),
                              Text(
                                'Community . +11k Members',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () => _showMenu(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (_isSearching) _buildSearchBar(),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: _isSearching
                        ? _buildSearchResults()
                        : _buildMainContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search member',
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _showImagePlaceholder = true;
              });
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: RichText(
            text: TextSpan(
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Sed euismod vestibulum lacus, nec consequat nulla efficitur sit amet. '
                  'Proin eu lorem libero. ',
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(
                  text: _isExpanded
                      ? 'Sed id enim in urna tincidunt sodales. Vivamus vel semper ame...'
                      : 'Read more',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          children: List.generate(
            5,
            (index) => Chip(label: Text('Outdoor')),
          ),
        ),
        SizedBox(height: 16),
        Text('Media, docs and links', style: TextStyle(fontSize: 16)),
        SizedBox(height: 16),
        Container(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 100,
                color: Colors.grey[300],
                margin: EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/image.jpeg', fit: BoxFit.cover),
              ),
              Container(
                width: 100,
                color: Colors.grey[300],
                margin: EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/image.jpeg', fit: BoxFit.cover),
              ),
              Container(
                width: 100,
                color: Colors.grey[300],
                margin: EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/image.jpeg', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text('Mute notification'),
          trailing: IconButton(
            icon: Icon(Icons.notifications_off),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text('Clear chat'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text('Encryption'),
          trailing: IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text('Exit community'),
          trailing: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text('Report'),
          trailing: IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text('Members'),
          trailing: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
                _showImagePlaceholder = false;
              });
            },
          ),
        ),
        ...List.generate(
          10,
          (index) => ListTile(
            leading: CircleAvatar(),
            title: Text('Yashika, 29, India'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 234, 88, 77),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      children: List.generate(
        10,
        (index) => ListTile(
          leading: CircleAvatar(),
          title: Text('Yashika, 29, India'),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
            ),
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Invite'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Add member'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Add Group'),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
