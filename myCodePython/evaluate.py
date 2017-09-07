import numpy as np

def evaluate(pred, actual):
	score=0
	for artist,playlist in pred.items():
		pred_play=np.asarray(playlist)
		act_play=np.asarray(actual[artist])
		w=np.sqrt(sum(act_play))
		print("w="+str(w))
		delta=np.sqrt(np.mean(((pred_play-act_play)/act_play)**2))
		print('delta='+str(delta))
		score+=(1-delta)*w
	return score

def main():
	actual={"a":[1,2,4,5],"b":[1,2,4,5],"c":[1,2,4,5]}
	pred={"a":[1.1,2.2,4.4,5.5],"b":[1.1,2.2,4.4,5.5],"c":[1.1,2.2,4.4,5.5]}
	print(evaluate(pred,actual))

if __name__ == '__main__':
	main()