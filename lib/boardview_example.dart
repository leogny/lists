import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:trello_ui/models/board_list_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;
import 'models/board_item_model.dart';

class BoardViewExample extends StatefulWidget {
  @override
  _BoardViewExampleState createState() => _BoardViewExampleState();
}

class _BoardViewExampleState extends State<BoardViewExample> {
  final List<Color> circleColors = [Colors.red, Colors.blue, Colors.green];

  Color randomGenerator() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    BoardViewController boardViewController = new BoardViewController();
    return Scaffold(
      backgroundColor: Colors.blueAccent, //const Color(0xffeaecf3)
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: BoardView(
          width: 320,
          lists: [
            for (int i = 0; i < boardList.length; i++)
              BoardList(
                // headerBackgroundColor: Colors.white,
                // backgroundColor: Colors.white54,
                // headerBackgroundColor: Colors.white,
                header: [
                  Container(
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: randomGenerator(),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          boardList[i].title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: null,
                        )
                      ],
                    ),
                  ),
                  // Expanded(child: Container()),
                ],
                items: [
                  for (int j = 0; j < boardList[i].items.length; j++)
                    buildBoardItem(
                      context,
                      boardList[i].items[j],
                      boardList[i].items[j].assignedTo,
                      boardList[i].items[j].id,
                      (listIndex, itemIndex, oldListIndex, oldItemIndex) {},
                    ),
                ],
              )
          ],
          boardViewController: boardViewController,
        ),
      ),
    );
  }

  Widget _cardButton(IconData iconData) {
    return SizedBox(
        height: 12.0,
        width: 12.0,
        child: IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            iconData,
            size: 12.0,
            color: Colors.blue.shade100,
          ),
          onPressed: null,
        ));
  }

  Widget buildBoardItem(
    BuildContext context,
    BoardItemModel itemObject,
    String subtitle,
    int id,
    Function(int, int, int, int) callback,
  ) {
    return BoardItem(
        onStartDragItem:
            (int listIndex, int itemIndex, BoardItemState state) {},
        onDropItem: (int listIndex, int itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
          callback(listIndex, itemIndex, oldListIndex, oldItemIndex);
        },
        onTapItem: (int listIndex, int itemIndex, BoardItemState state) async {
          launch('www.google.com');
        },
        item: Container(
          color: Colors.white,
          child: Column(
            children: [
              /* if (itemIndex == 0) Row(
                children: [
                  Expanded(
                      child:
                          Container(height: 0.5, color: Colors.grey.shade300)),
                  Icon(
                    Icons.add,
                    color: Colors.grey.shade300,
                    size: 16,
                  )
                ],
              ), */
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Expanded(
                              child: Text(
                            itemObject.title,
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          )),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _cardButton(Icons.sort),
                          _cardButton(Icons.create),
                          _cardButton(Icons.label),
                          _cardButton(Icons.attachment),
                        ],
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child:
                          Container(height: 0.5, color: Colors.grey.shade300)),
                  Icon(
                    Icons.add,
                    color: Colors.grey.shade300,
                    size: 16,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
