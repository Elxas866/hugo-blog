:'
___________.__                          ______   ________ ________
\_   _____/|  | ___  ________    ______/  __  \ /  _____//  _____/
 |    __)_ |  | \  \/  /\__  \  /  ___/>      </   __  \/   __  \ 
 |        \|  |__>    <  / __ \_\___ \/   --   \  |__\  \  |__\  \
/_______  /|____/__/\_ \(____  /____  >______  /\_____  /\_____  /
        \/            \/     \/     \/       \/       \/       \/ 
-------------------------------------------------------------------
-------------------------------------------------------------------
'
#!/bin/bash

# rsync files
rsync -av --delete ~/personal-notes/posts/ ~/blog/content/posts/

# copy images to assets
cp -r ~/personal-notes/posts/images/ ~/blog/static/assets/images

# build site
hugo -t terminal

# git stuff
git add .
git commit -m "$1"
git push origin master
