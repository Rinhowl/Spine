 class StateView {
    Animation animation;
    boolean loop;
    // Controls the start frame when changing from another animation to this animation.
    ObjectFloatMap<Animation> startTimes = new ObjectFloatMap();
    float defaultStartTime;
  }
