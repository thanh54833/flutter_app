import 'dart:async';

import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/view/bass_boost.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool enableCustomEQ = false;

  @override
  void initState() {
    super.initState();
    Equalizer.init(0);
  }

  @override
  void dispose() {
    Equalizer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Equalizer example'),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.grey.withOpacity(0.1),
              child: SwitchListTile(
                title: Text(
                  'Custom Equalizer',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'GafataRegular',
                      fontSize: 16),
                ),
                value: enableCustomEQ,
                onChanged: (value) {
                  Equalizer.setEnabled(value);
                  setState(() {
                    enableCustomEQ = value;
                  });
                },
                activeColor: LocalColor.Primary,
              ),
            ),
            FutureBuilder<List<int>>(
              future: Equalizer.getBandLevelRange(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? CustomEQ(enableCustomEQ, snapshot.data)
                    : CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange);

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  _CustomEQState createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  double min, max;
  Future<List<String>> fetchPresets;
  int itemSelected = 0;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
    fetchPresets = Equalizer.getPresetNames();

    // var bass = BassBoost(audioSessionId: 0);
    // //47417
    // bass.getEnabled().then((value) {
    //   "getEnabled :.. ${value} ".Log();
    // });
    // bass.setEnabled(enabled: true);
    // bass.setStrength(strength: 100);
  }

  setBass() async {
    BassBoost bassBoost = new BassBoost(audioSessionId: 0);
    var setStrength = await bassBoost.setStrength(strength: 300);

    "setStrength :... ${setStrength} ".Log();

  }

  @override
  Widget build(BuildContext context) {
    int bandId = 0;

    setBass();

    return FutureBuilder<List<int>>(
      future: Equalizer.getCenterBandFreqs(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data
                        .map((freq) => _buildSliderBand(freq, bandId++))
                        .toList(),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: _buildPresets(),
                  ),
                ],
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget _buildSliderBand(int freq, int bandId) {
    return Column(
      children: [
        SizedBox(
          height: 250.0,
          child: FutureBuilder<int>(
            future: Equalizer.getBandLevel(bandId),
            builder: (context, snapshot) {
              return FlutterSlider(
                disabled: !widget.enabled,
                axis: Axis.vertical,
                rtl: true,
                min: min,
                max: max,
                values: [snapshot.hasData ? snapshot.data.toDouble() : 0],
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  Equalizer.setBandLevel(bandId, lowerValue.toInt());
                },
              );
            },
          ),
        ),
        Text('${freq ~/ 1000} Hz'),
      ],
    );
  }

  String _selectedValue;

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
        future: fetchPresets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final presets = snapshot.data;
            if (presets.isEmpty) return Text('No presets available!');
            List<Widget> list = [];
            presets.asMap().forEach((index, item) {
              list.add(Container(
                child: ChoiceChip(
                  label: Text(
                    item,
                    style: TextStyle(
                        fontFamily: 'GafataRegular',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (itemSelected == index)
                            ? LocalColor.Primary
                            : Colors.grey),
                  ),
                  selected: itemSelected == index,
                  onSelected: (value) {
                    //"onSelected :.. ${item} ".Log();
                    Equalizer.setPreset(item);
                    setState(() {
                      itemSelected = index;
                      _selectedValue = item;
                    });
                  },
                  selectedColor: LocalColor.Primary_20,
                  //disabledColor: Colors.grey.withOpacity(20),
                  backgroundColor: Colors.grey.shade200,
                ),
                margin: EdgeInsets.only(left: 5, right: 5),
              ));
            });
            return Container(
              child: Wrap(
                children: list,
              ),
              color: Colors.transparent,
            );
          } else if (snapshot.hasError)
            return Text(snapshot.error);
          else
            return CircularProgressIndicator();
        });
  }
}
