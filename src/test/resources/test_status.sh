#!/usr/bin/bash

TEST_RESULTS_REPORT=$1
echo "Output Repository is $TEST_RESULTS_REPORT"
#<testng-results ignored="0" total="2" passed="2" failed="0" skipped="0">
TEST_REPORT=$(cat "$TEST_RESULTS_REPORT" | grep "<testng-results")
#awk  '{ print $0 }' "$TEST_RESULTS_REPORT"
SUITE=$(awk '/suite/ { print $0 }' "$TEST_RESULTS_REPORT")
#<suite started-at="2023-05-10T16:39:44 CEST" name="Suite1" finished-at="2023-05-10T16:39:50 CEST" duration-ms="5212"> </suite> <!-- Suite1 -->


cat << EOF | curl --data-binary @- http://${PUSHGATEWAY_IP}:9091/metrics/job/selenium_job
github_actions_ignored_tests{action_id="${GITHUB_RUN_NUMBER}", commit="${GITHUB_SHA}", actor="${GITHUB_ACTOR}", branch="${GITHUB_REF}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $2 }')
#selenium_ignored_tests{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $2 }')
#selenium_total_tests{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $4 }')
#selenium_total_tests_passed{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $6 }')
#selenium_total_tests_failed{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $8 }')
#selenium_total_tests_skipped{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $10 }')
#selenium_suite_execution_duration{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${SUITE} | awk -F'"' '{ print $10 }')
EOF


#cat << EOF | curl --data-binary @- http://localhost:9091/metrics/job /my_job/instance/my_instance
#temperature{location="room1"} 31
#temperature{location="room2"} 33 # TYPE my_metric gauge
#EOF
