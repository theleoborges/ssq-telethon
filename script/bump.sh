#!/bin/sh
branch=$(git name-rev --name-only HEAD)
commit=$(git rev-parse --short HEAD)
sed -i "s/\(BuildVersion:\).*\(BuildVersionEnd\)/\1 $branch $commit \2/" app/views/layouts/application.html.erb
