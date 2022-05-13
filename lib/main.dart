import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopify/models/most_popular.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        tabBarTheme: const TabBarTheme(
            labelColor: Colors.blue, unselectedLabelColor: Colors.black),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);

  int selectedPage = 0;

  List<MostPopular> mostPopular = [];

  @override
  void initState() {
    mostPopular.add(MostPopular(
        image: 'images/tshirt_1.jpg',
        description: 'Cabin White T-Shirt',
        category: 'T-Shirt',
        price: '\$24.99',
        discount: '\$28.99',
        favorite: true));
    mostPopular.add(MostPopular(
        image: 'images/jeans_1.jpg',
        description: 'Light Blue Jeans',
        category: 'Pants',
        price: '\$59.62',
        discount: '\$79.50',
        favorite: false));
    mostPopular.add(MostPopular(
        image: 'images/shoes_1.jpg',
        description: 'White Sneakers',
        category: 'Sneakers',
        price: '\$60,00',
        discount: '\$70,00',
        favorite: false));
    mostPopular.add(MostPopular(
        image: 'images/shoes_2.jpg',
        description: 'Black Striped Sneakers',
        category: 'Sneakers',
        price: '\$70,99',
        discount: null,
        favorite: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const SizedBox(
            width: double.maxFinite,
            child: Text(
              'Shopify',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.settings),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.search),
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'All',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Masculine',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Feminine',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      width: 330,
                      child: const Center(
                        child: Text(
                          'New\nCollection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xCCF26F31),
                            Color(0xCCC40F47),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: 3,
                position: selectedPage.toDouble(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Most Popular',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {},
                      child: const Text('Show all'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    mainAxisExtent: 250,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemCount: mostPopular.length,
                  itemBuilder: (context, index) {
                    return mostPopularItemsWidget(mostPopular[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mostPopularItemsWidget(MostPopular mostPopular) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(width: 1.0, color: Colors.black12),
                  image: DecorationImage(
                    image: AssetImage(mostPopular.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: mostPopular.favorite == false
                    ? const Icon(
                        Icons.favorite_border,
                        color: Colors.black26,
                        size: 32.0,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 32.0,
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          mostPopular.description,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: Text(
            mostPopular.category,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Text(
              mostPopular.price,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            mostPopular.discount != null
                ? Text(
                    mostPopular.discount!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black45,
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : const Text("")
          ],
        ),
      ],
    );
  }
}
