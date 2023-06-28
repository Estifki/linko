import 'package:flutter/material.dart';
import 'package:linko/controller/data.dart';
import 'package:linko/widget/home_top.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 400);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DummyData> searchDatas = [];
  final TextEditingController _searchcontroller = TextEditingController();
  String searchedText = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            //Home Top Bar
            //
            const HomeTopWidget(),
            const SizedBox(height: 10),
            searchedText.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SearchedQueryWidget(searchedText: searchedText),
                  )
                : const Text(""),
            Expanded(
                child: searchDatas.isEmpty
                    ? Container(
                        color: Colors.white,
                        child: Center(
                          child:
                              Image.asset("lib/assets/linko.PNG", height: 40),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchDatas.length,
                          itemBuilder: (context, index) {
                            return ProductsWidget(
                                searchDatas: searchDatas, index: index);
                          },
                        ),
                      )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: SizedBox(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 44,
                        width: screenSize.width * 0.78,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 1.0),
                          child: TextField(
                            controller: _searchcontroller,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                                // hintStyle: TextStyle(fontSize: 15),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_searchcontroller.text.isNotEmpty) {
                            searchDatas = [];
                            searchDatas = datas;
                            searchedText = _searchcontroller.text;
                            _searchcontroller.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.pink),
                          child: const Icon(Icons.send, color: Colors.white),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    required this.searchDatas,
    required this.index,
  });

  final List<DummyData> searchDatas;
  final int index;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(searchDatas: searchDatas, searchIndex: index),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    searchDatas[index].name,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8, top: 4, bottom: 4),
                      child: Text(
                        "offer %",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () => _makePhoneCall(searchDatas[index].phone),
                child: Container(
                  height: 30,
                  width: 84,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.pink)),
                  child: const Text("CALL "),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.av_timer,
                  size: 20, color: Colors.grey.withOpacity(0.6)),
              const SizedBox(width: 6),
              Text(
                searchDatas[index].deliveryTime,
              ),
              const SizedBox(width: 15),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6)),
              ),
              const SizedBox(width: 15),
              Icon(Icons.delivery_dining,
                  size: 20, color: Colors.grey.withOpacity(0.6)),
              const SizedBox(width: 6),
              Text(
                searchDatas[index].price,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.searchDatas,
    required this.searchIndex,
  });

  final List<DummyData> searchDatas;
  final int searchIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage(searchDatas[searchIndex].image),
              fit: BoxFit.cover),
        ),
      ),
      Positioned(
          right: 12,
          top: 10,
          child: Container(
            height: 38,
            width: 38,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.favorite_outline, size: 20),
          ))
    ]);
  }
}

class SearchedQueryWidget extends StatelessWidget {
  const SearchedQueryWidget({
    super.key,
    required this.searchedText,
  });

  final String searchedText;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 66,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("lib/assets/profile.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "AliJaber",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                searchedText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }
}
