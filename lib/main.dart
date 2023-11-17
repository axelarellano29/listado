import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Persona> _personas = [
    Persona('José', 'Nabor', '20101589'),
    Persona('Pedro', 'Garcia', '20155689'),
    Persona('Natalia', 'Garcia', '20155689'),
    Persona('Carlos', 'Ruiz', '20155689')
  ];

  void _agregarPersona() {
    setState(() {
      _personas.add(Persona('Neck', 'Rosales', '20182345'));
    });
  }

  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Persona'),
          content:
              Text('¿Estás seguro de eliminar a ${_personas[index].nombre}?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() {
                  _personas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de alumnos'),
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_personas[index].nombre),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
            ),
            onDismissed: (direction) {
              _eliminarPersona(index);
            },
            child: ListTile(
              title: Text(
                  '${_personas[index].nombre} ${_personas[index].lastName}'),
              subtitle: Text(_personas[index].cuenta),
              leading: CircleAvatar(
                child: Text(_personas[index].nombre.substring(0, 1)),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print(_personas[index].cuenta);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 174, 94, 170),
        child: Icon(Icons.add),
        onPressed: _agregarPersona,
      ),
    );
  }
}

class Persona {
  String nombre;
  String lastName;
  String cuenta;

  Persona(this.nombre, this.lastName, this.cuenta);
}