import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {

  PageController backgroundController = PageController();
  int bgIndex = 0;
  PageController topController = PageController(viewportFraction: 0.75);
  int topIndex = 0;
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topController.addListener((){
      setState(() {
        currentPage = topController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            reverse: true,
            controller: backgroundController,
              onPageChanged: (bgIndex){
                setState(() {
                  backgroundController.animateToPage(
                      bgIndex,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear);
                });
              },
              itemCount: moviesList.length,
              itemBuilder: (context, bgIndex){
            return ShaderMask(
              shaderCallback: (Rect bounds){
                return const LinearGradient(colors: [
                  Colors.white,
                  Colors.transparent,
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
                child: Image.network(
                  moviesList[bgIndex].images,
                  fit: BoxFit.cover,));
          }),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height*0.50,
                width: size.width,
                child: PageView.builder(
                  controller: topController,
                  onPageChanged: (topIndex){
                   setState(() {
                     backgroundController.animateToPage(
                         topIndex,
                         duration: Duration(milliseconds: 400),
                         curve: Curves.linear);
                   });
                  },
                  itemCount: moviesList.length,
                    itemBuilder: (context, topIndex){
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: currentPage == topIndex?0:30),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                image: NetworkImage(moviesList[topIndex].images))
                          ),
                          height: size.height*0.30,
                          width: size.width*0.50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            moviesList[topIndex].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for(var val in moviesList[topIndex].type)
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: Text(val),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text('Buy Ticket',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Movies{

  Movies({
    required this.images,
    required this.name,
    required this.type
});

  final String images;
  final String name;
  final List<String> type;
}

List<Movies> moviesList = [
  Movies(
      images: 'https://wallpapercave.com/wp/wp13468509.jpg',
      name: 'Pokemon',
      type: ['Anime, Action']
  ),
  Movies(
      images: 'https://wallpapercave.com/wp/wp4910778.jpg',
      name: 'SpiderMan',
      type: ['Adventure, Action']
  ),
  Movies(
      images: 'https://www.xtrafondos.com/thumbs/vertical/webp/1_5542.webp',
      name: 'Batman',
      type: ['Dark, Action']
  ),
  Movies(
      images: 'https://e1.pxfuel.com/desktop-wallpaper/537/957/desktop-wallpaper-iron-man-iphone-fly-iron-man-mobile.jpg',
      name: 'IronMan',
      type: ['Sci-fi, Action']
  ),
  Movies(
      images: 'https://e0.pxfuel.com/wallpapers/220/424/desktop-wallpaper-black-widow-movie-art-iphone-1-black-widow-avengers-black-widow-marvel-black-widow-movie-natasha-romanoff-iphone.jpg',
      name: 'BlackWidow',
      type: ['Comedy, Action']
  ),
];
