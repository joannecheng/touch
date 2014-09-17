import SimpleOpenNI.*;
import javax.sound.midi.MidiSystem;
import javax.sound.midi.MidiChannel;
import javax.sound.midi.Synthesizer;

Synthesizer synth;

float yoff = 0.0;

SimpleOpenNI context;
LinesCollection l;

void setup() {
  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.enableUser();
  context.setMirror(true);

  try {
    synth = MidiSystem.getSynthesizer();
    synth.open();
  } catch (Exception e) {
    e.printStackTrace();
    exit();
  }

  size(640, 480);
  background(0);
  stroke(255, 150);
  smooth();

  l = new LinesCollection(25);
}

void draw() {
  background(0);
  context.update();
  image(context.userImage(),0,0);

  l.render();

  int[] userList = context.getUsers();

  for(int i=0;i<userList.length;i++) {
    if(context.isTrackingSkeleton(userList[i])) {
      drawSkeleton(userList[i]);
    }
  }
}

void drawSkeleton(int userId) {
  //saveFrame();
  stroke(255, 100, 0);
  strokeWeight(3);
  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  //context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  //context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  //context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  //context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  PVector rightHandPos = new PVector();
  PVector jointPos = new PVector();

  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, jointPos);
  context.convertRealWorldToProjective(jointPos, rightHandPos);

  l.updateMousePos(rightHandPos.x, rightHandPos.y);
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  context.startTrackingSkeleton(userId);
}
