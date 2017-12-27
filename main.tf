resource "aws_cloudwatch_event_rule" "default" {
  name                = "${var.name}"
  schedule_expression = "${var.schedule}"
}

resource "aws_cloudwatch_event_target" "default" {
  arn       = "${var.queue_arn}"
  rule      = "${aws_cloudwatch_event_rule.default.name}"
  target_id = "${var.name}"
}

module "queue_policy" {
  source = "../sqs_queue_policy"

  condition_values = ["${aws_cloudwatch_event_rule.default.arn}"]
  queue_url        = "${var.queue_url}"
  resources        = ["${var.queue_arn}"]
}
