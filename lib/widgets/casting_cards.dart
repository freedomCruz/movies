import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  const CastingCards(this.movieId, {super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only( bottom: 30, top: 20),
      width: double.infinity,
      height: 180,
      // color: Colors.red,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: ( _, int index) => _CastCard(),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/150x300'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),

          const Text('actor.name Nobre del actor lafjlsdkajflks',
          
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          
          ),
        ]
      )
    );
  }
}