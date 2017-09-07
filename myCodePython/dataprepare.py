fileIn=file('/home/lihui/ali/all_artist_feature.csv')
fileOut=file('artist_feature.txt','w')
temp_dict={}
artist_feature=[]
preArtist='xxxx'
fileIn.readline()
while True:
	line=fileIn.readline()
	if len(line)==0:
		temp_dict[preArtist]=artist_feature
		fileOut.write(str(temp_dict))
		break
	field=line.split(",")
	artist_id=field[0]
	if preArtist=='xxxx':
		preArtist=artist_id
	temp_feature=[]
	for feat in field[2:6]:
		temp_feature.append(int(feat))
	if artist_id==preArtist:
		artist_feature.append(temp_feature)
	else:
		temp_dict[preArtist]=artist_feature
		artist_feature=[]
		preArtist=artist_id
		artist_feature.append(temp_feature)
fileIn.close()
fileOut.close()

