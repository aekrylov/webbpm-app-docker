#!/usr/bin/env bash

expect <<EOD
    spawn npm adduser --registry ${NPM_REGISTRY}
    expect {
    "Username:" {send "${NPM_USER}\r"; exp_continue}
    "Password:" {send "${NPM_PASSWORD}\r"; exp_continue}
    "Email: (this IS public)" {send "${NPM_EMAIL}\r"; exp_continue}
    }
EOD