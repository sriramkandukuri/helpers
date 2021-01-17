# rename all directories and files by replacing spaces with underscores
rename ()
{
	for i in *
	do
	   tgt=${i//[ -()]/_}
	   mv "$i" "$tgt"
	   echo "$tgt"

	   if [ -d "$tgt" ]
	   then
		   pushd $tgt
		   rename $tgt
		   popd
	   fi
	done
}

#rename

# Sort all files and number them to play where file names doesnt appear
cd <files dir>
count=1
for i in $(find * -type f|sort -z)
do
   tgt1=""
   tgt=""
   tgt1=$(echo "$i" | sed 's/\//_/g')
   tgt=$(printf "%04d_%s" $count "$tgt1")
   echo "$tgt"
   mv "$i" ../<files dir>/"$tgt"
   count=$((count+1))
done

cd <files dir>
# Helper for renumbering after deletion
for i in $(find * -type f|sort -z)
do
	tgt1=""
	tgt=""
	# First enable below command
	#tgt1=$(echo "$i" | cut -d"_" -f2-)
	tgt1=$(echo "$i")
	# Next enable below command to rename with new numbers.
	tgt=$(printf "%04d_%s" $count "$tgt1")
	#tgt=$(printf "%s" "$tgt1")
	echo "$tgt"
	mv "$i" ../<files dir>/"$tgt"
	count=$((count+1))
done
