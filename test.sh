#!/bin/sh
test $(( $RANDOM * 10 / $(( 2 ** 15 )) )) -ge 5
