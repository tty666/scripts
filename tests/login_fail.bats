#!/usr/bin/env bats

setup() {
  test_tmp="${BATS_TEST_TMPDIR:-$BATS_TMPDIR}"
  export PATH="$test_tmp/bin:$PATH"
  mkdir -p "$test_tmp/bin"

  cat <<'LASTB' > "$test_tmp/bin/lastb"
#!/bin/bash
echo "hackende pts/0 0.0.0.0 x $(date +%d)"
echo "hackende pts/1 0.0.0.0 x $(date +%d)"
echo "hackende pts/2 0.0.0.0 x $(date +%d)"
LASTB
  chmod +x "$test_tmp/bin/lastb"

  cat <<MUTT > "$test_tmp/bin/mutt"
#!/bin/bash
cat - > "$test_tmp/alert.log"
MUTT
  chmod +x "$test_tmp/bin/mutt"

  for cmd in tar cp; do
    cat <<'CMD' > "$test_tmp/bin/$cmd"
#!/bin/bash
exit 0
CMD
    chmod +x "$test_tmp/bin/$cmd"
  done
}

teardown() {
  test_tmp="${BATS_TEST_TMPDIR:-$BATS_TMPDIR}"
  rm -f /tmp/loginfailshackende.txt /tmp/cantfailhackende.txt /tmp/cantfail* "$test_tmp/alert.log"
}

@test "generates alert after threshold exceeded" {
  run bash login_hackendefail.sh
  [ "$status" -eq 0 ]
  test_tmp="${BATS_TEST_TMPDIR:-$BATS_TMPDIR}"
  [ -f "$test_tmp/alert.log" ]
  grep -q "Alguien esta intentando entrar demaciadas veces como hackendemoniado" "$test_tmp/alert.log"
}
