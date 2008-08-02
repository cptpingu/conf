# not started :p, should find the include itself depending on -I flags
function read_include()
{
    gcc -E "$@" | vim -
}
