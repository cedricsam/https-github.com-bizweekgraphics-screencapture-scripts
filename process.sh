N=0
PASTSUM=""
for i in `ls screen-*`
do SUM=`md5 -q $i`
if [ "${SUM}" != "${PASTSUM}" ]
then echo $i
nn=`printf %04d $N`
convert $i +repage frame-${nn}.tmp.png
convert frame-${nn}.tmp.png -flatten frame-${nn}.tmp1.png
identify frame-${nn}.tmp1.png
convert frame-${nn}.tmp1.png -bordercolor white -border 14 frame-${nn}.png
rm frame-${nn}.tmp*.png
let N=$N+1
PASTSUM=$SUM
fi
done

ffmpeg -f image2 -i frame-%04d.png -vframes 1000 -pix_fmt yuv420p -r 10 frames_10fps.mp4
