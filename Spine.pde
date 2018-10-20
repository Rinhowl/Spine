import com.badlogic.gdx.graphics.GL20;

/**
 * 简单的演示如何加载Spine格式的2D骨骼文件
 * <BR>
 * 
 * @author Rinhowl
 * @since zhong.linhao@2018年10月20日 
 * @version 1.0.0
 *
 */
 


//系统全路径
String system_path;
String ATLAS = "spineboy/spineboy-pma.atlas";//图集位置(相对于项目)
String SKELETON = "spineboy/spineboy-ess.json";//json格式的骨骼数据位置

SpriteBatch batch;
SkeletonRenderer renderer;
TextureAtlas atlas;
Skeleton skeleton;
AnimationState animationState;

void setup() {
  system_path = sketchPath() + "/";
  new LwjglApplication(new SimpleSpine());
}

void draw() {
}

/**
 * 简单的演示如何加载Spine格式的2d骨骼文件
 */
class SimpleSpine extends ApplicationAdapter {
  
  @Override
  public void create() {
    batch = new SpriteBatch();
    renderer = new SkeletonRenderer();
    // 1.加载纹理图集
    atlas = new TextureAtlas(Gdx.files.internal(system_path + ATLAS));
    
    // 2.读取json数据
    SkeletonJson json = new SkeletonJson(atlas);// 根据altas创建一个骨架Json对象，方便构建骨架对象和图集对象之间的连接
    json.setScale(0.6f);// 缩放，设置后不可更改
    // SkeletonData就相当于.json文件中的骨架数据
    SkeletonData skeletonData = json.readSkeletonData(Gdx.files.internal(system_path + SKELETON));// 读取骨架数据
    
    // 3.初始化骨骼对象
    skeleton = new Skeleton(skeletonData);
    
    // 4.设置骨架初始位置
    skeleton.setPosition(200, 40);
    
    // 5.从骨架数据中读取动画数据，AnimationStateData就相当于.json文件中的animation数据
    AnimationStateData animationStateData = new AnimationStateData(skeletonData);
    
    // 6.创建动画
    animationState = new AnimationState(animationStateData);
    
    // 7.设置播放的动画
    animationState.setAnimation(0, "run", true);
  }

  /**
   * 渲染
   */
  @Override
  public void render() {
    // 1.清屏
    Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
    // 2.将骨架应用到当前动画
    animationState.apply(skeleton);
    // 3.骨骼逐级进行矩阵变换
    skeleton.updateWorldTransform();
    // 4.渲染骨骼动画
    batch.begin();
    renderer.draw(batch, skeleton); // 渲染骨骼动画
    batch.end();
    // 5.更新动画时间
    animationState.update(Gdx.graphics.getDeltaTime());
  }
}
