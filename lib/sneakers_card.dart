import 'package:sneakers/sneakers_model.dart';
import 'sneakers_detail_page.dart';
import 'package:flutter/material.dart';


class sneakersCard extends StatefulWidget {
  final Sneakers sneakers;

  const sneakersCard(this.sneakers, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _sneakersCardState createState() => _sneakersCardState(sneakers);
}

class _sneakersCardState extends State<sneakersCard> {
  Sneakers sneakers;
  String? renderUrl;

  _sneakersCardState(this.sneakers);

  @override
  void initState() {
    super.initState();
    renderSneakersPic();
  }

  Widget get sneakersImage {
    var sneakersAvatar = Hero(
      tag: sneakers,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration:
          BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Colors.white, Color.fromARGB(255, 84, 110, 122)])),
      alignment: Alignment.center,
      child: const Text(
        'Sneaker',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: sneakersAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderSneakersPic() async {
    await sneakers.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = sneakers.imageUrl;
      });
    }
  }

  Widget get sneakersCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 260,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color.fromARGB(255, 0, 128, 128),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.sneakers.name,
                  style: const TextStyle(color: Colors.white, fontSize: 23.0),
                ),
                Text(
                  '${widget.sneakers.description}', style: const TextStyle(color: Colors.white, fontSize: 10.0)
                ),
                Text(
                  '${widget.sneakers.price}', style: const TextStyle(color: Colors.white, fontSize: 14.0)
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Colors.white),
                    Text(': ${widget.sneakers.rating}/10', style: const TextStyle(color: Colors.white, fontSize: 14.0)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSneakersDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SneakersDetailPage(sneakers);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showSneakersDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              Positioned(top: 7.5, child: sneakersImage),
              sneakersCard,
            ],
          ),
        ),
      ),
    );
  }
}
