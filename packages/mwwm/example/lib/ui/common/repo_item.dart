import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

class RepoItemUiModel {
  final Repository repostory;
  bool isFavorite;

  RepoItemUiModel({
    this.repostory,
    this.isFavorite,
  });
}

class RepoItem extends StatefulWidget {
  final RepoItemUiModel item;

  RepoItem(this.item);

  @override
  State<StatefulWidget> createState() {
    return _RepoItemState();
  }
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              widget.item.repostory.owner.avatarUrl,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '${widget.item.repostory.name}/',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      widget.item.repostory.owner.login,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.item.repostory.description,
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.brightness_1,
                      size: 16.0,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 8.0),
                    Text(widget.item.repostory.language),
                    SizedBox(
                      width: 24.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 16.0,
                    ),
                    SizedBox(width: 8.0),
                    Text('${widget.item.repostory.stargazersCount}'),
                    SizedBox(
                      width: 24.0,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      size: 16.0,
                      color: Colors.green,
                    ),
                    SizedBox(width: 8.0),
                    Text('${widget.item.repostory.watchersCount}'),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        widget.item.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.item.isFavorite = !widget.item.isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
