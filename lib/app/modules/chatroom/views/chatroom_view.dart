//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chatroom_controller.dart';

class ChatroomView extends GetView<ChatroomController> {
  const ChatroomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leadingWidth: 70,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Image.asset("assets/logo/noimage.png"),
              )
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Disini'),
            Text(
              "Status",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: ListView(
              children: [
                ItemChat(
                  isSender: true,
                ),
                ItemChat(
                  isSender: false,
                )
              ],
            ),
          )),
          Container(
            margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: Get.width,
            //height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        // prefixIcon: IconButton(
                        //     onPressed: () {
                        //       controller.isShowEmoji.toggle();
                        //     },
                        //     icon: Icon(Icons.emoji_emotions_outlined)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (controller.isShowEmoji.isTrue)
          //   Container(
          //     height: 325,
          //     child: EmojiPicker(
          //       onEmojiSelected: (category, emoji) {
          //         // Do something when emoji is tapped (optional)
          //       },
          //       onBackspacePressed: () {
          //         // Do something when the user taps the backspace button (optional)
          //         // Set it to null to hide the Backspace-Button
          //       },
          //       //textEditingController: textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
          //       config: Config(
          //         columns: 7,
          //         emojiSizeMax:
          //             32, // Issue: https://github.com/flutter/flutter/issues/28894
          //         verticalSpacing: 0,
          //         horizontalSpacing: 0,
          //         gridPadding: EdgeInsets.zero,
          //         initCategory: Category.RECENT,
          //         bgColor: Color(0xFFF2F2F2),
          //         indicatorColor: Colors.red,
          //         iconColor: Colors.grey,
          //         iconColorSelected: Colors.red,
          //         backspaceColor: Colors.red,
          //         skinToneDialogBgColor: Colors.white,
          //         skinToneIndicatorColor: Colors.grey,
          //         enableSkinTones: true,
          //         recentTabBehavior: RecentTabBehavior.RECENT,
          //         recentsLimit: 28,
          //         noRecents: const Text(
          //           'No Recents',
          //           style: TextStyle(fontSize: 20, color: Colors.black26),
          //           textAlign: TextAlign.center,
          //         ), // Needs to be const Widget
          //         loadingIndicator:
          //             const SizedBox.shrink(), // Needs to be const Widget
          //         tabIndicatorAnimDuration: kTabScrollDuration,
          //         categoryIcons: const CategoryIcons(),
          //         buttonMode: ButtonMode.MATERIAL,
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    required this.isSender,
    super.key,
  });

  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        //color: Colors.amber,
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: isSender
                      ? BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))
                      : BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
              child: Text(
                "Cek 1 2 3",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.grey,
              padding: EdgeInsets.all(20),
            ),
            SizedBox(
              height: 5,
            ),
            Text("waktu")
          ],
        ),
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft);
  }
}
