import com.esotericsoftware.spine.AnimationState.AnimationStateAdapter;
import com.esotericsoftware.spine.Event;

class EnemyView extends CharacterView {
  Enemy enemy;
  Animation hitAnimation;
  Slot headSlot;
  Attachment burstHeadAttachment;
  Color headColor;

  EnemyView (final View view, Enemy enemy) {
    super(view);
    this.enemy = enemy;

    skeleton = new Skeleton(view.assets.enemySkeletonData);
    burstHeadAttachment = skeleton.getAttachment("head", "burst01");
    headSlot = skeleton.findSlot("head");
    hitAnimation = skeleton.getData().findAnimation("hit");

    animationState = new AnimationState(view.assets.enemyAnimationData);

    // Play squish sound when enemies die.
    final EventData squishEvent = view.assets.enemySkeletonData.findEvent("squish");
    animationState.addListener(new AnimationStateAdapter() {
      public void event (int trackIndex, Event event) {
        if (event.getData() == squishEvent) SoundEffect.squish.play();
      }
    });

    // Enemies have slight color variations.
    if (enemy.type == Type.strong)
      headColor = new Color(1, 0.6f, 1, 1);
    else
      headColor = new Color(MathUtils.random(0.8f, 1), MathUtils.random(0.8f, 1), MathUtils.random(0.8f, 1), 1);
    headSlot.getColor().set(headColor);
  }

  void update (float delta) {
    // Change head attachment for enemies that are about to die.
    if (enemy.hp == 1 && enemy.type != Type.weak) headSlot.setAttachment(burstHeadAttachment);

    // Change color for big enemies.
    if (enemy.type == Type.big) headSlot.getColor().set(headColor).lerp(0, 1, 1, 1, 1 - enemy.bigTimer / Enemy.bigDuration);

    skeleton.setX(enemy.position.x + Enemy.width / 2);
    skeleton.setY(enemy.position.y);

    if (!setAnimation(view.assets.enemyStates.get(enemy.state), enemy.stateChanged)) animationState.update(delta);
    animationState.apply(skeleton);

    Bone root = skeleton.getRootBone();
    root.setScaleX(root.getScaleX() * enemy.size);
    root.setScaleY(root.getScaleY() * enemy.size);

    skeleton.setFlipX(enemy.dir == -1);
    skeleton.updateWorldTransform();
  }
}
