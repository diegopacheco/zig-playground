#!/bin/bash

zig build -Dtarget=x86_64-windows -Doptimize=ReleaseSmall --summary all
