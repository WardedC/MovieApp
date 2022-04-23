import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> popularsMovies;
  final String? title;
  final Function onNextPage;
  const MovieSlider({
    Key? key,
    required this.popularsMovies,
    required this.onNextPage,
    this.title, 
    }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController =  ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 272,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      if(this.widget.title != null)
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          
          const SizedBox( height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: this.widget.popularsMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                
                return _MoviePoster(popularMovies: this.widget.popularsMovies[index],);
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
            onTap: () => Navigator.pushNamed(context, 'Details', arguments: this.popularMovies),
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