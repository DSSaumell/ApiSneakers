import 'package:flutter/material.dart';
import 'sneakers_model.dart';
import 'dart:async';

class SneakersDetailPage extends StatefulWidget {
  final Sneakers sneakers;
  const SneakersDetailPage(this.sneakers, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SneakersDetailPageState createState() => _SneakersDetailPageState();
}

class _SneakersDetailPageState extends State<SneakersDetailPage> {
  final double sneakersAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color.fromARGB(255, 0, 128, 128),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.sneakers.rating = _sliderValue.toInt();
      });
    }
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get sneakersImage {
    return Hero(
      tag: widget.sneakers,
      child: Container(
        height: sneakersAvarterSize,
        width: sneakersAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Colors.white),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Colors.white),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Colors.white)
            ],
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.sneakers.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.white,
        ),
        Text('${widget.sneakers.rating}/10', style: const TextStyle(color: Colors.white, fontSize: 30.0))
      ],
    );
  }

  Widget get sneakersProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 61, 92, 92),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          sneakersImage,
          Text(widget.sneakers.name, style: const TextStyle(color: Colors.white, fontSize: 32.0)),
          Text('${widget.sneakers.description}', style: const TextStyle(color: Colors.white, fontSize: 14.0)),
          Text('${widget.sneakers.price}', style: const TextStyle(color: Colors.white, fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 92, 92),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 128, 128),
        title: Text('Meet ${widget.sneakers.name}'),
      ),
      body: ListView(
        children: <Widget>[sneakersProfile, addYourRating],
      ),
    );
  }
}
