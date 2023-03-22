import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatelessWidget {

   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
              children: [

                //Tarjetas principales
                CardSwiper( movies: moviesProvider.onDisplayMovies ),

                const SizedBox( height: 20,),

                //Slider de películas
                MovieSlider( 
                  movies: moviesProvider.popularMovies,
                  title: 'Populares',
                ),
                MovieSlider( 
                  movies: moviesProvider.popularMovies,
                  title: 'Populares',
                ),
                MovieSlider( 
                  movies: moviesProvider.popularMovies,
                  title: 'Populares',
                ),
              ],
        ),
      )
    );
  }
}