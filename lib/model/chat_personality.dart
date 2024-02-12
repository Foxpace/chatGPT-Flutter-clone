enum ChatPersonality {
  user,
  ai;

  bool get isUser => switch(this) {
    ChatPersonality.user => true,
    ChatPersonality.ai => false,
  };

}