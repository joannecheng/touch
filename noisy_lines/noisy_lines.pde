import SimpleOpenNI.*;
import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiChannel;
import javax.sound.midi.Synthesizer;

int numberSegments = 30;
int lineSpace = 10;
Synthesizer synth;

int numberLines = 20;
ArrayList<Line> lines = new ArrayList<Line>();
float yoff = 0.0;

SimpleOpenNI context;

void setup() {
  try {
    synth = MidiSystem.getSynthesizer();
    synth.open();
  } catch (Exception e) {
    e.printStackTrace();
    exit();
  }

  size(1280, 500);
  background(0);
  stroke(255, 150);
  strokeWeight(2);
  smooth();

  for(int i=0; i<numberLines; i++) {
    lines.add(new Line(i));
  }
}

void draw() {
  background(0);

  int i = 0;
  for(Line l: lines) {
    l.render();
  }

  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 10, 10);
}

class Oscillation {
}

class Note extends Thread {
  int duration = 200;
  int channel = 12;
  int volume = 40;
  int note = 80;
  MidiChannel[] channels;

  Note(int n) {
    note = n;
    channels = synth.getChannels();
  }

  void play() {
      try {
        channels[channel].noteOn(note, volume );
      } catch (Exception e) {
        e.printStackTrace();
      }
  }
}
