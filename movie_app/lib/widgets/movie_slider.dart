import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> popularsMovies;
  final String? title;
  const MovieSlider({
    Key? key,
    required this.popularsMovies,
    this.title
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 272,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      if(this.title != null)
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          
          const SizedBox( height: 5,),
          Expanded(
            child: ListView.builder(
              itemCount: this.popularsMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                
                return _MoviePoster(popularMovies: this.popularsMovies[index],);
              }),
              ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //const _MoviePoster({Key? key}) : super(key: key);
  final Movie popularMovies;
  const _MoviePoster({
    Key? key,
    required this.popularMovies
    }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'Details', arguments:  'Movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(this.popularMovies.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,),
            ),
          ),
         Text(
            this.popularMovies.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}