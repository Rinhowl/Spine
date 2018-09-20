 enum SoundEffect {
    shoot, hit, footstep1, footstep2, squish, hurtPlayer, hurtAlien;

    Sound sound;
    float volume = 1;

    void play () {
      sound.play(volume);
    }
  }
