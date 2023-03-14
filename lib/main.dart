import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      //By setting the primary color swatch to "blueGrey", it will affect various elements in the app such as the app bar, buttons, and other UI components.
      home: ProfileFormPage(), //calling the profile form function
    );
  }
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  int age = 0;

  String gender = '';

  String country = '';
  List<String> hobbies = [];

  //function to validate and save the current state
  void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      // Invalid!
      return;
    }
    form?.save();
    setState(() {});

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  name: name,
                  age: age,
                  gender: gender,
                  country: country,
                  hobbies: hobbies,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Profile'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "Username can't be empty";
                  }

                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your gender';
                  }
                  return null;
                },
                onSaved: (value) {
                  gender = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Country',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your country';
                  }
                  return null;
                },
                onSaved: (value) {
                  country = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hobbies',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter at least one hobby';
                  }
                  return null;
                },
                onSaved: (value) {
                  hobbies =
                      value!.split(',').map((hobby) => hobby.trim()).toList();
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: _submitForm, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String name;
  final int age;
  final String gender;
  final String country;
  final List<String> hobbies;

  ProfilePage({
    required this.name,
    required this.age,
    required this.gender,
    required this.country,
    required this.hobbies,
  });



  @override
  _ProfilePageState createState() => _ProfilePageState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final _articleController = TextEditingController();
  final _formKey = GlobalKey<FormState>() ;

  @override
  void dispose() {
    _articleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Your Profile Page'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child : Form(
    key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.name}',
              style: TextStyle(height: 2, fontSize: 25),
            ),
            Text(
              'Age: ${widget.age}',

              style: TextStyle(height: 2, fontSize: 25),
            ),
            Text(
              'Gender: ${widget.gender} ',
              style: TextStyle(height: 2, fontSize: 25),
            ),
            Text(
              'Country: ${widget.country} ',
              style: TextStyle(height: 2, fontSize: 25),
            ),
            Text(
              'Hobbies:',
              style: TextStyle(height: 2, fontSize: 25),
            ),
            Text(
              widget.hobbies.join(', '),
              style: TextStyle(height: 2, fontSize: 25),
            ),
            SizedBox(height: 16),
            Text(
              'Post:',
              style: TextStyle(height: 2, fontSize: 25),
            ),
            TextFormField(
    key: ValueKey('article'),
              controller: _articleController,
              decoration: InputDecoration(
                hintText: 'Enter your article',
              ),
    validator: (value){
      if(value!.isEmpty){
        return 'Enter your article';
    }
      return null ;
    },
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
    // Handle button press
    print('Button pressed');
    print('Article: ${_articleController.text}');
    setState(() {});
    }

              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            Text('Article:',style:TextStyle(height: 2, fontSize: 25) ,),
            Text(_articleController.text,style: TextStyle(height: 2, fontSize: 25),),
          ],
        ),
    ),
      ),
      ),
    );
  }
}

class ProfileFormPage extends StatefulWidget {
  @override
  _ProfileFormPageState createState() => _ProfileFormPageState();
}
