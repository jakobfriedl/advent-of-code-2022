# Advent of Code tiles

This script was created by [LiquidFun/adventofcode](https://github.com/LiquidFun/adventofcode). It was adapted to match the existing project structure.

### Requirements

Install at least Python 3.10 (because of the new typing union `|`, if you cannot do so you can
change the `type1 | type2` annotations to `Union[type1, type2]`).

Install the requirements (`pillow` for creating images, `requests` for the leaderboard data and `pyyaml` to parse the language config):

```
pip install -r requirements.txt
```

### Configuration

To use this script, you need to have a file with the AOC-Session-Cookie in the same folder as this script.
It should contain a single line, the "session" cookie
when logged in to https://adventofcode.com. Just
paste it in there.

Now add `<!-- AOC TILES BEGIN -->` and  `<!-- AOC TILES END -->` in your README, everything between these 2 tags
will always be replaced by the script, so do not add additional information there. Note that these are HTML comments, 
so they will not be visible in the rendered README.

Your year/day script structure likely looks different. You can change the patterns for years and days in the 
[create_aoc_tiles.py](create_aoc_tiles.py) file.

The variables at the top of the script have comments to explain what they do.

To try whether it works you can run the script directly:

```
python3 create_aoc_tiles.py
```

### Pre-commit hook

Add [.pre-commit-config.yaml](/.pre-commit-config.yaml) to your repository and run `pre-commit install` to install the hook.