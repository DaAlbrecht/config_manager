## Setup

use yadm to clone this repo

```bash
mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x ~/.local/bin/yadm
~/.local/bin/yadm clone  https://github.com/DaAlbrecht/config_manager.git
~/.local/bin/yadm restore --staged $HOME
~/.local/bin/yadm checkout -- $HOME
rm -rf ~/.local/bin/yadm
```
