import 'package:cached_network_image/cached_network_image.dart';
import 'package:dsc_project/FUNCTIONS/Components.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details(
      {this.title,
      this.hdUrl,
      this.explanation,
      this.copyRight,
      this.date,
      this.tagNumber});

  final String title;
  final String explanation;
  final String hdUrl;
  final String copyRight;
  final String date;
  final int tagNumber;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context)),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(widget.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: Components().kTextStyle.copyWith(fontSize: 24)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      children: [
                        Hero(
                          tag: '${widget.tagNumber.toString()}',
                          child: CachedNetworkImage(
                            imageUrl: widget.hdUrl,
                            errorWidget: (context, url, error) => Text(error),
                            fadeInCurve: Curves.fastOutSlowIn,
                            fadeInDuration: Duration(milliseconds: 1000),
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )),
                            imageBuilder: (context, image) => Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: image),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Icon(Icons.date_range, color: Colors.white),
                              SizedBox(width: 10),
                              Text(widget.date,
                                  textAlign: TextAlign.end,
                                  style: Components().kTextStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Row(
                      children: [
                        Text('INFO',
                            style: Components().kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: 23)),
                        SizedBox(width: 20),
                        Icon(Icons.info_outline, color: Colors.white)
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(widget.explanation,
                        textAlign: TextAlign.justify,
                        style:
                        Components().kTextStyle.copyWith(fontStyle: FontStyle.normal)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Text('© ${widget.copyRight}',
                          textAlign: TextAlign.center,
                          style:
                          Components().kTextStyle.copyWith(fontStyle: FontStyle.normal)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
