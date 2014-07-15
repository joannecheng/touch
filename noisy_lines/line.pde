class Line {
  int numberSegments = 30;
  int lineSpace = 10;
  int index;
  int lineSpacing;
  Note note;

  boolean mouseOverString = false;

  Line(int ind) {
    index = ind;
    lineSpacing = lineSpace*index;
    note = new Note(index*4 + 20);
  }

  void render() {
    yoff += 0.0001;
    float xoff = 0.0;
    float segmentXIncrement = width/numberSegments;

    pushMatrix();
    translate(0, height - lineSpacing);
    noFill();
    beginShape();
    vertex(-10, map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing));

    for (int i=0; i<numberSegments+1;i++) {
      float x = segmentXIncrement * (i+1);
      float y = map(noise(xoff, yoff), 0, 1, -lineSpacing, lineSpacing);

      if (mouseInRange(x, y, segmentXIncrement)) {
        playNote();
        if (pmouseY < mouseY) {
          vertex(x, random(y, y+8));
        }
        else {
          vertex(x, random(y-8, y));
        }
      } else {
        vertex(x, y);
      }

      xoff += 0.01;
    }

    endShape();
    popMatrix();
  }

  void playNote() {
    note.play();
  }

  boolean mouseInRange(float x, float y, float segmentXIncrement) {
    return mouseXInRange(x, segmentXIncrement) && mouseYInRange(y);
  }

  boolean mouseXInRange(float x, float segmentXIncrement) {
    return mouseX < x+segmentXIncrement/2 && mouseX > x-segmentXIncrement/2;
  }

  boolean mouseYInRange(float y) {
    return mouseY < (y + (height - lineSpacing) + 5) && mouseY > (y + (height - lineSpacing) - 5);
  }
}
