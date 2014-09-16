import SimpleOpenNI.*;
import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiChannel;
import javax.sound.midi.Synthesizer;

int numberSegments = 30;
int lineSpace = 10;
Synthesizer synth;

int numberLines = 25;
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

  size(800, 800);
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
