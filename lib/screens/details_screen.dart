import 'package:flutter/material.dart';


class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //TODO: cambiar luego por una instancia de movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'No movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([

              _PosterAndTitle(),

              const SizedBox(height: 20,),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
            
            ])
          )
        ] ,
      )

    );
  }
}

class _CustomAppBar extends StatelessWidget {

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
          color: Colors.black45,
          child: const Text('movie.title', style: TextStyle( fontSize: 16)),
        ),
        
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover
        ),
        // background: FadeInImage(image: ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  
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
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),

          const SizedBox( width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originalTitle', style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2,),

              Row(
                children: [
                  const Icon(Icons.star_border_outlined, size: 15, color: Colors.tealAccent,),
                  const SizedBox( width: 5),
                  Text('movie.voteAverage', style: textTheme.bodySmall,),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Cupidatat esse do cupidatat voluptate. Ullamco nulla officia mollit reprehenderit amet est. Culpa eiusmod tempor minim commodo sunt velit cillum sit incididunt sunt sit. Irure ex ipsum eu et laborum.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,

      ),
    );
  }
}

