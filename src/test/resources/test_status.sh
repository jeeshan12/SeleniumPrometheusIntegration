#!/usr/bin/bash

TEST_RESULTS_REPORT=$1
echo "Output Repository is $TEST_RESULTS_REPORT"
#<testng-results ignored="0" total="2" passed="2" failed="0" skipped="0">
TEST_REPORT=$(cat "$TEST_RESULTS_REPORT" | grep "<testng-results")
#awk  '{ print $0 }' "$TEST_RESULTS_REPORT"
SUITE=$(awk '/suite/ { print $0 }' "$TEST_RESULTS_REPORT")
#<suite started-at="2023-05-10T16:39:44 CEST" name="Suite1" finished-at="2023-05-10T16:39:50 CEST" duration-ms="5212"> </suite> <!-- Suite1 -->


cat << EOF | curl --data-binary @- http://${PUSHGATEWAY_IP}:9091/metrics/job/results
selenium_ignored_tests{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $2 }')
selenium_total_tests{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $4 }')
selenium_total_tests_passed{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $6 }')
selenium_total_tests_failed{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $8 }')
selenium_total_tests_skipped{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${TEST_REPORT} | awk -F'"' '{ print $10 }')
selenium_suite_execution_duration{action_id="${GITHUB_RUN_NUMBER}", author="${GITHUB_ACTOR}", os="${RUNNER_OS}"} $(echo ${SUITE} | awk -F'"' '{ print $8 }')
EOF


#cat << EOF | curl --data-binary @- http://${PUSHGATEWAY_IP}/metrics/job /test_job
#failedTests{author="jeeshan"} 10
#passedTests{author="jeeshan"} 33 
#EOF
