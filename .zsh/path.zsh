# Make path unique
typeset -U path

# Add current directory's bin and vendor/bundle/bin directories to path safely
path=(.git/safe/../../vendor/bundle/bin "$path[@]")
path=(.git/safe/../../.bundle/bundle/bin "$path[@]")
path=(.git/safe/../../bin "$path[@]")
path=(~/bin "$path[@]")

# Add ~ and ~/Code to cdpath
cdpath=(~ ~/Code)
