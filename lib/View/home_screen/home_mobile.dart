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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ColoredBox(
            color: hPrimaryColor,
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: SafeArea(
                minimum: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'hi sangram',
                      style: TextStyle(color: hColorLight),
                    ),
                    const Text(
                      'You received',
                      style: TextStyle(color: hColorLight),
                    ),
                    const Text(
                      '48 messages',
                      style: TextStyle(color: hColorLight),
                    ),
                    const Text(
                      'Contact list',
                      style: TextStyle(color: hColorLight),
                    ),
                    Flexible(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 15); // Consistent separator size
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return const AvatarWidget(
                            foregroundImageUrl: '',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.30,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight - screenHeight * 0.30,
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
                          onTap: (){
                            Provider.of<HomeState>(context, listen: false).clear();
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
                      '    Pinned Messages(2)',
                    ),
                  ),
                  FutureBuilder<Box<Conversation>>(
                    future: hiveServices.openBox(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
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
