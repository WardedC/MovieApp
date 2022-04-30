import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  

  final List<Movie> movies;
  const CardSwiper({
    Key? key,
    required this.movies
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),

      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        indicatorLayout: PageIndicatorLayout.COLOR,
        //autoplay: true,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, index) {
          final movies = this.movies[index];
          print(movies.fullPosterImg);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'Details', arguments:  movies),
            child: Hero(
              tag: movies.id,
              child: ClipRRect(   
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movies.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        },
        )
      
    );
  }
}