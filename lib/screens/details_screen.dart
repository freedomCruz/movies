import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:movies/models/models.dart';


class DetailsScreen extends StatelessWidget {

    
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

       final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
       

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([

              _PosterAndTitle( movie ),
              const SizedBox(height: 20,),
              _Overview( movie ),
               CastingCards( movie.id),
              
            
            ])
          )
        ] ,
      )

    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar( this.movie );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 5, 58, 83),
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black45,
          child:  Text( movie.title, style: const TextStyle( fontSize: 16)),
        ),
        
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage( movie.fullBackdropPath ),
          fit: BoxFit.cover
        ),
        // background: FadeInImage(image: ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);
  
  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( movie.fullPosterImg ),
              height: 150,
            ),
          ),

          const SizedBox( width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2,),
            
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined, size: 15, color: Colors.tealAccent,),
                    const SizedBox( width: 5),
                    Text('${movie.voteAverage}', style: textTheme.bodySmall,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Expanded(
        child: Text( movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

