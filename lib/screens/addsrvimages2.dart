import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodclicks/model/surveyo.dart';
import 'package:moodclicks/screens/surveydisplay2.dart';
import 'package:moodclicks/screens/votinghome.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:moodclicks/model/classopinion.dart';

class AddSrvImages extends StatefulWidget {
  final String name;
  final String description;
  final String surveyId;
  // TODO: Add additional Details from SignUp e.g. Phone No. , verify e-mail,

  const AddSrvImages(
      {Key? key,
      required this.name,
      required this.description,
      required this.surveyId})
      : super(key: key);

  @override
  _AddSrvImagesState createState() => _AddSrvImagesState();
}

class _AddSrvImagesState extends State<AddSrvImages> {
// Implemented image picker using code from : https://www.youtube.com/watch?v=MSv38jO4EJk
// Can also use: https://fabcoding.com/2020/06/08/adding-an-image-picker-in-a-flutter-app-pick-images-using-camera-and-gallery-photos/
  var imageUrlFire;
  File? image;
  bool submittedToCloud = false;

  void uploadImage(ImageSource imgsrc, [String? optionText]) async {
    final _storage = FirebaseStorage.instance;
    // final _picker = ImagePicker();
    // PickedFile image;
    // File image;
// TODO: Check Permissions : https://www.youtube.com/watch?v=pvRpzyBYBbA Inludes APPLE Code Adj
    // image =
    //     (await _picker.pickImage(source: ImageSource.gallery)) as PickedFile;

    var imageCloud = await ImagePicker().pickImage(source: imgsrc);
    // _popDialogAddText(context);
    print("Hello Img Saving");

    print(PickedFile);
    print(imageCloud!.path);
    var file = File(imageCloud.path); //Fullpath
    var fileName = File(basename(imageCloud.path));
    if (imageCloud != null && optionText != null) {
      final name = basename(imageCloud.path);
      // var snapshot =
      //     await _storage.ref().child('folderName/$name').putFile(file);
      // print(snapshot);
      // var downloadUrl = await snapshot.ref.getDownloadURL();
      // print('DOWNLOAD url');
      // print(downloadUrl);
      Map<String, dynamic> data = {
        "imageLocation": file, //In Phone
        "imageName": fileName, //Name of image
        // "downloadUrl": downloadUrl,
        "downloadUrl": '', //Location in CloudFireStorage
        "votes": 0,
        "description": optionText
      };
      imgMapList.add(data);

      setState(() {
        // imageUrlFire = downloadUrl;
      });
// added HA 20220101
      MaterialPageRoute(builder: (BuildContext context) => QList());
    } else if (imageCloud != null) {
      final name = basename(imageCloud.path);
      var snapshot =
          await _storage.ref().child('folderName/$name').putFile(file);
      print(snapshot);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print('DOWNLOAD url');
      print(downloadUrl);
      Map<String, dynamic> data = {
        "imageLocation": file, //In Phone
        "imageName": fileName, //Name of image
        "downloadUrl": '', //Location in CloudFireStorage
        "votes": 0,
        "description": null
      };
      imgMapList.add(data);
// ADDED: HA 20220103
      // final imageTemp = File(file.path.toString());
      // this.imgLocA = imageTemp as String;
      // setState(() => this.imgLocA = imageTemp as String);
// ADDED: HA 20220103 END
      setState(() {
        // imageUrlFire = downloadUrl;
      });
      // added HA 20220101
      MaterialPageRoute(builder: (BuildContext context) => QList());
    } else if (optionText!.isNotEmpty) {
      // final name = basename(imageCloud.path);
      // var snapshot =
      //     await _storage.ref().child('folderName/$name').putFile(file);
      // print(snapshot);
      // var downloadUrl = await snapshot.ref.getDownloadURL();
      // print('DOWNLOAD url');
      // print(downloadUrl);
      Map<String, dynamic> data = {
        "imageLocation": "", //In Phone
        "imageName": "", //Name of image
        "downloadUrl": "", //Location in CloudFireStorage
        "votes": 0,
        "description": optionText
      };
      imgMapList.add(data);

      // setState(() {
      //   imageUrlFire = downloadUrl;
      // });
    } else {
      print('No path ffound');
    }
  }

  void submitChoicesToCloud() async {
    // void submitChoices(ImageSource imgsrc, [String? optionText]) async {
    final _storage = await FirebaseStorage.instance;
// TODO: Check Permissions : https://www.youtube.com/watch?v=pvRpzyBYBbA Inludes APPLE Code Adj

    for (int i = 0; i < imgMapList.length; i++) {
      print(imgMapList[i]['imageName']);
      print(imgMapList[i]['imageLocation']);
      print(imgMapList[i]['downloadUrl']);
    }

    for (int i = 0; i < imgMapList.length; i++) {
      var name = imgMapList[i]['imageName'];
      var file = imgMapList[i]['imageLocation'];
      // print(imgMapList[i]['description']);
      // print(imgMapList[i]['downloadUrl']);

      var snapshot =
          await _storage.ref().child('folderName/$name').putFile(file);
      print(snapshot);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      imgMapList[i]['downloadUrl'] = downloadUrl;
    }
    print("URLS Updated");

    setState(() {});

    Future.delayed(Duration(seconds: 2), () => uploadOpinListToFire());
    submittedToCloud = true;
  }

  late String imgLocA;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      // this.image = imageTemporary;
      // setState(() => this.image = imageTemporary);

      final imagePermanent = await saveImagePermanently(image.path);
      print('LOCATION IF IMAGES: ' + image.path);
      this.image = imagePermanent;
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('failed to pick images: $e');
    }
  }

  Future uploadListToFire() async {
    // FirebaseFirestore.instance.collection("questions").doc().update(
    final _fireStore = FirebaseFirestore.instance;
    List surveyItem = [];

    print(widget.name);

    // for (int j = 0; j < imgMapList.length; j++) print(j);
    for (int i = 0; i < imgMapList.length; i++)
      surveyItem.add({
        "votes": imgMapList.toList()[i]['votes'],
        "downloadUrl": imgMapList.toList()[i]['downloadUrl'].toString(),
      });

    // var snapshot =
    await _fireStore.collection('questions').doc(widget.surveyId).set({
      'f01surveyname': widget.name,
      "f02surveydescription": widget.description,
      "items": FieldValue.arrayUnion(surveyItem),
      // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
    }, SetOptions(merge: true)).then((_) {
      print("IMAGES added to Survey!!");
    });
  }

  Future uploadOpinListToFire() async {
    final _fireStore = FirebaseFirestore.instance;
    List surveyItem = [];

    print(widget.name);

    for (int i = 0; i < imgMapList.length; i++)
      surveyItem.add({
        "votes": imgMapList.toList()[i]['votes'],
        "downloadUrl": imgMapList.toList()[i]['downloadUrl'],
        // Update HA: 2022/01/01 add
        // "optionText": imgMapList.toList()[i]['optionText'],
        "description": imgMapList.toList()[i]['description'],
      });

    await _fireStore.collection('opinion').doc(widget.surveyId).set({
      'name': widget.name,
      "description": widget.description,
      //2021/12/29: Added "surveyDocId"
      "surveyDocId": widget.surveyId,
      "sets": FieldValue.arrayUnion(surveyItem),
    }, SetOptions(merge: true)).then((_) {
      print("IMAGES added to Survey!!");
    });
  }

// TODO: Make survey Publi/Private?
// TODO: Create and save groups in profile e.g. send to group - List Group?
// TODO: How to access Contacts in phone and groups in WhatsApp?
// TODO: Create Launch Page and show popular public votes on TOP Card.

  int _votes = 0;

  late String imageUrl;

  List<File> imgLoc = [];
  List<String> imgLocation = [];
  List<String> imgName = [];
  List<Map> imgMapList = [];

  Future<File> saveImagePermanently(String imagePath) async {
    final _storage = FirebaseStorage.instance;
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(directory);

    imgLocation.add(basename(imagePath));
    imgName.add(name);
    imgLoc.add(image);

    Map<String, dynamic> data = {
      "imageLocation": image,
      "votes": 0,
      "optionText": ""
    };
    imgMapList.add(data);
    print("Imahe List Location: ");
    print(imgLocation);
    print("Imahe List Path: ");
    print(imagePath);
    // return File(imagePath).copy(image.path);

// EXTRA TO UPLOAD TO FIREBASE STORAGE:

    try {
      var snapshot = await _storage.ref().child('images').putFile(image);

      var downloadurl = snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadurl as String;
      });
    } catch (e) {
      print(e);
      print("NO FILE  UPload");
    }
    return File(imagePath).copy(image.path);

    // }
  }

  Future<File> saveImagePermanently2(String imagePath) async {
    final _storage = FirebaseStorage.instance;
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(directory);

    imgLocation.add(basename(imagePath));
    imgName.add(name);
    imgLoc.add(image);

    Map<String, dynamic> data = {
      "imageLocation": image,
      "votes": 0,
      "optionText": ""
    };
    imgMapList.add(data);
    print("Imahe List Location: ");
    print(imgLocation);
    print("Imahe List Path: ");
    print(imagePath);
    // return File(imagePath).copy(image.path);

// EXTRA TO UPLOAD TO FIREBASE STORAGE:

    try {
      var snapshot = await _storage.ref().child('images').putFile(image);

      var downloadurl = snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadurl as String;
      });
    } catch (e) {
      print(e);
      print("NO FILE  UPload");
    }
    return File(imagePath).copy(image.path);
  }

  void _printImgLocationList() {
    print(imgLocation);
  }

  void _printImgNameList() {
    print(imgName);
  }

  void _printImgMapList() {
    print(imgMapList);
  }

  void _clearImgNameList() {
    setState(() {
      imgLoc.clear();
    });
  }

  // late String name;
  final loggedInUser = FirebaseAuth.instance.currentUser!.uid.toString();
  TextEditingController question = new TextEditingController();
  int _index = 0;
  List<String> srvquestions = [
    "Hello inspire11",
    "HEllo Inspire 2",
    "Hello inspire 3",
    "HEllo Inspire 4",
  ];

  List<String> srvq = [
    "Question1",
    "Question2",
    "Question3",
  ];

  List yourItemList = [];

  List<File> _imageList = [];

  int index = 0;

  void _addImage(File _newimage) {
    setState(() {
      index += 1;
      _imageList.add(_newimage);
      print("HA path" + _newimage.path);
    });
  }

  void _printImgList() {
    print(_imageList.toString());
  }

//DONT DELETE _voteincr() - Can be reused for Voting via GridView
  void _voteincr() {
    setState(() {
      _votes += 1;

      print(" ONe Vote added");
    });
  }

//DONT DELETE _voteIncrMap(index) - Can be reused for Voting via GridView
  void _voteIncrMap(index) {
    setState(() {
      imgMapList[index]['votes'] += 1;
      print(" ONe Vote added to ");
    });
  }

// ADD VOTES CAST 1...n Votes where there is a choice of > 1  START

  void dummyAddList(int n) {
    castVotes.add(n);
  }

  List<int> castVotes = [];

  List<int> toListVotes() {
    List<int> sendVotes = [];
    castVotes.forEach((item) {
      sendVotes.add(item);
    });
    return sendVotes.toList();
  }

// ADD VOTES CAST 1...n Votes where there is a choice of > 1  END

  Future<Widget> _rowView() async {
    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Text(
          "Geeks",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Text(
          "For",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.green),
        child: Text(
          "Geeks",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      )
    ]);

    return Row();
  }

  Row calculateListOfStars() {
    final List<Widget> rowList = [];

    rowList.addAll([Text("Widget1-Add Image Stream")]);

    rowList.addAll([Text("2-VotesStream")]);

    rowList.addAll([Text("3-Calc% stream/func?")]);

    final Row rowStars = Row(
      children: rowList,
    );

    return rowStars;
  }

  @override
  Widget build(BuildContext context) {
    // var item = yourItemList.length - 1;

    // FutureBuilder<Exercise> exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text("4. addsrvimages2.dart"),
      ),

      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      widget.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),

              // DEV NOTES:  Can also choose many images using final List <XFile>? images = await  _picker.pickMultiImage();
              // Read Documentation for details: https://pub.dev/packages/image_picker/versions/0.8.3+1/example
              // Take note of changes required if you want to implement in iOS need to update the Runner/Info.plist and add NSCameraUsageDescription...n

              SizedBox(
                height: 44,
              ),
              TextFormField(
                controller: question,
                decoration: InputDecoration(
                    hintText:
                        "Add Option item to survey e.g. What to have for Dinner?  "),
              ),
              SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    addOptionButton(context),
                  ]),

              SizedBox(
                height: 34,
              ),
              preview(context),
              addImgToCloudOrEdit(context),
              // TODO: CREATE BUTTON Appear only once Feedback received Images have been loaded ->
              // Return Message Poll Created and Images Loaded -> THEN Provide Link to View Full Poll

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("KEEP: Upload Choice List to Firebase"),
                  onPressed: () =>
                      // uploadListToFire(),
                      //(ImageSource.gallery),
                      uploadOpinListToFire(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: Text(
                    'Merge these ^^ Two Buttons above and Move to Next Screen on CLick. Create Variable and setState to Fix These Vals and Remove Edit Option'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  icon: Icon(Icons.ac_unit),
                  label: Text(":>Submit Img/Choices to CLOUD<:"),
                  onPressed: () => {
                        submitChoicesToCloud(),
                        uploadOpinListToFire(),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SurveyDisplay2(
                              surveyId: widget.surveyId,
                            ),
                          ),
                        ),
                      }),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(_textFieldController.text),
              ),
              SizedBox(
                height: 10,
              ),

              ElevatedButton.icon(
                  icon: Icon(Icons.ac_unit),
                  label: Text("Submit Vote:"),
                  onPressed: () => {
                        dummyAddList(23),
                        print(castVotes[0].toString()),
                      }),

              ElevatedButton.icon(
                  icon: Icon(Icons.ac_unit),
                  label: Text("PrintLocalImgLocation:"),
                  onPressed: () => {_printimgMapList()}),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              QList())); //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  " View Sample Survey (Static):",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              // ViewSurvey()));
                              // SurveyDisplay()));
                              SurveyDisplay2(
                                surveyId: widget.surveyId,
                              )));
                  // ViewSurveyOnlyList()));
                  //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  " VIEW Single Saved Survey  >>> returnfromcloudsurvey:",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              // ViewSurvey()));
                              // SurveyDisplay()));
                              VotingChoices(
                                surveyId: widget.surveyId,
                              )));
                  // ViewSurveyOnlyList()));
                  //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  " VIEW Single Saved POLL Survey  >>> returnfromcloudsurvey:",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void removeItem(int item) => removeItemFromList(item);

  void _uploadQList() {
    // FirebaseFirestore.instance.collection("questions").doc().update(

    final loggedInUser = FirebaseAuth.instance.currentUser;
    print(widget.name);
    for (int i = 0; i < srvquestions.length; i++)
      yourItemList.add({"f03question": srvquestions.toList()[i]});

    FirebaseFirestore.instance
        .collection('questions')
        // .doc('qfZnaKiRDN5PQsJ0VYNE')
        .doc('1kLoOdBuETF9w4GJoHnn')
        .update({
      'f00userid': loggedInUser!.uid,
      'f01surveyname': widget.name,
      "f02surveydescription": widget.description,
      "f03question": FieldValue.arrayUnion(yourItemList),
    });
  }

  void _removeItemFromList() {
    // FirebaseFirestore.instance.collection("questions").doc().update(
    // print(widget.name);
    // for (int i = 0; i < srvquestions.length; i++)
    yourItemList.removeAt(yourItemList.length);

    // FirebaseFirestore.instance
    //     .collection('questions')
    //     .doc('n2ixEbIzlPHR0ngVUtoY')
    //     .update({
    //   // 'f01surveyname': widget.name,
    //   // "f02surveydescription": widget.description,
    //   "f03question": FieldValue.arrayUnion(yourItemList),
    // });
  }

  // "f00userid": loggedInUser,
  // "f01surveyname": widget.name,
  // "f02surveydescription": widget.description,
  // "f03question": question.text,
  // "f04questionsexist": "Y",

  void _showQuote() {
    print(_index);
    setState(() {
      _index += 1;
    });
  }

  void _resetIndex() {
    print(_index);
    setState(() {
      _index = 0;
    });
  }

  void _printList() {
    print(srvquestions);
  }

  void _addQuestion() {
    print(_index);
    print("ADDING New Question to LIST[]: " + question.text);
    setState(() {
      _index += 1;
      srvquestions.add(question.text);
    });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }

  void showSubmitted(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ElevatedButton.icon(
            icon: Icon(Icons.close),
            label: Text("Submitted Already"),
            onPressed: () => {Navigator.of(context).pop()}),
      ),
    );
  }

  void _popDialogMain(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: Container(
                height: 400.0,
                width: 360.0,
                child: ListView(children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "+Add Questions",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Question Choices Style:",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                        icon: Icon(Icons.add_a_photo),
                        label: Text("Image Only"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _popDialogImage(context);
                          // Navigator.of(context).pop();
                        }
                        //(ImageSource.gallery),
                        ),
                  ),
                  Center(
                    child: Text("Sample image and selection dialogue box"),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_a_photo),
                      label: Text("Text Only"),
                      onPressed: () => uploadImage(
                          ImageSource.camera, ""), //(ImageSource.gallery),
                    ),
                  ),
                  Center(
                    child: Text("Sample text and selection dialogue box"),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_a_photo),
                      label: Text("Image with Text"),
                      onPressed: () => uploadImage(
                          ImageSource.camera, ""), //(ImageSource.gallery),
                    ),
                  ),
                  Center(
                    child:
                        Text("Sample image + Text and selection dialogue row"),
                  ),
                ])));
      },
    );

    // .then((value) {
    //   Navigator.pop(context);
    // });
  }

  Widget preview(context) {
    try {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: imgMapList.length,
        itemBuilder: (context, index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: imgMapList[index]['description'] == null
                      ? Text('No Image Showing')
                      : ClipRRect(
                          borderRadius:
                              BorderRadius.circular(34), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(68), // Image radius
                            child: Image.file(
                              imgMapList[index]['imageLocation'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(imgMapList[index]['description'].toString())),
                ),
                Center(child: editButton()),
              ]);
        },
      );
    } catch (e) {
      return Text("Not Pics Yet: $e ");
    }
  }

  void _removeBallotOption(int item) {
    print(item.toString());
    print("SELECTED OPTIO TO DELETE:");
    print(imgMapList[index]);
    imgMapList.removeAt(item);
    //TODO: Need to Also Remove from Cloud
    // imgMapList[index].removeWhere((key, value) => false)(item);
    setState(() {});
  }

  Widget editButton() {
    if (submittedToCloud) {
      return ElevatedButton.icon(
        icon: Icon(
          Icons.emoji_emotions_rounded,
          color: Colors.red,
        ),
        label: Text("Saved option"),
        // onPressed: () => uploadImage(
        //   ImageSource.camera,
        // ),
        onPressed: () {
          print('NOT Editable - Already Submitted Option to Cloud');
          // setState(() {});
        },
      );
    }
    return ElevatedButton.icon(
      icon: Icon(
        Icons.remove_circle,
        color: Colors.red,
      ),
      label: Text("REMOVE"),
      onPressed: () {
        print(imgMapList[index]);
        _removeBallotOption(index);
      },
    );
  }

  Widget addOptionButton(context) {
    if (submittedToCloud) {
      return ElevatedButton.icon(
        icon: Icon(
          Icons.add_circle,
          color: Colors.grey,
        ),
        label: Text("Add Options e.g.Pizza, Italian, Chinese?"),
        onPressed: () {
          print('Submitted Choices Cannot Edit');
        }, //(ImageSource.gallery),
      );
    }
    return ElevatedButton.icon(
      icon: Icon(Icons.add_circle),
      label: Text("Add Options to Survey e.g.Pizza, Italian, Chinese?"),
      onPressed: () {
        _popDialogMain(context);
      }, //(ImageSource.gallery),
    );
  }

  Widget addImgToCloudOrEdit(context) {
    if (submittedToCloud) {
      return ElevatedButton.icon(
        icon: Icon(
          Icons.add_circle,
          color: Colors.grey,
        ),
        label: Text("Edit"),
        onPressed: () {
          print('Enable Edit');
          submittedToCloud = false;
          setState(() {});
        }, //(ImageSource.gallery),
      );
    }
    return ElevatedButton.icon(
        icon: Icon(Icons.ac_unit),
        label: Text("SAVE Img To Cloud + //List to Fire:"),
        onPressed: () => {
              if (submittedToCloud)
                {
                  showSubmitted(context),
                }
              else
                {
                  submitChoicesToCloud(),
                  // Future.delayed(
                  //     Duration(seconds: 5), () => uploadOpinListToFire()),
                  // submittedToCloud = true,
                }
            });
  }

  void _popDialogImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: Center(
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  child: ListView(children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add_a_photo),
                        label: Text("Image from Camera"),
                        onPressed: () => uploadImage(
                          ImageSource.camera,
                        ), //(ImageSource.gallery),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.add_a_photo_outlined),
                          label: Text("Image from Gallary"),
                          onPressed: () {
                            chooseImg(context);
                          }),
                    ),
                    Center(
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.add_a_photo_outlined),
                          label: Text("Print img from Gallary"),
                          onPressed: () {
                            // printimg();
                          }

                          //(ImageSource.gallery),
                          ),
                    ),
                    Center(
                      child: Text("Add Preview of Image in box below!:"),
                    ),
                  ])),
            ));
      },
    );
    // .then((value) {
    //   Navigator.of(context).pop;
    // });
  }

  void _popDialogAddText(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              child: ListView(children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.add_a_photo),
                      label: Text("+ADD Text"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _displayTextInputDialog(context);
                        print("Image Locaion");
                        // Navigator.of(context).pop();

                        // Navigator.of(context).pop();
                        // submitChoice(context);
                      }
                      //(ImageSource.gallery),
                      ),
                ),
                SizedBox(height: 20),
                // Text(_textFieldController.text),
                SizedBox(height: 20),
                // Text(OptionsTextList.last),
                Text(textIputCheck().toString()),
              ]),
            ),
          ),
        );
      },
    );
    // .then((value) {
    //   Navigator.of(context).pop;
    // });
  }

  void _popDialogPostAddText(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
            // height: 00.0,
            // width: 200.0,
            child: ListView(children: <Widget>[
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("+Option Text/Image: "),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      // _displayTextInputDialog(context);
                      printLastOption();
                      print("Submitted Option");
                      addLastOption(OptionsTextList.last.toString());
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                      setState(() {});

                      // Navigator.of(context).pop();
                      // submitChoice(context);
                    }
                    //(ImageSource.gallery),
                    ),
              ),
              SizedBox(height: 20),
              Center(child: Text(OptionsTextList.last)),
              SizedBox(height: 20),
              Container(
                // width: 100,
                height: 260,
                color: Colors.yellow,
                // child: Image.network(
                //   "$imageUrlFire",
                //   fit: BoxFit.contain,
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(68), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    child: Image.file(
                      imgMapList[index]['imageLocation'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ]),
          ),
        );
      },
    );
    // .then((value) {
    //   Navigator.of(context).pop;
    // });
  }

  void chooseImg(context) {
    Navigator.of(context).pop();
    // uploadImage(ImageSource.gallery, "smoe text");
    uploadImage(ImageSource.gallery);

    // await Future.delayed(Duration(seconds: 5)).then((value) {
    _popDialogAddText(context);
    // });
  }

  void submitChoice(context) {
    Navigator.of(context).pop();
  }

  TextEditingController _textFieldController = TextEditingController();

  bool textIn = false;

  Future<String> textIputCheck() async {
    if (textIn == true) {
      return OptionsTextList.last;
    } else
      return "";
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // ignore: deprecated_member_use
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _popDialogAddText(context);
                setState(() {
                  textIn = true;
                });
                OptionsTextList.add(_textFieldController.text);
                _textFieldController.clear();
                _popDialogPostAddText(context);
                // Navigator.of(context).pop();
                print('Image LocA:');
                print(imageUrlFire);

                // print(imgLocA);
              },
            ),
          ],
        );
      },
    );
  }

  List<String> OptionsTextList = [];

  void printLastOption() {
    if (imgMapList.isEmpty)
      print("Empty List");
    else
      print('LAST:');
    print(imgMapList[0]['votes']);
    print(imgMapList.last['description']);
    print(imgMapList.last['downloadUrl']);
  }

  void addLastOption(String optionText) {
    if (imgMapList.isEmpty)
      print("Empty List");
    else
      print(imgMapList.last);
    imgMapList.last.update('description', (value) => '$optionText');
    printLastOption();
  }

  void _printimgMapList() {
    print("Printing Local image locations: ");
    for (int i = 0; i < imgMapList.length; i++) {
      print(imgMapList[i]['imageLocation'].toString());
    }
  }
}

List<Set> log = [];

List<Map> ballotMapList = [];
List<Map> castBallots = [];

Future<List<Map>> addBallot(String options) async {
  if (options.isNotEmpty) {
    try {
      Map<String, dynamic> data = {
        "option": options,
        "vote": 1,
      };

      ballotMapList.add(data);
    } catch (e) {
      print(e.toString());
    }
  }
  return List.empty();
}
