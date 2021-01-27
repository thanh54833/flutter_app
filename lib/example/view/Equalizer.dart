import 'dart:async';

import 'package:equalizer/equalizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'package:flutter_app/example/view/bass_boost.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

void main() => runApp(EqualizerWidget());

class EqualizerWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<EqualizerWidget> {
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
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          //color: Colors.grey.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
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
          padding: EdgeInsets.zero,
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
  Future<List<String>> fetchPresets;
  var itemSelected = 0;
  ValueNotifier<String> _selectedValue = ValueNotifier('');
  double min, max;

  //SlideBan slideBan;

  @override
  void initState() {
    super.initState();
    fetchPresets = Equalizer.getPresetNames();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
  }

  @override
  Widget build(BuildContext context) {
    // slideBan = SlideBan(
    //   enabled: widget.enabled,
    //   bandLevelRange: widget.bandLevelRange,
    // );
    "itemSelected :... ${itemSelected} ".Log();
    int bandId = 0;
    return Column(
      children: [
        // ValueListenableBuilder(
        //   valueListenable: _selectedValue,
        //   builder: (context, value, child) {
        FutureBuilder<List<int>>(
          future: Equalizer.getCenterBandFreqs(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.done) && true
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data
                          .map((freq) => _buildSliderBand(freq, bandId++))
                          .toList(),
                    ),
                    height: 200,
                  )
                : Container(
                    child: Container(
                      child: Center(
                          //child: CircularProgressIndicator(),
                          ),
                      height: 40,
                      width: 40,
                    ),
                    height: 200,
                  );
          },
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: _buildPresets(),
        ),
      ],
    );
  }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
        future: fetchPresets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final presets = snapshot.data;
            if (presets.isEmpty) return Text('No presets available!');

            List<Widget> list = [];
            List<ValueNotifier<bool>> listNotifier =
                List.generate(presets.length, (index) => ValueNotifier(false));
            listNotifier[itemSelected].value = true;

            presets.asMap().forEach((index, item) {
              list.add(ValueListenableBuilder(
                valueListenable: listNotifier[index],
                builder: (context, value, child) {
                  return Container(
                    child: ChoiceChip(
                      label: Text(
                        item,
                        style: TextStyle(
                            fontFamily: 'GafataRegular',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: (listNotifier[index].value)
                                ? LocalColor.Primary
                                : Colors.grey),
                      ),
                      selected: listNotifier[index].value,
                      //itemSelected == index,
                      onSelected: (value) {
                        //"onSelected :.. ${item} ".Log();
                        Equalizer.setPreset(item);
                        //slideBan.setPreset(item);
                        setState(() {});
                        _selectedValue.value = item;
                        listNotifier[index].value = true;
                        listNotifier[itemSelected].value = false;
                        itemSelected = index;
                      },
                      selectedColor: LocalColor.Primary_20,
                      //disabledColor: Colors.grey.withOpacity(20),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    margin: EdgeInsets.only(left: 5, right: 5),
                  );
                },
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

  Widget _buildSliderBand(int freq, int bandId) {
    return Column(
      children: [
        SizedBox(
          height: 180.0,
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
}

class SlideBan extends StatefulWidget {
  final bool enabled;
  final List<int> bandLevelRange;
  Function(String value) setPreset;

  SlideBan({this.enabled, this.bandLevelRange});

  createState() => StateSlideBan();
}

class StateSlideBan extends State<SlideBan> {
  int bandId = 0;
  double min, max;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
  }

  build(BuildContext context) {
    widget.setPreset = (value) {
      " widget.setPreset :.. ${value} ".Log();
      Equalizer.setPreset(value);
      setState(() {});
    };

    return FutureBuilder<List<int>>(
      future: Equalizer.getBandLevelRange(),
      builder: (context, snapshot) {
        return Container();
      },
    );
  }
}
