import 'package:flutter/material.dart';

import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactClass> contactModel = [];
  List<ContactClass> displayContact = [];
  bool showContactModule = true;
  bool showdelete = true;
  TextEditingController _textFieldController = new TextEditingController();
  String? valueText;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContactData();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Demo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              contactWidget(),
              // notesWidget(),
              // accessoriesWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: Colors.grey),
                  ],
                  color: Colors.blueGrey[50]),
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mobile Contacts',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      if (displayContact.isNotEmpty) {
                        setState(() {
                          displayContact.clear();
                          contactModel.clear();
                          showContactModule = false;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      _displayTextInputDialog(context);

                    },
                  ),
                ],
              ),
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
              child: ReorderableListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:displayContact .length,
                onReorder: (oldIndex, newIndex) => setState(() {
                  final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                  final user = displayContact.removeAt(oldIndex);
                  displayContact.insert(index, user);
                }),
                itemBuilder: (context, index) {
                  final user = displayContact[index];
                  return contactUI(index, user);
                },
              ),
            ),
            showContactModule
                ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      color: Colors.purple,
                      onPressed: () {
                        setState(() {
                          if(displayContact.isNotEmpty){
                            displayContact.shuffle();
                          }
                        });
                      },
                      child: Text(
                        'Shuffle',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
                : Container()
          ],
        ),
      ),
    );
  }


  Widget contactUI(int index, ContactClass user) => ListTile(
        key: ValueKey(user),

        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundImage: AssetImage(user.image!),
          radius: 30,
        ),
        title: Text(user.name!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            showdelete?
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeMobile(index),
            ) :Container(),
          ],
        ),
      );

  void loadContactData() {
    contactModel.add(ContactClass('Warner', 'image/dp.png'));
    contactModel.add(ContactClass('Watson', 'image/dp.png'));
    contactModel.add(ContactClass('Gill', 'image/dp.png'));
    contactModel.add(ContactClass('David', 'image/dp.png'));
    contactModel.add(ContactClass('Shane', 'image/dp.png'));

    displayContact = List.from(contactModel);
  }

  void removeMobile(int index) => setState(() => displayContact.removeAt(index));

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add contact'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Add contact"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    contactModel.add(ContactClass(valueText, 'image/dp.png'));
                    if(displayContact.isNotEmpty){
                      displayContact.clear();
                      displayContact = List.from(contactModel);
                    }else{
                      displayContact = List.from(contactModel);
                    }
                    showContactModule =true;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  void _runFilter(String value) {
      setState(() {
        displayContact = contactModel.where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase())).toList();
      });
      if(value.isEmpty){
        showdelete = true;
      }else{
        showdelete = false;
      }
  }

}
