// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ms_undraw/ms_undraw.dart';

import 'color_button.dart';

class StoryViewCreator extends StatefulWidget {
  const StoryViewCreator({super.key});

  @override
  State<StoryViewCreator> createState() => _StoryViewCreatorState();
}

class _StoryViewCreatorState extends State<StoryViewCreator> {
  ValueNotifier<UnDrawIllustration> undrawIllustrationNotifier = ValueNotifier(UnDrawIllustration.a_better_world);
  final TextEditingController titleEditingController = TextEditingController(text: "Başlık Ekle");
  final TextEditingController subTitleEditingController = TextEditingController(text: "Metin ekle");
  ValueNotifier<bool> showUnDrawIllustration = ValueNotifier(true);
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  ValueNotifier<Color> colorBackground = ValueNotifier(Colors.white);
  ValueNotifier<Color> colorBackgroundSvg = ValueNotifier(Colors.black);
  ValueNotifier<Color> colorUnDrawIllustration = ValueNotifier(Colors.black);

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        showUnDrawIllustration.value = false;
      } else {
        showUnDrawIllustration.value = true;
      }
    });
    myFocusNode2.addListener(() {
      if (myFocusNode2.hasFocus) {
        showUnDrawIllustration.value = false;
      } else {
        showUnDrawIllustration.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ValueListenableBuilder<Color>(
          valueListenable: colorBackground,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Builder(builder: (context) {
                      return ValueListenableBuilder<Color>(
                        valueListenable: colorBackgroundSvg,
                        builder: (context, value, child) => SvgPicture.asset(
                          "assets/bg/123.svg",
                          color: value,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          package: "story_view_creator",
                        ),
                      );
                    }),
                  ),
                  ValueListenableBuilder<UnDrawIllustration>(
                    valueListenable: undrawIllustrationNotifier,
                    builder: (context, illustrationValue, _) {
                      return Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          ValueListenableBuilder<Color>(
                              valueListenable: colorUnDrawIllustration,
                              builder: (context, colorValue, _) {
                                return UnDraw(
                                  color: colorValue, height: 150,
                                  illustration: illustrationValue,
                                  placeholder: const SizedBox.shrink(), //optional, default is the CircularProgressIndicator().
                                  errorWidget: const Icon(Icons.error_outline, color: Colors.red, size: 50), //optional, default is the Text('Could not load illustration!').
                                );
                              }),
                          Expanded(
                              flex: 2,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      maxLines: 2,
                                      focusNode: myFocusNode,
                                      textAlign: TextAlign.center,
                                      controller: titleEditingController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      focusNode: myFocusNode2,
                                      textAlign: TextAlign.center,
                                      controller: subTitleEditingController,
                                      maxLines: 2,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: FloatingActionButton.small(
                            elevation: 4,
                            heroTag: null,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: FloatingActionButton.small(
                            elevation: 4,
                            heroTag: null,
                            onPressed: () {},
                            child: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: showUnDrawIllustration,
                builder: (context, illustrationValue, child) => !illustrationValue
                    ? const SizedBox.shrink()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ColorButton(
                                onPressed: (p0) => colorBackground.value = p0,
                              ),
                              ColorButton(
                                onPressed: (p0) => colorBackgroundSvg.value = p0,
                              ),
                              ColorButton(
                                onPressed: (p0) => colorUnDrawIllustration.value = p0,
                              ),
                            ],
                          ),
                          Center(
                            child: SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final illustration = UnDrawIllustration.values[index];
                                    return GestureDetector(
                                      onTap: () {
                                        undrawIllustrationNotifier.value = illustration;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: SizedBox(
                                          width: 100,
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(
                                              color: Colors.white38,
                                              shape: BoxShape.circle,
                                            ),
                                            child: UnDraw(
                                              color: Colors.purple, height: 50,
                                              illustration: illustration, fit: BoxFit.fitWidth,
                                              placeholder: const Center(
                                                child: CircularProgressIndicator(),
                                              ), //optional, default is the CircularProgressIndicator().
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: UnDrawIllustration.values.length,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          builder: (context, value, child) {
            return ColoredBox(
              color: value.withOpacity(.5),
              child: child,
            );
          }),
    );
  }
}
