# Elixir ASCII Image

A small Elixir script to convert an image to ASCII characters and print to the command line. Just a quick project for me to learn some Elixir basics, following Robert Heaton's [Programming Projects for Advanced Beginners #1: ASCII art](https://robertheaton.com/2018/06/12/programming-projects-for-advanced-beginners-ascii-art/).

![elixir logo](http://oi63.tinypic.com/2n3620.jpg) => ![elixir logo ascii-fied](http://oi63.tinypic.com/dgnfip.jpg)

## Requirements

- [Elixir](https://elixir-lang.org/) ~> 1.7
- [ImageMagick](https://www.imagemagick.org/) ~> 7.0

## Installation

Clone this repo to a suitable location and install dependencies with `mix deps.get`.

## Usage

Run the script with:

```bash
mix asciify path/to/image.jpg
```

The specified image will be converted to ASCII characters and printed to the console. The image will be resized, but you'll still probably need to zoom out your console quite a lot to fit the whole image in (usually `Cmd+-` or `Ctrl+-`).
