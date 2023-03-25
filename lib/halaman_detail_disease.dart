import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'disease_data.dart';


class HalamanDetail extends StatefulWidget {
  final Diseases disease;

  const HalamanDetail({Key? key, required this.disease}) : super(key: key);

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();

  void onPressed() {}
}

class _HalamanDetailState extends State<HalamanDetail> {
  bool isWishlist = false;

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isWishlist ? Colors.green : Colors.red,
      ),
    );
  }

  void _addToWishlist(BuildContext context) {
    setState(() {
      isWishlist = true;
    });
    _showSnackBar(context, "Added to wishlist");
  }

  void _removeFromWishlist(BuildContext context) {
    setState(() {
      isWishlist = false;
    });
    _showSnackBar(context, "Removed from wishlist");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disease.name),
        actions: [
          IconButton(
            icon: Icon(
              isWishlist ? Icons.favorite : Icons.favorite_border,
              color: isWishlist ? Colors.red : Colors.white,
            ),
            onPressed: () {
              if (isWishlist) {
                _removeFromWishlist(context);
              } else {
                _addToWishlist(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.disease.imgUrls,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 20.0),
          Text(
            widget.disease.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            widget.disease.plantName,
            style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 20.0),
          Text(
            'Ciri-Ciri',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.disease.nutshell.map((nutshell) {
              return Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, size: 8.0),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        nutshell,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          Text(
            'Disease ID',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            widget.disease.id,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          Text(
            'Symptom',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            widget.disease.symptom,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          _launchURL(widget.disease.imgUrls);
        },
      ),
    );
  }
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        forceSafariVC: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
