#!/usr/bin/env bash

nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
