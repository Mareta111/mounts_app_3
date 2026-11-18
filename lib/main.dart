import 'package:flutter/material.dart';

final Color brandColor = Color(0xFFFF5656);

final List<MountainData> mountainList = [
  MountainData(
    imgUrl: 'https://sa.kapamilya.com/absnews/abscbnnews/media/2021/afp/01/17/20210116-mt-semeru-indonesia-ash-afp-s.jpg',
    title: 'Mount Semeru',
    desc: 'Semeru is an active volcano in East Java, Indonesia. It is located in the subduction zone, where the Indo-Australia plate subducts under the Eurasia plate. It is the highest mountain on the island of Java.',
    loc: 'East Java'
  ),
  MountainData(
    imgUrl: 'https://media-cdn.tripadvisor.com/media/photo-s/04/a5/6f/ce/dsc-5622jpg.jpg',
    title: 'Mount Merbaru',
    desc: 'Mount Merbabu is a dormant stratovolcano in Central Java province on the Indonesian island of Java. The name Merbabu could be loosely translated as Mountain of Ash.',
    loc: 'Central Java'
  ),
  MountainData(
    imgUrl: 'https://cdn.dlmag.com/wp-content/uploads/2019/07/maunaloa1.jpg',
    title: 'Mauna Loa',
    desc: 'Mauna Loa is one of five volcanoes that form the Island of Hawaii in the U.S. state of Hawaii. The largest subaerial volcano in both mass and volume.',
    loc: 'Hawaii'
  ),
  MountainData(
    imgUrl: 'https://cdn.images.express.co.uk/img/dynamic/78/590x/mount-vesuvius-1100807.jpg',
    title: 'Mount Vesuvius',
    desc: 'Mount Vesuvius is a somma-stratovolcano located on the Gulf of Naples in Campania, Italy, about 9 km east of Naples.',
    loc: 'Italy'
  ),
  MountainData(
    imgUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/04/PopoAmeca2zoom.jpg',
    title: 'Popocatépetl',
    desc: 'Popocatépetl is an active stratovolcano located in the states of Puebla, Morelos, and Mexico. It lies in the eastern half of the Trans-Mexican volcanic belt.',
    loc: 'Mexico'
  )
];

final List<CategoryData> categoryList = [
  CategoryData(title: 'Mountain', icon: Icons.terrain),
  CategoryData(title: 'Forest', icon: Icons.park),
  CategoryData(title: 'Beach', icon: Icons.beach_access),
  CategoryData(title: 'Hiking', icon: Icons.directions_walk)
];

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: LoadingScreen()
    )
  );
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainHomePage())
      );
    });

    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Center(
            child: Icon(Icons.terrain, color: Colors.white, size: 90),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
              )
            )
          )
        ]
      )
    );
  }
}

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Icon(Icons.terrain, color: brandColor, size: 40),
        centerTitle: true,
        iconTheme: IconThemeData(color: brandColor),
        actions: [
          SizedBox(width: 40, height: 40)
        ]
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.all(30),
          color: brandColor,
          alignment: Alignment.bottomLeft,
          child: Icon(Icons.terrain, color: Colors.white, size: 80)
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(),
          SearchSection(),
          Expanded(
            child: MountainList()
          ),
          CategorySection(),
          BottomNavBar()
        ],
      )
    );
  }
}

class DetailInfoPage extends StatelessWidget {
  final MountainData data;
  
  DetailInfoPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.imgUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          begin: Alignment.center, 
                          end: Alignment.bottomCenter
                        )
                      )
                    )
                  ),
                  Positioned(
                    bottom: 30, left: 30, right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.title,
                          style: TextStyle(
                            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold
                          )
                        ),
                        Text(data.loc,
                          style: TextStyle(color: Colors.white, fontSize: 20)
                        ),
                      ]
                    )
                  ),
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Icon(Icons.terrain, color: Colors.white, size: 40),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.pending, color: Colors.white, size: 30)
                      )
                    ]
                  )
                ],
              )
            )
          ),
          Expanded(
            child: Column(
              children: [
                DetailRatingBar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text('About ${data.title}', 
                          style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text(data.desc, style: TextStyle(fontSize: 12))
                      )
                    ],
                  )
                ),
                DetailActionButtons()
              ],
            )
          )
        ],
      )
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/5081804?v=4'),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text('Hello, Mareta',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
              Text('Good Morning',
                style: TextStyle(color: brandColor, fontSize: 12)
              )
            ]
          )
        ],
      )
    );
  }
}

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Discover',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Search', style: TextStyle(color: Colors.grey))
                    ]
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: brandColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.tune, color: Colors.white)
              )
            ],
          )
        ],
      )
    );
  }
}

class MountainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: mountainList.map((item) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailInfoPage(item))
              );
            },
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(item.imgUrl),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  Text(item.loc, style: TextStyle(color: Colors.white))
                ]
              )
            ),
          );
        }).toList(),
      )
    );
  }
}

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Text('See More',
                style: TextStyle(color: brandColor, fontSize: 12, fontWeight: FontWeight.bold)
              ),
            ]
          )
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final cat = categoryList[index];
              return Container(
                width: 100,
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat.icon, color: brandColor),
                    Text(cat.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                  ]
                )
              );
            }
          )
        ),
      ],
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.explore, 'label': 'Explore'},
    {'icon': Icons.turned_in_not, 'label': 'Tag'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset.zero
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          bool isSel = _selectedIndex == index;
          return isSel 
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: brandColor
                ),
                child: Row(
                  children: [
                    Icon(_items[index]['icon'], color: Colors.white),
                    SizedBox(width: 5),
                    Text(_items[index]['label'], style: TextStyle(color: Colors.white))
                  ]
                )
              )
            : IconButton(
                icon: Icon(_items[index]['icon'], color: Colors.grey),
                onPressed: () => setState(() => _selectedIndex = index)
              );
        }),
      )
    );
  }
}

class DetailRatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = {'Rating': '4.6', 'Price': '\$12', 'Open': '24hrs'};

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.entries.map((e) {
          return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(e.key, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text(e.value, style: TextStyle(color: brandColor, fontWeight: FontWeight.bold, fontSize: 15))
              ]
            )
          );
        }).toList()
      )
    );
  }
}

class DetailActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: brandColor,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(21),
                  child: Text('Book Now', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))
                ),
              )
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: brandColor, width: 2)
            ),
            child: Icon(Icons.turned_in_not, color: brandColor, size: 25)
          )
        ]
      )
    );
  }
}

class MountainData {
  final String imgUrl;
  final String title;
  final String loc;
  final String desc;

  MountainData({
    this.imgUrl = '',
    this.title = '',
    this.loc = '',
    this.desc = ''
  });
}

class CategoryData {
  final String title;
  final IconData? icon;

  CategoryData({this.title = '', this.icon});
}