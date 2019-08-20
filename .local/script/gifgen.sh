#!/bin/sh

#
# Script taken from https://github.com/lukechilds/gifgen
#
# MIT License
# 
# Copyright (c) 2016 Luke Childs
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Echo help/usage message
show_help() {
  echo "gifgen 1.1.2"
  echo
  echo "Usage: gifgen [options] [input]"
  echo
  echo "Options:"
  echo "  -o   Output file [input.gif]"
  echo "  -f   Frames per second [10]"
  echo "  -s   Optimize for static background"
  echo "  -v   Display verbose output from ffmpeg"
  echo
  echo "Examples:"
  echo "  $ gifgen video.mp4"
  echo "  $ gifgen -o demo.gif SCM_1457.mp4"
  echo "  $ gifgen -sf 15 screencap.mov"
}

# Setup defaults
pid=$$
palette="/tmp/gif-palette-$pid.png"
fps="10"
verbosity="warning"
stats_mode="full"
dither="sierra2_4a"

# Parse args
while getopts "ho:f:sv" opt; do
  case "$opt" in
    h)
      show_help="true"
      ;;
    o)
      output=$OPTARG
      ;;
    f)
      fps=$OPTARG
      ;;
    s)
      stats_mode="diff"
      dither="none"
      ;;
    v)
      verbosity="info"
      ;;
    *)
      echo "Invalid flag"
      exit 1
      ;;
  esac
done
shift "$((OPTIND-1))"
# Grab input file from end of command
input=$1

# Show help and exit if we have no input
[ "$input" = "" ] || [ $show_help = "true" ] && show_help && exit

# Check for ffmpeg before encoding
type ffmpeg >/dev/null 2>&1 || {
  echo "Error: gifgen requires ffmpeg to be installed"
  exit 1
}

# Set output if not specified
if [ "$output" = "" ]; then
  input_filename=${input##*/}
  output=${input_filename%.*}.gif
fi

# Encode GIF
echo "Generating palette..."
ffmpeg -v "$verbosity" -i "$input" -vf "fps=$fps,palettegen=stats_mode=$stats_mode" -y "$palette"
[ "$verbosity" = "info" ] && echo
echo "Encoding GIF..."
ffmpeg -v "$verbosity" -i "$input" -i "$palette" -lavfi "fps=$fps [x]; [x][1:v] paletteuse=dither=$dither" -y "$output"
echo "Done!"