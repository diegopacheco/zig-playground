#!/bin/bash

zig build-exe src/math.zig -target wasm32-freestanding --export=add
