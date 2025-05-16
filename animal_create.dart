import 'package:flutter/material.dart';
import 'animal.dart';

enum AnimalSpecies { mammal, reptile, insect }

class AnimalCreate extends StatefulWidget {
  final String title;
  final List<Animal> animalList;

  const AnimalCreate({
    super.key,
    required this.title,
    required this.animalList,
  });

  @override
  State<AnimalCreate> createState() => _AnimalCreateState();
}

class _AnimalCreateState extends State<AnimalCreate> {
  final TextEditingController _tecName = TextEditingController();
  AnimalSpecies? _rgAnimalSpecies = AnimalSpecies.mammal;
  bool _canFly = false;
  String _imagePath = 'assets/images/bee.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _tecName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "동물 이름"),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("포유류"),
                    leading: Radio<AnimalSpecies>(
                      value: AnimalSpecies.mammal,
                      groupValue: _rgAnimalSpecies,
                      onChanged: (AnimalSpecies? value) {
                        setState(() {
                          _rgAnimalSpecies = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("파충류"),
                    leading: Radio<AnimalSpecies>(
                      value: AnimalSpecies.reptile,
                      groupValue: _rgAnimalSpecies,
                      onChanged: (AnimalSpecies? value) {
                        setState(() {
                          _rgAnimalSpecies = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("곤충"),
                    leading: Radio<AnimalSpecies>(
                      value: AnimalSpecies.insect,
                      groupValue: _rgAnimalSpecies,
                      onChanged: (AnimalSpecies? value) {
                        setState(() {
                          _rgAnimalSpecies = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text("날 수 있나요?"),
              value: _canFly,
              onChanged: (bool? value) {
                setState(() {
                  _canFly = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            const SizedBox(height: 16),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildImageItem('assets/images/bee.png'),
                  _buildImageItem('assets/images/cat.png'),
                  _buildImageItem('assets/images/cow.png'),
                  _buildImageItem('assets/images/dog.png'),
                  _buildImageItem('assets/images/fox.png'),
                  _buildImageItem('assets/images/monkey.png'),
                  _buildImageItem('assets/images/pig.png'),
                  _buildImageItem('assets/images/wolf.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _insertAnimal,
              child: const Text("동물 추가"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String path) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _imagePath = path;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Image.asset(
          path,
          width: 60,
          height: 60,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void _insertAnimal() {
    final animal = Animal(
      name: _tecName.text,
      species: _getSpecies(_rgAnimalSpecies),
      canFly: _canFly,
      imagePath: _imagePath,
    );
    widget.animalList.add(animal);
    Navigator.pop(context); // 화면 닫기
  }

  String _getSpecies(AnimalSpecies? animalSpecies) {
    switch (animalSpecies) {
      case AnimalSpecies.mammal:
        return "포유류";
      case AnimalSpecies.reptile:
        return "파충류";
      case AnimalSpecies.insect:
        return "곤충";
      default:
        return "포유류";
    }
  }
}

