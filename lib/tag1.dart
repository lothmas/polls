import 'package:flutter/material.dart';

import 'package:flutter_tags/input_tags.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//void main() => runApp(MyApp());


class VoteNeededData extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

//      title: 'Flutter Demo',
//      theme: ThemeData(
//
//        primarySwatch: Colors.blueGrey,
//      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin
{
  TabController _tabController;
  ScrollController _scrollViewController;

  final List<String> _list = [
    'gender','location','race','age',
    'occupation','views',
  ];



  bool _symmetry = true;
  int _column = 4;
  double _fontSize = 12;

  String _selectableOnPressed = '';
  String _inputOnPressed = '';

  List<Tag> _selectableTags = [];
  List<String> _inputTags = [];

  List _icon=[
    Icons.home,
    Icons.language,
    Icons.headset
  ];

  @override
  void initState()
  {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _list.forEach((item) =>
        _selectableTags.add(
            Tag(title: item, active: true,icon: (item=='0' || item=='1' || item=='2')? _icon[ int.parse(item) ]:null )
        )
    );


  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
          body: TabBarView(
            controller: _tabController,
            children:  [
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[

                      Column(
                        children: <Widget>[
                          Text('Poll Statistics You Want Produce',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: SelectableTags(
                          tags: _selectableTags,
                          columns: _column,
                          fontSize: _fontSize,
                          symmetry: _symmetry,
                          onPressed: (tag){
                            setState(() {
                              _selectableOnPressed = tag.toString();
                            });
                          },
                        ),
                      ),

                      Column(
                        children: <Widget>[
                          Divider(
                            height: 1.0,
                          ),
                          Container(
                            height: 15,
                          ),
                          Text('Poll Restrictions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: FormBuilder(
                        context,
                        autovalidate: true,
  controls: [
  FormBuilderInput.textField(
  type: FormBuilderInput.TYPE_TEXT,
  attribute: "name",
  label: "Name",
  require: true,
  min: 3,
  ),
  FormBuilderInput.dropdown(
  attribute: "dropdown",
  require: true,
  label: "Dropdown",
  hint: "Select Option",
  options: [
  FormBuilderInputOption(value: "Option 1"),
  FormBuilderInputOption(value: "Option 2"),
  FormBuilderInputOption(value: "Option 3"),
  ],
  ),
  FormBuilderInput.number(
  attribute: "age",
  label: "Age",
  require: true,
  min: 18,
  ),
  FormBuilderInput.textField(
  type: FormBuilderInput.TYPE_EMAIL,
  attribute: "email",
  label: "Email",
  require: true,
  ),
  FormBuilderInput.textField(
  type: FormBuilderInput.TYPE_URL,
  attribute: "url",
  label: "URL",
  require: true,
  ),
  FormBuilderInput.textField(
  type: FormBuilderInput.TYPE_PHONE,
  attribute: "phone",
  label: "Phone",
  //require: true,
  ),
  FormBuilderInput.password(
  attribute: "password",
  label: "Password",
  //require: true,
  ),
  FormBuilderInput.datePicker(
  label: "Date of Birth",
  attribute: "dob",
  ),
  FormBuilderInput.timePicker(
  label: "Appointment Time",
  attribute: "time",
  ),
  FormBuilderInput.checkboxList(
  label: "My Languages",
  attribute: "languages",
  require: false,
  value: ["Dart"],
  options: [
  FormBuilderInputOption(value: "Dart"),
  FormBuilderInputOption(value: "Kotlin"),
  FormBuilderInputOption(value: "Java"),
  FormBuilderInputOption(value: "Swift"),
  FormBuilderInputOption(value: "Objective-C"),
  ],
  ),
  FormBuilderInput.radio(
  label: "My Best Language",
  attribute: "best_language",
  require: true,
  options: [
  FormBuilderInputOption(value: "Dart"),
  FormBuilderInputOption(value: "Kotlin"),
  FormBuilderInputOption(value: "Java"),
  FormBuilderInputOption(value: "Swift"),
  FormBuilderInputOption(value: "Objective-C"),
  ],
  ),
  FormBuilderInput.checkbox(
  label: "I accept the terms and conditions",
  attribute: "accept_terms",
  hint: "Kindly make sure you've read all the terms and conditions",
  validator: (value){
  if(!value)
  return "Accept terms to continue";
  }
  ),
  FormBuilderInput.slider(
  label: "Slider",
  attribute: "slider",
  hint: "Hint",
  min: 0.0,
  require: true,
  max: 100.0,
  value: 10.0,
  divisions: 20,
  ),
  FormBuilderInput.stepper(
  label: "Stepper",
  attribute: "stepper",
  value: 10,
  step: 1,
  hint: "Hint",
  ),
  FormBuilderInput.rate(
  label: "Rate",
  attribute: "rate",
  iconSize: 48.0,
  value: 1,
  max: 5,
  hint: "Hint",
  ),
  FormBuilderInput.segmentedControl(
  label: "Movie Rating (Archer)",
  attribute: "movie_rating",
  require: true,
  options: [
  FormBuilderInputOption(
  value: 1,
  ),
  FormBuilderInputOption(
  value: 2,
  ),
  FormBuilderInputOption(
  value: 3,
  ),
  FormBuilderInputOption(
  value: 4,
  ),
  FormBuilderInputOption(
  value: 5,
  ),
  FormBuilderInputOption(
  value: 6,
  ),
  FormBuilderInputOption(
  value: 7,
  ),
  FormBuilderInputOption(
  value: 8,
  ),
  FormBuilderInputOption(
  value: 9,
  ),
  FormBuilderInputOption(
  value: 10,
  ),
  ]),
    ],


                      ),

                  ),
                ],
              ),



            ],
          )])

    );}


  List<DropdownMenuItem> _buildItems()
  {
    List<DropdownMenuItem> list = [];

    int count = 15;

    for(int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString() ),
          value: i,
        ),
      );

    return list;
  }
}