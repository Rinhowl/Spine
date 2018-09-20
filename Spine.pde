

void setup() {
  LwjglApplicationConfiguration config = new LwjglApplicationConfiguration();
  config.title = "Super Spineboy";
  config.width = 800;
  config.height = 450;
  new LwjglApplication(new SuperSpineboy(), config);
}

void draw() {
}
