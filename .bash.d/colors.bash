red=$'\e[0;31m'
green=$'\e[0;32m'
yellow=$'\e[0;33m'
blue=$'\e[0;34m'
magenta=$'\e[0;35m'
cyan=$'\e[0;36m'
white=$'\e[m'
grey='\e[0;37m'

redB=$'\e[1;31m'
greenB=$'\e[1;32m'
yellowB=$'\e[1;33m'
blueB=$'\e[1;34m'
magentaB=$'\e[1;35m'
cyanB=$'\e[1;36m'
whiteB=$'\e[1m'
greyB='\e[0;37m'

function color()
{
    sed s/"\($2\)"/$(eval echo -n \$$1)'\1'$'\e[m'/g
}
