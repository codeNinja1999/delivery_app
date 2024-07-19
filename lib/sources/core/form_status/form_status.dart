
abstract class FormStatus {}

class InitialStatus extends FormStatus {}

class InProgress extends FormStatus {}

class Success extends FormStatus {}

class SubmissionFailure extends FormStatus {
  final Exception error;
  SubmissionFailure(this.error);
}
