import 'package:flutter/material.dart';

class SearchEvent extends StatelessWidget {
  const SearchEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 0.8),
          ),
          hintText: 'Search all events...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}