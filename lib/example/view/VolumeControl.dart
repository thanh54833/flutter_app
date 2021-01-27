import 'package:flutter/material.dart';
import 'package:flutter_app/example/main/app/LocalColor.dart';
import 'dart:async';
import 'package:volume/volume.dart';
import 'package:flutter_app/example/main/common/LogCatUtils.dart';

void main() => runApp(VolumeControl());

class VolumeControl extends StatefulWidget {
  createState() => _VolumeControl();
}

class _VolumeControl extends State<VolumeControl> {
  AudioManager audioManager;
  int maxVol;
  ValueNotifier<int> currentVol = ValueNotifier(0);
  ShowVolumeUI showVolumeUI = ShowVolumeUI.SHOW;

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_SYSTEM;
    initAudioStreamType();
    updateVolumes();
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol.value = await Volume.getVol;
    setState(() {});
    audioManager = DropdownMenuItem(
      child: Text("Media Volume"),
      value: AudioManager.STREAM_MUSIC,
    ).value;
    await Volume.controlVolume(audioManager);
    //Todo : thanh show ui ...
    showVolumeUI = ShowVolumeUI.HIDE;
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: showVolumeUI);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 30,
          color: Colors.white.withOpacity(0.7),
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_rounded,
                        size: 20,
                        color: LocalColor.Dark,
                      ),
                      onPressed: () {
                        //"onclick remove_rounded :... ".Log();
                        if (currentVol.value > 0) {
                          currentVol.value -= 1;
                          setVol(currentVol.value);
                          updateVolumes();
                        }
                      },
                      padding: EdgeInsets.zero,
                    ),
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                  ),
                ),
                height: 25,
                width: 25,
                margin: EdgeInsets.only(left: 2),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ValueListenableBuilder(
                      valueListenable: currentVol,
                      builder: (context, value, child) {
                        return Container(
                          child: LinearProgressIndicator(
                            value: value / maxVol,
                            minHeight: 20,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                LocalColor.Primary),
                            backgroundColor: LocalColor.Primary_20,
                          ),
                          //alignment: Alignment.center,
                          height: 5,
                        );
                      },
                    ),
                  ),
                  margin: EdgeInsets.only(left: 5, right: 5),
                ),
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: LocalColor.Dark,
                      ),
                      onPressed: () {
                        "onPressed add :. ".Log();
                        if (currentVol.value < maxVol) {
                          currentVol.value += 1;
                          setVol(currentVol.value);
                          updateVolumes();
                        }
                      },
                      padding: EdgeInsets.zero,
                    ),
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                ),
                height: 25,
                width: 25,
                margin: EdgeInsets.only(right: 2),
              ),
            ],
          ),
        ),
      ),
      margin: EdgeInsets.all(5),
    );
  }
}
