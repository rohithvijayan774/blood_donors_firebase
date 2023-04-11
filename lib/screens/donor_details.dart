import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // centerTitle: true,
              title: Text('$name'),
              background: Image.asset(
                'lib/asset/3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Center(child: Text('$name')),
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Center(child: Text('$name')),
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Center(child: Text('$name')),
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Center(child: Text('$name')),
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    child: Center(child: Text('$name')),
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
