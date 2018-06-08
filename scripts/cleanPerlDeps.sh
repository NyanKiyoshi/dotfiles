emerge -C virtual/perl* 	&&
emerge -C perl-core/*   	&&
emerge -C perl			&&
emerge dev-lang/perl		&&
perl-cleaner --modules		&&
perl-cleaner --allmodules	&&
perl-cleaner --libperl		&&
perl-cleaner --ph-clean		&&
perl-cleaner --ph-clean

echo -n "Update? [y/n] "
read -n 1 ans
if [ "$ans" = "y" ]; then
	emerge -uDU --with-bdeps=y --backtrack=300 @world &&
	emerge -uDU --with-bdeps=y @world
fi

