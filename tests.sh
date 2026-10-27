#!/bin/bash
<<<<<<< HEAD
FAILED=0

pwd

test_case() {
    output=$(./DO "$1" 2>&1)
    if [ "$output" = "$2" ]; then
        echo "PASS: $1"
    else
        echo "$1 (expected '$2', got '$output')"
        FAILED=1
    fi
}

test_case "1" "Learning to Linux"
test_case "2" "Learning to work with Network"
test_case "3" "Learning to Monitoring"
test_case "4" "Learning to extra Monitoring"
test_case "5" "Learning to Docker"
test_case "6" "Learning to CI/CD"
test_case "7" "Bad number!"
test_case "0" "Bad number!"
test_case "-1" "Bad number!"
test_case "abc" "Bad number!"

output=$(./DO 2>&1)

if [ "$output" = "Bad number of arguments!" ]; then
    echo "PASS: no arg"
else
    echo "FAIL: no arg (expected 'Bad number of arguments!', got '$output')"
    FAILED=1
fi

exit $FAILED
=======
set -u
BIN="./DO"
FAIL=0

check_case() {
    local arg="$1" expected_out="$2" expected_code="$3"
    local output code

    output=$("$BIN" "$arg"); code=$?

    if [[ "$output" != "$expected_out" ]]; then
        fail "case '$arg': expected stdout '$expected_out', got '$output'"
        return
    fi
    if [[ "$code" -ne "$expected_code" ]]; then
        fail "case '$arg': expected exit $expected_code, got $code"
        return
    fi
    pass "case '$arg' -> '$output' (exit $code)"
}

# Проверяет произвольное число аргументов (в т.ч. ноль).
check_args() {
    local expected_out="$1" expected_code="$2"
    shift 2
    local output code

    output=$("$BIN" "$@"); code=$?

    if [[ "$output" != "$expected_out" ]]; then
        fail "args [$*]: expected stdout '$expected_out', got '$output'"
        return
    fi
    if [[ "$code" -ne "$expected_code" ]]; then
        fail "args [$*]: expected exit $expected_code, got $code"
        return
    fi
    pass "args [$*] -> '$output' (exit $code)"
}

# Проверяет, что программа не упала по сигналу (код < 128).
check_no_crash() {
    local code
    "$BIN" "$@" >/dev/null 2>&1; code=$?
    if [[ "$code" -ge 128 ]]; then
        fail "args [$*]: program crashed with signal (exit $code)"
    else
        pass "args [$*]: no crash (exit $code)"
    fi
}

# Проверяет, что программа ничего не пишет в stderr.
check_stderr_empty() {
    local err
    err=$("$BIN" "$@" 2>&1 >/dev/null)
    if [[ -n "$err" ]]; then
        fail "args [$*]: unexpected stderr '$err'"
    else
        pass "args [$*]: stderr is empty"
    fi
}

check_case 1 "Learning to Linux" 0
check_case 2 "Learning to work with Network" 0
check_case 3 "Learning to Monitoring" 0
check_case 4 "Learning to extra Monitoring" 0
check_case 5 "Learning to Docker" 0
check_case 6 "Learning to CI/CD" 0

check_args "Bad number of arguments!" 255
check_args "Bad number of arguments!" 255 1 2
check_args "Bad number of arguments!" 255 1 2 3

check_case 0 "Bad number!" 254
check_case 7 "Bad number!" 254
check_case -5 "Bad number!" 254
check_case 100 "Bad number!" 254
check_case abc "Bad number!" 254
check_case "" "Bad number!" 254

check_case "1abc" "Learning to Linux" 0

check_no_crash 99999999999999999999

check_stderr_empty 1
check_stderr_empty 6
check_stderr_empty 7
check_stderr_empty
check_stderr_empty 1 2

echo
if [[ "$FAIL" -ne 0 ]]; then
    echo -e "Some tests FAILED"
    exit 1
fi
echo -e "All tests passed"
exit 0
>>>>>>> bfbc6b536e3350fcdeda63f7dcd5910e161915b8
