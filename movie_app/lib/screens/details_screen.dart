import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      //appBar: AppBar(),
      body: CustomScrollView(
        
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Colors.indigo,
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
          child: Text(
            'Movie.title',
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
      
      
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  //const _PosterAndTitle({Key? key}) : super(key: key);
 

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
            child: const FadeInImage(
              height: 190,
              width: 150,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage('https://via.placeholder.com/400x300'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox( width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              
              ),
              Text(
                'Movie.title',
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.amber,),
                  SizedBox(width: 5,),
                  Text(
                    'movie.voteAverage',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Enim consectetur aute eu irure ipsum id sunt. Eiusmod est labore adipisicing esse ut laborum tempor ex commodo fugiat irure incididunt officia cupidatat. Mollit nostrud deserunt nostrud dolore laborum anim aute amet adipisicing nisi commodo sunt esse. Anim do veniam laboris aute qui tempor esse tempor ea velit veniam voluptate. Veniam quis do cillum qui ullamco voluptate culpa ipsum ullamco nostrud. Ullamco eu consequat proident ipsum occaecat eiusmod ea officia nostrud. Elit veniam nostrud ea culpa nulla Lorem. Id commodo laboris ut veniam dolore culpa fugiat sit enim qui. Et sint ea exercitation exercitation anim ipsum tempor mollit commodo cillum. Eu exercitation mollit consectetur sint. Ad consequat proident fugiat amet. Ullamco deserunt Lorem aute proident sit eu dolore.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
        ),
    );
  }
}