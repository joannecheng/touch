class Note {
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
