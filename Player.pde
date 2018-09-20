class Player extends Character {
  static final float scale = 1 / 64f;
  static final float heightSource = 625, width = 67 * scale, height = 285 * scale;
  static final float hpStart = 4, hpDuration = 15;

  static final float maxVelocityGroundX = 12.5f, maxVelocityAirX = 13.5f;
  static final float playerJumpVelocity = 22f, jumpDamping = 0.5f, jumpOffsetVelocity = 10, jumpOffsetY = 120 * scale;
  static final float airJumpTime = 0.1f;

  static final float knockbackX = 14, knockbackY = 5, collisionDelay = 2.5f, flashTime = 0.07f;
  static final float headBounceX = 12, headBounceY = 20;





  float shootTimer;
  float collisionTimer;
  float hpTimer;

  // This is here for convenience, the model should never touch the view.
  PlayerView view;

  Player (Model model) {
    super(model);
    rect.width = width;
    rect.height = height;
    hp = hpStart;
    jumpVelocity = playerJumpVelocity;
  }

  void update (float delta) {
    stateChanged = false;

    shootTimer -= delta;

    if (hp > 0) {
      hpTimer -= delta;
      if (hpTimer < 0) {
        hpTimer = hpDuration;
        if (hp < hpStart) hp++;
      }
    }

    collisionTimer -= delta;
    rect.height = height - collisionOffsetY;
    maxVelocityX = isGrounded() ? maxVelocityGroundX : maxVelocityAirX;
    super.update(delta);
  }
}
