class Player extends Character {
  static float heightSource = 625, width = 67 * scale, height = 285 * scale;
  static float hpStart = 4, hpDuration = 15;

  static float maxVelocityGroundX = 12.5f, maxVelocityAirX = 13.5f;
  static float playerJumpVelocity = 22f, jumpDamping = 0.5f, jumpOffsetVelocity = 10, jumpOffsetY = 120 * scale;
  static float airJumpTime = 0.1f;

  static float shootDelay = 0.1f, shootOffsetX = 160, shootOffsetY = 11;
  static float bulletSpeed = 34, bulletInheritVelocity = 0.4f, burstDuration = 0.18f;
  static float kickbackShots = 33, kickbackAngle = 30, kickbackVarianceShots = 11, kickbackVariance = 6, kickback = 1.6f;

  static float knockbackX = 14, knockbackY = 5, collisionDelay = 2.5f, flashTime = 0.07f;
  static float headBounceX = 12, headBounceY = 20;

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
