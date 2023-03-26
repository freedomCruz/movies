import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';//Esta librería la importamos de aquí: https://pub.dev/packages/card_swiper
import 'package:movies/models/models.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: ( _ , int index ) {

          final movie = movies[index];

          movie.heroId = 'swiper-${ movie.id}';
          
          return  GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage( movie.fullPosterImg ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}