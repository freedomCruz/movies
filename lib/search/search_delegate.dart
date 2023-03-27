
import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate { // Se usa el extends para tomar las funciones del showSearh que viene del home_screen en el onPressed


  @override
  String? get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
       IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.backspace_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
      return IconButton(
        onPressed: () => close(context, null), 
        icon: const Icon(Icons.arrow_back));
  }

    late List<Movie> moviesResults;
 //Variable para ser llamada en el builderResults

  @override
  Widget buildResults(BuildContext context) {

   return ListView.builder(
              itemCount: moviesResults.length,
              itemBuilder: ( _ , int index) => _MovieItem(moviesResults[index]),
            ); 
    
  }

  Widget _emptyContainer(){
    return const Center(
            child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130)
          );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
     if( query.isEmpty) {
        return _emptyContainer();
        
     }    

      final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
       //-----Debo retornar el Future que use provider para ello uso un widget Future*****
       //Ahora retorno no un Future sino un Stream para implementar el debouncer
       moviesProvider.getSuggestionsByQuery( query );

       return StreamBuilder<List<Movie>>(
        stream: moviesProvider.suggestionStream,  
        builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) {
          if( !snapshot.hasData ) return _emptyContainer();
            
            final List<Movie> movies = snapshot.data!;
            moviesResults = movies; //Para el builderResults

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: ( _ , int index) => _MovieItem(movies[index]),
            );
        },
        
      );
    
  }

}


class _MovieItem extends StatelessWidget {
 
  final Movie movie;

  const _MovieItem( this.movie );

  @override
  Widget build(BuildContext context) {

      movie.heroId = 'search-${movie.id}';
      return Hero(
        tag: movie.heroId!,
        child: ListTile(
          leading: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage( movie.fullPosterImg ),
            width: 50,
            fit: BoxFit.contain
          ),
      
          title: Text(movie.title),
          subtitle: Text(movie.originalTitle),
          onTap: () {
            Navigator.pushNamed(context, 'details', arguments: movie );
          },
        ),
      );
  }
}

