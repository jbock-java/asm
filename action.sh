#!/bin/bash
#
# see .github/workflows/make.yml

die() {
  echo "ERROR: $@"
  exit 1
}

cd print_int

make print_int || die "make print_int"
make write || die "make write"
make strcmp || die "make strcmp"
make check || die "make check"
make check_write || die "make check_write"
make check_strcmp || die "make check_strcmp"
