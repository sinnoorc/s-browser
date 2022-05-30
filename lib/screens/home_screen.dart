import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbrowser/model/news.dart';
import 'package:sbrowser/screens/browser.dart';
import 'package:sbrowser/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  late Future<NewsModel?> _news;

  final RxBool _isShowIcon = RxBool(false);

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _isSliverAppBarExpanded ? _isShowIcon.value = true : _isShowIcon.value = false;
      });

    _news = ApiService().getNews();
    super.initState();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            toolbarHeight: kToolbarHeight + 70,
            elevation: 0,
            pinned: true,
            floating: true,
            title: Center(
              child: Image.asset(
                'assets/icons/google.png',
                height: 50,
                width: 50,
              ),
            ),
            bottom: AppBar(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              elevation: 0,
              title: SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      label: DefaultTextStyle(
                        style: Get.textTheme.subtitle1!,
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText('Search or type web address'),
                          ],
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      // isDense: true,
                      suffixIcon: const Icon(Icons.search),
                      prefixIcon: Obx(
                        () => Visibility(
                          visible: _isShowIcon.value,
                          replacement: const SizedBox.shrink(),
                          child: IconButton(
                            iconSize: 10,
                            icon: Image.asset('assets/icons/google.png'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      )),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Trending news for you',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      FutureBuilder<NewsModel?>(
                        future: _news,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return ListView.separated(
                                  primary: false,
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                                  itemCount: snapshot.data?.articles?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final article = snapshot.data?.articles?.elementAt(index);

                                    if (article?.description != null && article?.urlToImage != null) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(() => const WebViewWidget(), arguments: {'url': article?.url!});
                                        },
                                        child: Ink(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 0.5,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      article?.title ?? '',
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 6),
                                                    if (article?.description != null)
                                                      Text(
                                                        article!.description!,
                                                        style: Theme.of(context).textTheme.caption,
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    article?.urlToImage ?? '',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                                                    loadingBuilder: (context, child, progress) => progress == null
                                                        ? child
                                                        : Center(
                                                            child: CircularProgressIndicator(
                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                Theme.of(context).primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
