import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);
    return Scaffold(
      //appBar: AppBar(),
      body: CustomScrollView(
        
        slivers: [
          _CustomAppBar(
            movieTitle: movie.title,
            movieBackDropPath: movie.fullBackdroppath,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                movieTitle: movie.title,
                movieOriginalTitle: movie.originalTitle,
                movieVoteAvarage: movie.voteAverage,
                movieImg: movie.fullPosterImg,
              ),
              _Overview(movieDescription: movie.overview,),
              CastingCard(),
              SizedBox(height: 10,)

            ]) 
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  //const _CustomAppBar({Key? key}) : super(key: key);
 final String movieTitle;
 final String movieBackDropPath;

  const _CustomAppBar({Key? key, 
   required this.movieTitle, 
   required this.movieBackDropPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Colors.red,
      floating: false,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.only(bottom: 20),
          color: Colors.black38,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movieTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movieBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
      
      
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  //const _PosterAndTitle({Key? key}) : super(key: key);
  final String movieTitle;
  final String movieOriginalTitle;
  final double movieVoteAvarage;
  final String movieImg;

  const _PosterAndTitle({Key? key, 
     required this.movieTitle, 
     required this.movieOriginalTitle, 
     required this.movieVoteAvarage, 
     required this.movieImg
  }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
     final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 190,
              width: 150,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movieImg),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox( width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieTitle,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              
              ),
              Text(
                movieOriginalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.amber,),
                  SizedBox(width: 5,),
                  Text(
                    '$movieVoteAvarage',
                    style: textTheme.caption,
                    )
                ],
              )              
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  //const _Overview({Key? key}) : super(key: key);
  final String movieDescription;

  const _Overview({Key? key, 
  required this.movieDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(this.movieDescription,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        ),
    );
  }
}