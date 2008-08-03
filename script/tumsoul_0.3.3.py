#!/usr/bin/python
import socket,md5,string,time,os,sys,random,urllib

##### CONFIG :-) ##########
tumsoul_server = ('10.42.1.59', 4242)
testlink_server = ('10.253.4.19', 80)
testlink_server2 = ('10.42.4.20',  80)
user = 'berard_a'
password = 'zgivRn_J'
location = urllib.quote("Tumsoul 0.3.3")
useragent = urllib.quote("tumsoul v0.3 [%d]"%os.getpid())
states = ["actif", "away"]
delays = [ 10 ] + [ 4242 ]*10 + [ 424 ]*10

def md5sum(str):
	chk = md5.new()
	chk.update(str)
	return chk.digest()

def hexify(str):
	return string.join(map(lambda c:"%02x"%ord(c),str),"")

def expect(file,str):
	reply = file.readline()[:-1]
	if reply[:len(str)]==str: return
	print "Invalid reply : '%s*' expected, '%s' received."%(str,reply)
	time.sleep(3)
	sys.exit()

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(tumsoul_server)
f=s.makefile()
cmd,code,hash,ip,port,timestamp=string.split(f.readline()[:-1])
sum=md5sum("%s-%s/%s%s"%(hash,ip,port,password))
authreply=hexify(sum)
s.send("auth_ag ext_user none none\n")
expect(f,"rep 002 --")
s.send("ext_user_log %s %s %s %s\n"%(user,authreply,location,useragent))
expect(f,"rep 002 --")
print "Authentication complete, proceeding..."
statechange_deadline = string.atoi(timestamp)
ping_deadline = string.atoi(timestamp)
ping_delay = 40
check_delay = 10
check_deadline = string.atoi(timestamp)
localtime = string.atoi(timestamp)
while 1:
	localtime += 1
	if localtime > ping_deadline:
		ping_deadline += ping_delay
		#print "Ping..."
		s.send("ping\n")
	if localtime > statechange_deadline:
		delay = random.choice(delays)
		newstate = random.choice(states)
		statechange_deadline+=delay
		#print "Newstate : %s, next change in %d seconds..."%(newstate,delay)
		s.send("state %s:%i\n"%(newstate,int(localtime)))
	if localtime > check_deadline:
		scheck = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		try: scheck.connect(testlink_server)
		except:
			print "Could not connect to %s:%d, trying next server in 5 seconds..."%testlink_server
			time.sleep(5)
			try: scheck.connect(testlink_server2)
			except:
				print "Could not connect to %s:%d, exitting in 5 seconds..."%testlink_server2
                        	time.sleep(5)
				sys.exit()
		print "Connection to %s:%d OK."%testlink_server
		scheck.close()
		check_deadline+=check_delay
	time.sleep(1)



