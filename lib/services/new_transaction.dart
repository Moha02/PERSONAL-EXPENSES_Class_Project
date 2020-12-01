import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import './image.dart';
import '../db/provider.dart';


class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction(this.addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  File storedImage;

  final amountController = TextEditingController();
  bool paid = false;
  final ImagePicker _picker = ImagePicker();
  DateTime _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTX(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _date() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print("...");
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        paid = newValue;

        if (paid) {
          paid = true;
        } else {
          paid = false;
        }
      });

  Function _selectImage(File pickedimage) {
    pickedimage = pickedimage;
    
  }

  // Future takePicture() async {
  //   final imagefile =
  //       await _picker.getImage(source: ImageSource.camera, maxWidth: 400);
  //       setState(() {
  //         _storedImage = imagefile;
  //       });
  // }
     

    

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              children: <Widget>[
                Text("Paid for ?"),
                Checkbox(value: paid, onChanged: _onRememberMeChanged),
              ],
            ),
            Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate == null
                      ? "No Date"
                      : DateFormat.yMd().format(_selectedDate)),
                  FlatButton(
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _date),
                  // Expanded(
                  //     child: FlatButton.icon(
                  //         onPressed: takePicture,
                  //         icon: Icon(Icons.camera),
                  //         label: Text("Take Picture")))
                ],
              ),
            ),
            ImageInput(_selectImage(storedImage)),
            RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => submitData()),
          ],
        ),
      ),
    );
  }
}