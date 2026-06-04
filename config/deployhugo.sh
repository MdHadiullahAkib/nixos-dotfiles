#!/etc/profiles/per-user/akib/bin/bash

echo "Changing Directory"

cd ~/HugoSites/cyberfolio

echo "Clearing public directory"

rm -r public/*

echo "building site"

hugo

git add .

read -p 'Enter commit name: ' commit

git commit -m "$commit"

echo "pushing to remote repo"

git push -u origin main

echo "spliting public directory"

git subtree split --prefix public -b site-deploy

git push origin site-deploy:deploy --force

git branch -D site-deploy

echo "Deployed succesfully"
