// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:screenshot/screenshot.dart';

import 'color_button.dart';

class StoryViewCreator extends StatefulWidget {
  const StoryViewCreator({
    super.key,
    required this.onFinished,
  });
  final Function(Uint8List?) onFinished;
  @override
  State<StoryViewCreator> createState() => _StoryViewCreatorState();
}

class _StoryViewCreatorState extends State<StoryViewCreator> {
  ValueNotifier<UnDrawIllustration?> undrawIllustrationNotifier = ValueNotifier(null);
  final TextEditingController titleEditingController = TextEditingController(text: "Başlık Ekle");
  final TextEditingController subTitleEditingController = TextEditingController(text: "Metin ekle");
  ValueNotifier<bool> showUnDrawIllustration = ValueNotifier(true);
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  ValueNotifier<Color> colorBackground = ValueNotifier(Colors.purple);
  ValueNotifier<Color> colorBackgroundSvg = ValueNotifier(Colors.purple);
  ValueNotifier<Color> colorUnDrawIllustration = ValueNotifier(Colors.purple);
  final ValueNotifier<bool> isVisibleForSS = ValueNotifier(true);
  ScreenshotController screenshotController = ScreenshotController();
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
          child: ValueListenableBuilder<bool>(
              valueListenable: isVisibleForSS,
              builder: (context, isVisibleForSSValue, _) {
                return Stack(
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
                        ValueListenableBuilder<UnDrawIllustration?>(
                          valueListenable: undrawIllustrationNotifier,
                          builder: (context, illustrationValue, _) {
                            return Column(
                              children: [
                                const Expanded(child: SizedBox()),
                                ValueListenableBuilder<Color>(
                                    valueListenable: colorUnDrawIllustration,
                                    builder: (context, colorValue, _) {
                                      return illustrationValue == null
                                          ? const SizedBox()
                                          : UnDraw(
                                              color: colorValue, height: 150,
                                              illustration: illustrationValue,
                                              placeholder: const SizedBox.shrink(), //optional, default is the CircularProgressIndicator().
                                              errorWidget:
                                                  const Icon(Icons.error_outline, color: Colors.red, size: 50), //optional, default is the Text('Could not load illustration!').
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
                    !isVisibleForSSValue
                        ? const SizedBox()
                        : SafeArea(
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
                                        onPressed: () async {
                                          isVisibleForSS.value = false;

                                          final result = await screenshotController.capture(); // Ekran görüntüsünü al ve kaydet
                                          widget.onFinished.call(result);
                                          isVisibleForSS.value = true;
                                        },
                                        child: const Icon(Icons.send),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    !isVisibleForSSValue
                        ? const SizedBox()
                        : ValueListenableBuilder<bool>(
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
                                            selectedColor: colorBackground,
                                          ),
                                          ColorButton(
                                            selectedColor: colorBackgroundSvg,
                                          ),
                                          ColorButton(
                                            selectedColor: colorUnDrawIllustration,
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .07),
                                          child: SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                final illustration = UnDrawIllustration.values[index];
                                                if (index == 0) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      undrawIllustrationNotifier.value = null;
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: SizedBox(
                                                        width: 100,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white38,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(Icons.clear),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

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
                                                          color: colorUnDrawIllustration.value, height: 50,
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
                );
              }),
          builder: (context, value, child) {
            return Screenshot(
              controller: screenshotController,
              child: ColoredBox(
                color: value.withOpacity(.3),
                child: child,
              ),
            );
          }),
    );
  }
}
