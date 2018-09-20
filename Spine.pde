

void setup() {
  LwjglApplicationConfiguration config = new LwjglApplicationConfiguration();
  System.setProperty("org.lwjgl.opengl.Display.allowSoftwareOpenGL", "true");
  config.title = "Super Spineboy";
  config.useGL30 = false;
  config.width = 800;
  config.height = 450;
  new LwjglApplication(new SuperSpineboy(), config);
}

void draw() {
}
