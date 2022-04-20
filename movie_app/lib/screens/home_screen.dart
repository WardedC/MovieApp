import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        centerTitle: true,
        elevation: 0,
        actions:  const [
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.search, color: Colors.white,))
        ],
      ),
      body: Column(
        children: [
          CardSwiper()
        ],
      )
    );
  }
}