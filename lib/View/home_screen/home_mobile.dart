import 'package:chats/View-models/message_state.dart';
import 'package:hive/hive.dart';

import '../view_imports.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({
    super.key,
  });

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  HiveServices hiveServices = HiveServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<String> profileImg = [
    'https://assets.entrepreneur.com/content/3x2/2000/20150820205507-single-man-outdoors-happy-bliss.jpeg',
    'https://th.bing.com/th/id/OIP.M-1HL6EQyDlnY9SAz3--YAHaGN?rs=1&pid=ImgDetMain',
    'https://www.india.com/wp-content/uploads/2017/07/single-man-5.jpg',
    'https://th.bing.com/th/id/OIP.FSu2rn-H2BOADDOat4FfEAHaE8?w=265&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/shutterstock_193527755.jpg?itok=uS1VIBoY',
    'https://th.bing.com/th/id/OIP.U3-vuv1ZsfA5skm1HNgfqQHaEc?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.FLR-H8kpxJ4mPboeFr1LsgHaFX?rs=1&pid=ImgDetMain',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    User? user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hPrimaryColor,
        title: ListTile(
          title: const Text('Messages',style: TextStyle(fontSize: 20),),
          subtitle:  Text(
            'Hi ${user!.displayName}',
            style: const TextStyle(color: hColorLight),
          ),
        ),
        actions: const [
          Icon(Icons.qr_code_scanner),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.camera_alt_outlined),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.more_vert_outlined)
        ],
      ),
      body: Stack(
        children: [
          ColoredBox(
            color: hPrimaryColor,
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: SafeArea(
                minimum: const EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hBackgroundColor,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: FractionallySizedBox(
                              widthFactor: 0.5,
                              heightFactor: 0.5,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 60, // Specify a height for the ListView
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: profileImg.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 15, // Consistent separator size
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return  AvatarWidget(
                                  foregroundImageUrl: profileImg[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.10,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight - screenHeight * 0.10,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900] // Dark theme color
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: hBackgroundColor),
                          child: const Center(
                            child: Text('Direct Messages',
                                style: TextStyle(color: hSecondaryColor)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<HomeState>(context, listen: false)
                                .clear();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: hBackgroundColor),
                            child: const Center(
                              child: Text('Group',
                                  style: TextStyle(color: hSecondaryColor)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '    Pinned Messages',
                    ),
                  ),
                  FutureBuilder<Box<Conversation>>(
                    future: hiveServices.openBox(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error opening box'));
                      } else {
                        return ValueListenableBuilder(
                          valueListenable:
                              hiveServices.getConversationListenable(),
                          builder: (context, Box<Conversation> box, _) {
                            final conversationList = box.values
                                .toList()
                                .cast<Conversation>()
                                .reversed
                                .toList();
                            return Flexible(
                              child: ListView.builder(
                                itemCount: conversationList.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) => ChatCard(
                                  conversation: conversationList[index],
                                  press: () => Navigator.pushNamed(
                                    context,
                                    RouteName.messageScreen,
                                    arguments: {
                                      'conversation': conversationList[index],
                                      'index': index,
                                      'length': conversationList.length
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.contactScreen);
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
