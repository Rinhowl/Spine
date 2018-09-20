class SuperSpineboy extends ApplicationAdapter {
  
   Vector2 temp = new Vector2();

  View view;
  Model model;

  public void create () {
    model = new Model(this);
    view = new View(model);
  }

  public void render () {
    float delta = Math.min(Gdx.graphics.getDeltaTime(), 1 / 30f) * model.getTimeScale();
    if (delta > 0) {
      model.update(delta);
      view.update(delta);
    }
    view.render();
  }

  public void resize (int width, int height) {
    view.resize(width, height);
  }

  void restart () {
    model.restart();
    view.restart();
  }

  void eventHitPlayer (Enemy enemy) {
    SoundEffect.hurtPlayer.play();
    if (view.player.hp > 0 && view.player.view.hitAnimation != null)
      view.player.view.animationState.setAnimation(1, view.player.view.hitAnimation, false);
  }

  void eventHitEnemy (Enemy enemy) {
    SoundEffect.hurtAlien.play();
    if (enemy.view.hitAnimation != null) enemy.view.animationState.setAnimation(1, enemy.view.hitAnimation, false);
  }

  void eventHitBullet (float x, float y, float vx, float vy) {
    Vector2 offset = temp.set(vx, vy).nor().scl(15 * Model.scale);
    view.hits.add(View.bulletHitTime);
    view.hits.add(x + offset.x);
    view.hits.add(y + offset.y);
    view.hits.add(temp.angle() + 90);
    SoundEffect.hit.play();
  }

  void eventGameOver (boolean win) {
    if (!view.ui.splashTable.hasParent()) {
      view.ui.showSplash(view.assets.gameOverRegion, win ? view.assets.youWinRegion : view.assets.youLoseRegion);
      view.ui.inputTimer = win ? 5 : 1;
    }
    view.jumpPressed = false;
    view.leftPressed = false;
    view.rightPressed = false;
  }
}
