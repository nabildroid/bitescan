import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    int currentPage = 0,
    int totalPages = 3,
  }) : super(
          automaticallyImplyLeading: currentPage != 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                totalPages,
                (i) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor:
                            currentPage == i ? Colors.black45 : Colors.black38,
                        radius: 6,
                      ),
                    )),
          ),
          centerTitle: true,
          leading: currentPage != 0
              ? IconButton.outlined(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                )
              : null,
        );
}
