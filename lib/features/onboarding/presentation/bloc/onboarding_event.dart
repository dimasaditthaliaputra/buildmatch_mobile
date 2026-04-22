abstract class OnboardingEvent {}
class LoadOnboardingPages extends OnboardingEvent {}
class PageChanged extends OnboardingEvent {
  final int index;
  PageChanged(this.index);
}