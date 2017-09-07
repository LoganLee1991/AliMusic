import numpy as np
import matplotlib.pyplot as pl
from matplotlib.dates import DateFormatter,MonthLocator,WeekdayLocator
from matplotlib.ticker import MultipleLocator
import matplotlib
from datetime import datetime,timedelta



xmajorLocator=MonthLocator()
xminorLocator=WeekdayLocator()
def datePlot(artist_id,act_data,pred_data,cut):
	firstdate=datetime.strptime('20150301',"%Y%m%d")
	term=len(act_data)

	dates=[firstdate+timedelta(days=i) for i in np.arange(term)]
	list_of_dates=matplotlib.dates.date2num(dates)

	act_line,=pl.plot_date(list_of_dates,act_data,'r')
	pred_line,=pl.plot_date(list_of_dates,pred_data,'g')

	pl.axvline(x=firstdate+timedelta(cut))#the line seperate train and test part in the plot

	ax=pl.gca()#get current axex
	ax.xaxis.set_major_formatter(DateFormatter('%Y%m%d'))
	ax.xaxis.set_major_locator(xmajorLocator)
	ax.xaxis.set_minor_locator(xminorLocator)

	pl.title(artist_id)
	pl.xlabel('date')
	pl.ylabel('play_time')
	pl.figlegend((act_line,pred_line),('Actual play count','Predict play count'),'upper right')
	
	pl.savefig(artist_id+".png")
	pl.show()



def myplot(act_data,pred_data,cut,date):
	act_line=pl.plot(date,act_data,'r')
	pred_line=pl.plot(date,pred_data,'g')
	pl.axvline(x=cut)
	pl.title("test")

	pl.show()


def main():
	artist_id='aaa'
	act_data=[15,8,4,9,6,7,8,9,3,5]*10
	pred_data=[12,7,5,8,2,6,1,9,3,6]*10
	cut=55
	datePlot(artist_id,act_data,pred_data,cut)

if __name__ == '__main__':
	main()
