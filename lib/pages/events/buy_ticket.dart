import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/pages/card/card.dart';

final _formKey = GlobalKey<FormState>();

class BuyTicket extends StatefulWidget {
  final EventModel event;
  final String image;
  const BuyTicket({required this.event, required this.image, super.key});

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  Future _getImg(String name) async {
    String jpegPath = 'assets/session_1/event_images/${name}.jpeg';
    String pngPath = 'assets/session_1/event_images/${name}.png';

    try {
      await rootBundle.load(jpegPath);
      return jpegPath;
    } catch (_) {
      return pngPath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pushNamed(context, '/ticketList');
          }
        },
        child: Text('Confirm ->'),
      ),
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        flexibleSpace: EventCard(event: widget.event, image: widget.image, title: 'Enter your details:', subtitle: widget.event.name,),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('ACCOUNT'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Given Name',
                    border: InputBorder.none
                  ),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Please input your name';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                child: TextFormField(
                  controller: familyNameController,
                  decoration: InputDecoration(
                    hintText: 'Family Name',
                    border: InputBorder.none
                  ),
                  validator: (familyName) {
                    if (familyName!.isEmpty) {
                      return 'Please input your family name';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: InputBorder.none
                  ),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Please input your email';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            Text('PAYMENT INFORMATION'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                child: TextFormField(
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    hintText: 'Card Number',
                    border: InputBorder.none
                  ),
                  keyboardType: TextInputType.number,
                  validator: (cardNum) {
                    if (cardNum!.isEmpty) {
                      return 'Please input your card number';
                    }
                    else if (cardNum.length != 16) {
                      return 'Card Number must be exactly 16 digits';
                    }
                    else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                    child: TextFormField(
                      controller: cvcController,
                      decoration: InputDecoration(
                        hintText: 'CVC',
                        border: InputBorder.none
                      ),
                      validator: (cvc) {
                        if (cvc!.isEmpty) {
                          return 'Please input your cvc';
                        }
                        else if (cvc.length != 3) {
                          return 'CVC must be exactly 3 digits';
                        }
                        else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
                    child: TextField(
                      controller: familyNameController,
                      decoration: InputDecoration(
                        hintText: 'Expiration',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ) 
      
      
    );
  }
}